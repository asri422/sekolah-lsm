import 'package:flutter/material.dart';
import 'dart:async';
import 'package:intl/intl.dart';
import 'teacher_detail_screen.dart'; // Import teacher detail screen
import 'email_service.dart'; // Import email service
import 'academic_screen.dart'; // Import academic screen
import 'notifikasi_screen.dart'; // Import notifications screen
import 'quiz_screen.dart'; // Import quiz screen
import 'dashboard_screen.dart'; // Import dashboard screen
import 'profile_screen.dart'; // Import profile screen

class HomeScreen extends StatefulWidget {
  final String userName;
  final String userEmail; // Add user email parameter

  const HomeScreen({
    super.key,
    required this.userName,
    this.userEmail = "user@example.com",
  });

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late Timer _timer;
  String _currentTime = '';
  int _selectedIndex = 0;
  bool _isVisible = false;
  bool _isSidebarOpen = false;
  String _searchQuery = '';
  bool _showSearchResults = false;
  List<Map<String, dynamic>> _searchResults = [];
  List<Map<String, dynamic>> _allSubjects = []; // Store all subjects data

  @override
  void initState() {
    super.initState();
    _updateTime();
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      _updateTime();
    });

    // Add blinking effect when the screen is first loaded
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _startBlinkingEffect();
    });

    // Initialize subjects data
    _initializeSubjectsData();
  }

  void _startBlinkingEffect() {
    setState(() {
      _isVisible = true;
    });

    // Create blinking effect by toggling visibility
    Timer.periodic(const Duration(milliseconds: 500), (timer) {
      if (mounted) {
        setState(() {
          _isVisible = !_isVisible;
        });
      } else {
        timer.cancel();
      }
    });

    // Stop blinking after 3 seconds
    Timer(const Duration(seconds: 3), () {
      if (mounted) {
        setState(() {
          _isVisible = true; // Make sure it's visible after blinking stops
        });
      }
    });
  }

  void _initializeSubjectsData() {
    _allSubjects = [
      {
        'name': 'Algoritma',
        'description':
            'Ilmu yang mempelajari tentang langkah-langkah sistematis untuk menyelesaikan masalah.',
        'example':
            'Contoh: Algoritma pengurutan data seperti Bubble Sort, Quick Sort, dan Merge Sort.',
        'teacher': 'Bapak Hamzah',
        'teacherSubject': 'Linear Algebra',
        'teacherDescription': 'Kode Pemrograman & Algoritma',
        'likes': 1581,
      },
      {
        'name': 'Data Mining',
        'description':
            'Proses mengekstrak informasi atau pola penting dari sejumlah besar data.',
        'example':
            'Contoh: Menganalisis data pembelian pelanggan untuk menemukan pola pembelian.',
        'teacher': 'Bapak Rofiuddin',
        'teacherSubject': 'HCI Lecturer',
        'teacherDescription': 'Desain UI/UX',
        'likes': 1581,
      },
      {
        'name': 'Sistem Pendukung Keputusan (SPK)',
        'description':
            'Sistem informasi yang dirancang untuk membantu pengambilan keputusan dengan menggunakan model dan data.',
        'example':
            'Contoh: Sistem yang membantu manajer dalam memilih supplier terbaik berdasarkan beberapa kriteria.',
        'teacher': 'Bapak Rofiuddin',
        'teacherSubject': 'HCI Lecturer',
        'teacherDescription': 'Desain UI/UX',
        'likes': 1581,
      },
      {
        'name': 'Jaringan Komputer',
        'description':
            'Sistem yang terdiri dari komputer-komputer yang saling terhubung untuk berbagi informasi dan sumber daya.',
        'example':
            'Contoh: Jaringan lokal (LAN), jaringan luas (WAN), dan internet.',
        'teacher': 'Bapak Hamzah',
        'teacherSubject': 'Linear Algebra',
        'teacherDescription': 'Kode Pemrograman & Algoritma',
        'likes': 1581,
      },
    ];
  }

  void _performSearch(String query) {
    setState(() {
      _searchQuery = query;
      if (query.isEmpty) {
        _showSearchResults = false;
      } else {
        _searchResults = _allSubjects
            .where(
              (subject) =>
                  subject['name'].toLowerCase().contains(query.toLowerCase()) ||
                  subject['description'].toLowerCase().contains(
                    query.toLowerCase(),
                  ) ||
                  subject['example'].toLowerCase().contains(
                    query.toLowerCase(),
                  ) ||
                  subject['teacher'].toLowerCase().contains(
                    query.toLowerCase(),
                  ),
            )
            .toList();
        _showSearchResults = true;
      }
    });
  }

  void _filterByCategory(String category) {
    setState(() {
      _searchQuery = category;
      _searchResults = _allSubjects
          .where(
            (subject) =>
                subject['name'].toLowerCase().contains(
                  category.toLowerCase(),
                ) ||
                subject['teacher'].toLowerCase().contains(
                  category.toLowerCase(),
                ),
          )
          .toList();
      _showSearchResults = true;
    });
  }

  Widget _buildSearchResults() {
    if (_searchResults.isEmpty) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.search_off, size: 60, color: Colors.white70),
            const SizedBox(height: 10),
            const Text(
              "Materi tidak ditemukan",
              style: TextStyle(fontSize: 16, color: Colors.white70),
            ),
          ],
        ),
      );
    }

    return ListView.builder(
      shrinkWrap: true,
      physics:
          const NeverScrollableScrollPhysics(), // Disable scrolling for inner list
      itemCount: _searchResults.length,
      itemBuilder: (context, index) {
        var subject = _searchResults[index];
        return _buildSubjectCard(subject);
      },
    );
  }

  Widget _buildSubjectCard(Map<String, dynamic> subject) {
    return Container(
      margin: const EdgeInsets.only(bottom: 15),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(15),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 10,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.all(15),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Subject Name
            Text(
              subject['name'],
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Colors.blue,
              ),
            ),
            const SizedBox(height: 8),
            // Description
            Text(
              subject['description'],
              style: const TextStyle(fontSize: 14, color: Colors.grey),
            ),
            const SizedBox(height: 8),
            // Example
            Text(
              subject['example'],
              style: const TextStyle(
                fontSize: 13,
                fontStyle: FontStyle.italic,
                color: Colors.black54,
              ),
            ),
            const SizedBox(height: 10),
            // Teacher Info
            Row(
              children: [
                // Teacher Avatar
                Container(
                  width: 40,
                  height: 40,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: Colors.blue[100],
                  ),
                  child: const Icon(Icons.person, color: Colors.blue, size: 20),
                ),
                const SizedBox(width: 10),
                // Teacher Details
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        subject['teacher'],
                        style: const TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                          color: Colors.black,
                        ),
                      ),
                      Text(
                        subject['teacherSubject'],
                        style: TextStyle(fontSize: 12, color: Colors.grey[600]),
                      ),
                    ],
                  ),
                ),
                // Like and Bookmark Icons
                Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Row(
                      children: [
                        Icon(
                          Icons.thumb_up,
                          color: Colors.orange[600],
                          size: 16,
                        ),
                        const SizedBox(width: 3),
                        Text(
                          subject['likes'].toString(),
                          style: const TextStyle(
                            fontSize: 12,
                            color: Colors.grey,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 8),
                    Icon(
                      Icons.bookmark_border,
                      color: Colors.grey[600],
                      size: 16,
                    ),
                  ],
                ),
              ],
            ),
            const SizedBox(height: 10),
            // Enroll Button
            Align(
              alignment: Alignment.centerRight,
              child: ElevatedButton(
                onPressed: () {
                  // Navigate to academic screen with enrollment
                  _navigateToTeacherDetail(
                    subject['teacher'],
                    subject['teacher'],
                    subject['name'],
                  );
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blue,
                  foregroundColor: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                ),
                child: const Text("Enroll"),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _updateTime() {
    if (mounted) {
      setState(() {
        _currentTime = DateFormat('HH:mm').format(DateTime.now());
      });
    }
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });

    // Navigate based on the selected index
    switch (index) {
      case 0: // Home - stay on current screen
        break;
      case 1: // Academic - navigate to Academic screen
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => AcademicScreen(
              userName: widget.userName,
              enrolledTeachers:
                  [], // You can pass actual enrolled teachers here
            ),
          ),
        );
        break;
      case 2: // Ideas
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => QuizScreen(userName: widget.userName),
          ),
        );
        break;
      case 3: // Notifications - navigate to Notifications screen
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => NotifikasiScreen(userName: widget.userName),
          ),
        );
        break;
      case 4: // Profile - navigate to profile screen
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => ProfileScreen(userName: widget.userName),
          ),
        );
        break;
    }
  }

  void _toggleSidebar() {
    setState(() {
      _isSidebarOpen = !_isSidebarOpen;
    });
  }

  // Function to send data to email
  void _sendDataToEmail(String teacherName) {
    // Send data to email using the email service
    EmailService.sendEnrollmentEmail(
      teacherName: teacherName,
      userName: widget.userName,
      userEmail: widget.userEmail,
    );

    // Show confirmation message
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Data sent to asriyaaa8@gmail.com for $teacherName'),
        duration: Duration(seconds: 2),
      ),
    );
  }

  // Function to navigate to academic screen directly after enrollment
  void _navigateToTeacherDetail(
    String teacherName,
    String teacherTitle,
    String subject,
  ) {
    String rating = "4.8"; // Default rating
    String processedTeacherName = teacherName;

    // Set appropriate rating and title based on teacher
    if (teacherName.contains("Rofiuddin")) {
      rating = "4.8";
      teacherTitle = "Rofiuddin S.Kom M.Kom";
      subject = "HCI Lecturer";
    } else if (teacherName.contains("Hamzah")) {
      rating = "4.7";
      teacherTitle = "Hamzah S.kom M.Kom";
      subject = "Linear Algebra";
    }

    // Send data to email when teacher is clicked
    _sendDataToEmail(teacherName);

    // Show confirmation message
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          'Enrollment request sent to asriyaaa8@gmail.com for $teacherName',
        ),
        duration: Duration(seconds: 2),
      ),
    );

    // Navigate directly to Academic screen
    Future.delayed(Duration(milliseconds: 500), () {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => AcademicScreen(
            userName: widget.userName,
            enrolledTeachers: [teacherName],
          ),
        ),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // Main Content
          AnimatedPositioned(
            duration: const Duration(milliseconds: 300),
            left: _isSidebarOpen ? 250 : 0,
            right: 0,
            top: 0,
            bottom: 0,
            child: Container(
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [Color(0xFF6A11CB), Color(0xFF2575FC)],
                ),
              ),
              child: SafeArea(
                child: Column(
                  children: [
                    // Status Bar
                    _buildStatusBar(),

                    const SizedBox(height: 20),

                    // Header with greeting and profile
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          // Greeting
                          Expanded(
                            child: Text(
                              "Hello, ${widget.userName}",
                              style: const TextStyle(
                                fontSize: 24,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                              ),
                            ),
                          ),
                          const SizedBox(width: 10),
                          // Waving emoji
                          const Text("👋", style: TextStyle(fontSize: 24)),
                          const SizedBox(width: 15),
                          // Profile picture
                          GestureDetector(
                            onTap: _toggleSidebar,
                            child: Container(
                              width: 40,
                              height: 40,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: Colors.white,
                                border: Border.all(
                                  color: Colors.white,
                                  width: 2,
                                ),
                              ),
                              child: const Icon(
                                Icons.person,
                                color: Colors.blue,
                                size: 20,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),

                    const SizedBox(height: 20),

                    // Main Banner with blinking effect
                    Expanded(
                      flex: 2,
                      child: Container(
                        margin: const EdgeInsets.symmetric(horizontal: 20),
                        decoration: BoxDecoration(
                          color: Colors.blue[300],
                          borderRadius: BorderRadius.circular(20),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.1),
                              blurRadius: 10,
                              offset: const Offset(0, 5),
                            ),
                          ],
                        ),
                        child: Stack(
                          children: [
                            // Background with graduation cap icon and text
                            Container(
                              decoration: BoxDecoration(
                                color: Colors.blue[300],
                                borderRadius: BorderRadius.circular(20),
                              ),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.only(left: 20),
                                    child: Opacity(
                                      opacity: _isVisible ? 1.0 : 0.0,
                                      child: Row(
                                        children: [
                                          Icon(
                                            Icons.school, // Graduation cap icon
                                            size: 60,
                                            color: Colors.white,
                                          ),
                                          const SizedBox(width: 15),
                                          Text(
                                            "Start Learning",
                                            style: TextStyle(
                                              fontSize: 16,
                                              fontWeight: FontWeight.bold,
                                              color: Colors.white,
                                              // fontFamily: 'TimesNewRoman', // Using Times New Roman font - requires custom font import
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),

                    const SizedBox(height: 20),

                    // Search Bar
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      child: Container(
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(30),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.1),
                              blurRadius: 10,
                              offset: const Offset(0, 5),
                            ),
                          ],
                        ),
                        child: TextField(
                          decoration: InputDecoration(
                            hintText: "what you want to learn?",
                            prefixIcon: const Icon(
                              Icons.search,
                              color: Colors.grey,
                            ),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(30),
                              borderSide: BorderSide.none,
                            ),
                            contentPadding: const EdgeInsets.symmetric(
                              horizontal: 20,
                              vertical: 15,
                            ),
                          ),
                          onChanged: _performSearch,
                        ),
                      ),
                    ),

                    const SizedBox(height: 20),

                    // Categories
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      child: SizedBox(
                        height: 40,
                        child: ListView(
                          scrollDirection: Axis.horizontal,
                          children: [
                            _buildCategoryChip("Algoritma"),
                            const SizedBox(width: 10),
                            _buildCategoryChip("Data Mining"),
                            const SizedBox(width: 10),
                            _buildCategoryChip("Jaringan"),
                            const SizedBox(width: 10),
                            _buildCategoryChip("SPK"),
                          ],
                        ),
                      ),
                    ),

                    const SizedBox(height: 20),

                    // Recommended Teachers or Search Results
                    Expanded(
                      flex: 3,
                      child: _showSearchResults
                          ? Container(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 20,
                              ),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const Text(
                                    "Search Results",
                                    style: TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white,
                                    ),
                                  ),
                                  const SizedBox(height: 15),
                                  Expanded(child: _buildSearchResults()),
                                ],
                              ),
                            )
                          : Padding(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 20,
                              ),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const Text(
                                    "Recommended Teacher",
                                    style: TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white,
                                    ),
                                  ),
                                  const SizedBox(height: 15),
                                  Expanded(
                                    child: ListView(
                                      children: [
                                        _buildTeacherCard(
                                          name: "Bapak Rofiuddin",
                                          subject: "HCI Lecturer",
                                          description: "Desain UI/UX",
                                          likes: 1581,
                                        ),
                                        const SizedBox(height: 15),
                                        _buildTeacherCard(
                                          name: "Bapak Hamzah",
                                          subject: "Linear Algebra",
                                          description:
                                              "Kode Pemrograman & Algoritma",
                                          likes: 1581,
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                    ),
                  ],
                ),
              ),
            ),
          ),

          // Sidebar
          if (_isSidebarOpen)
            Container(
              width: 300,
              decoration: BoxDecoration(
                color: Colors.white,
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.3),
                    blurRadius: 10,
                    offset: const Offset(5, 0),
                  ),
                ],
              ),
              child: SafeArea(
                child: Column(
                  children: [
                    // Profile Header
                    Container(
                      padding: const EdgeInsets.all(20),
                      decoration: BoxDecoration(color: Colors.blue[600]),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          CircleAvatar(
                            radius: 30,
                            backgroundColor: Colors.white,
                            child: const Icon(
                              Icons.person,
                              color: Colors.blue,
                              size: 30,
                            ),
                          ),
                          const SizedBox(height: 10),
                          const Text(
                            "Asri",
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          ),
                          const Text(
                            "Teknik Informatika",
                            style: TextStyle(
                              fontSize: 14,
                              color: Colors.white70,
                            ),
                          ),
                          const SizedBox(height: 5),
                          const Text(
                            "+62 812-3456-7890",
                            style: TextStyle(
                              fontSize: 12,
                              color: Colors.white70,
                            ),
                          ),
                          const Text(
                            "asriyaaa8@gmail.com",
                            style: TextStyle(
                              fontSize: 12,
                              color: Colors.white70,
                            ),
                          ),
                          const SizedBox(height: 10),
                          Row(
                            children: [
                              IconButton(
                                icon: const Icon(
                                  Icons.facebook,
                                  color: Colors.white,
                                ),
                                onPressed: () {},
                              ),
                              IconButton(
                                icon: const Icon(
                                  Icons.alternate_email,
                                  color: Colors.white,
                                ),
                                onPressed: () {},
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),

                    // Menu Items
                    Expanded(
                      child: ListView(
                        padding: EdgeInsets.zero,
                        children: [
                          _buildMenuItem(Icons.home, "Home", 0),
                          _buildMenuItem(Icons.person, "Profile", 1),
                          _buildMenuItem(Icons.info, "About Us", 2),
                          _buildMenuItem(
                            Icons.assignment,
                            "Take Assessment",
                            3,
                          ),
                          _buildMenuItem(Icons.message, "Message", 4),
                          _buildMenuItem(Icons.support, "Support", 5),
                          _buildMenuItem(Icons.schedule, "Schedule", 6),
                          _buildMenuItem(Icons.settings, "Settings", 7),
                        ],
                      ),
                    ),

                    // Footer with version and logout
                    Container(
                      padding: const EdgeInsets.all(15),
                      decoration: BoxDecoration(
                        border: Border(
                          top: BorderSide(color: Colors.grey[300]!),
                        ),
                      ),
                      child: Column(
                        children: [
                          const Text(
                            "V2.00",
                            style: TextStyle(fontSize: 12, color: Colors.grey),
                          ),
                          const SizedBox(height: 10),
                          ElevatedButton(
                            onPressed: () {
                              // Handle logout
                              Navigator.of(
                                context,
                              ).pop(); // This would go back to login
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.red,
                              foregroundColor: Colors.white,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(20),
                              ),
                            ),
                            child: const Text("Logout"),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
        ],
      ),
      bottomNavigationBar: _buildBottomNavigationBar(),
    );
  }

  Widget _buildCategoryChip(String label) {
    return GestureDetector(
      onTap: () {
        _filterByCategory(label);
      },
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 8),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20),
          border: Border.all(color: Colors.white, width: 1),
        ),
        child: Center(
          child: Text(
            label,
            style: const TextStyle(
              color: Colors.blue,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildTeacherCard({
    required String name,
    required String subject,
    required String description,
    required int likes,
  }) {
    String teacherTitle = name.contains("Rofiuddin")
        ? "Rofiuddin S.Kom M.Kom"
        : "Hamzah S.Pd M.Kom";

    return GestureDetector(
      onTap: () {
        // Navigate to teacher detail when teacher card is tapped
        _navigateToTeacherDetail(name, teacherTitle, subject);
      },
      child: Container(
        height: 120,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(15),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.1),
              blurRadius: 10,
              offset: const Offset(0, 5),
            ),
          ],
        ),
        child: Padding(
          padding: const EdgeInsets.all(15),
          child: Row(
            children: [
              // Teacher Avatar
              Container(
                width: 60,
                height: 60,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: Colors.blue[100],
                ),
                child: const Icon(Icons.person, color: Colors.blue, size: 30),
              ),
              const SizedBox(width: 15),
              // Teacher Info
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      name,
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                    ),
                    Text(
                      subject,
                      style: TextStyle(fontSize: 14, color: Colors.grey[600]),
                    ),
                    Text(
                      description,
                      style: TextStyle(fontSize: 12, color: Colors.grey[500]),
                    ),
                  ],
                ),
              ),
              // Like and Bookmark Icons
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Row(
                    children: [
                      Icon(Icons.thumb_up, color: Colors.orange[600], size: 18),
                      const SizedBox(width: 5),
                      Text(
                        likes.toString(),
                        style: const TextStyle(
                          fontSize: 12,
                          color: Colors.grey,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 10),
                  Icon(
                    Icons.bookmark_border,
                    color: Colors.grey[600],
                    size: 18,
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildMenuItem(IconData icon, String title, int index) {
    return ListTile(
      leading: Icon(icon, color: Colors.blue[600]),
      title: Text(
        title,
        style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
      ),
      onTap: () {
        // Handle menu item tap
        // For now, just close the sidebar
        setState(() {
          _isSidebarOpen = false;
        });
      },
    );
  }

  Widget _buildStatusBar() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          // Signal and WiFi indicators
          Row(
            children: [
              Icon(Icons.signal_cellular_alt, color: Colors.white, size: 18),
              const SizedBox(width: 5),
              Icon(Icons.wifi, color: Colors.white, size: 18),
            ],
          ),

          // Time
          Text(
            _currentTime,
            style: const TextStyle(
              fontSize: 16,
              color: Colors.white,
              fontWeight: FontWeight.bold,
            ),
          ),

          // Battery indicator
          Container(
            width: 30,
            height: 15,
            decoration: BoxDecoration(
              border: Border.all(color: Colors.white, width: 1),
              borderRadius: BorderRadius.circular(2),
            ),
            child: Container(
              width: 20,
              margin: const EdgeInsets.only(left: 1),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(1),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildBottomNavigationBar() {
    return BottomNavigationBar(
      type: BottomNavigationBarType.fixed,
      backgroundColor: Colors.blue[600],
      selectedItemColor: Colors.white,
      unselectedItemColor: Colors.white70,
      currentIndex: _selectedIndex,
      onTap: _onItemTapped,
      items: const [
        BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Beranda'),
        BottomNavigationBarItem(icon: Icon(Icons.book), label: 'Kelas'),
        BottomNavigationBarItem(icon: Icon(Icons.lightbulb), label: 'Ideas'),
        BottomNavigationBarItem(
          icon: Icon(Icons.notifications),
          label: 'Notifikasi',
        ),
        BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Profil'),
      ],
    );
  }
}
