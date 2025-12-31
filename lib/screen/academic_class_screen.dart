import 'package:flutter/material.dart';
import 'home_screen.dart';
import 'profile_screen.dart';
import 'notifikasi_screen.dart';
import 'quiz_screen.dart';
import 'dashboard_screen.dart';
import 'academic_learning_screen.dart';
import '../user_data.dart';

class AcademicClassScreen extends StatefulWidget {
  final String userName;

  const AcademicClassScreen({Key? key, required this.userName})
    : super(key: key);

  @override
  _AcademicClassScreenState createState() => _AcademicClassScreenState();
}

class _AcademicClassScreenState extends State<AcademicClassScreen> {
  List<String> _enrolledTeachers = [];
  List<Map<String, dynamic>> _classes = [];
  bool _showSchedule = false;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _loadEnrolledTeachers();
      _loadClasses();
    });
  }

  Future<void> _loadEnrolledTeachers() async {
    _enrolledTeachers = await UserData.getEnrolledTeachers();
    setState(() {});
  }

  void _loadClasses() {
    // Sample class data with progress information
    _classes = [
      {
        'id': 1,
        'code': 'UI/UX',
        'name': 'User Interface & Experience Design',
        'teacher': 'Bapak Hamzah',
        'progress': 89,
        'description':
            'Mata kuliah ini membahas desain antarmuka pengguna dan pengalaman pengguna dalam pengembangan aplikasi digital.',
        'topics': [
          'Pengantar UI/UX',
          'Prinsip Desain',
          'Prototyping',
          'User Testing',
        ],
        'duration': '12 minggu',
        'schedule': 'Senin & Rabu, 08:00-10:00',
      },
      {
        'id': 2,
        'code': 'DM',
        'name': 'Data Mining',
        'teacher': 'Bapak Rofiuddin',
        'progress': 86,
        'description':
            'Mempelajari teknik-teknik untuk mengekstrak informasi penting dari kumpulan data besar.',
        'topics': [
          'Pengantar Data Mining',
          'Clustering',
          'Classification',
          'Association Rule',
        ],
        'duration': '14 minggu',
        'schedule': 'Selasa & Kamis, 10:00-12:00',
      },
      {
        'id': 3,
        'code': 'SPK',
        'name': 'Sistem Pendukung Keputusan',
        'teacher': 'Bapak Hamzah',
        'progress': 90,
        'description':
            'Mata kuliah tentang sistem yang membantu pengambilan keputusan dengan menggunakan model dan data.',
        'topics': ['Pengantar SPK', 'Metode TOPSIS', 'AHP', 'Fuzzy Logic'],
        'duration': '12 minggu',
        'schedule': 'Jumat, 08:00-12:00',
      },
      {
        'id': 4,
        'code': 'JARKOM',
        'name': 'Jaringan Komputer',
        'teacher': 'Bapak Rofiuddin',
        'progress': 90,
        'description':
            'Mempelajari konsep dasar jaringan komputer dan protokol komunikasi.',
        'topics': [
          'Pengantar Jaringan',
          'TCP/IP',
          'Router & Switch',
          'Keamanan Jaringan',
        ],
        'duration': '16 minggu',
        'schedule': 'Rabu & Jumat, 13:00-15:00',
      },
      {
        'id': 5,
        'code': 'ALGO',
        'name': 'Algoritma dan Struktur Data',
        'teacher': 'Bapak Hamzah',
        'progress': 75,
        'description':
            'Mempelajari konsep dasar algoritma dan struktur data dalam pemrograman.',
        'topics': [
          'Pengantar Algoritma',
          'Array & Linked List',
          'Stack & Queue',
          'Tree & Graph',
        ],
        'duration': '14 minggu',
        'schedule': 'Senin & Kamis, 14:00-16:00',
      },
    ];
    setState(() {});
  }

  void addEnrolledTeacher(String teacherName) async {
    if (!_enrolledTeachers.contains(teacherName)) {
      await UserData.enrollInTeacher(teacherName);
      _enrolledTeachers = await UserData.getEnrolledTeachers();
      // Update profile statistics when enrolling in a new class
      await _updateProfileStatistics(teacherName);
      setState(() {});
    }
  }

  Future<void> _updateProfileStatistics(String teacherName) async {
    // Increment enrolled courses count when enrolling in a new class
    List<String> enrolledTeachers = await UserData.getEnrolledTeachers();
    await UserData.setEnrolledCoursesCount(enrolledTeachers.length);
  }

  String _formatDate(DateTime date) {
    return "${date.day}/${date.month}/${date.year}";
  }

  Color _getPriorityColor(String priority) {
    switch (priority.toLowerCase()) {
      case 'high':
        return Colors.red;
      case 'medium':
        return Colors.orange;
      case 'low':
        return Colors.green;
      default:
        return Colors.grey;
    }
  }

  List<Map<String, dynamic>> _getUpcomingTasks() {
    // For now, return empty list since we're focusing on classes
    return [];
  }

  Widget _buildScheduleView() {
    // For now, return empty container since we're focusing on classes
    return Container();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
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
              // Header
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        // Back button
                        IconButton(
                          icon: const Icon(
                            Icons.arrow_back,
                            color: Colors.white,
                            size: 28,
                          ),
                          onPressed: () {
                            Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                builder: (context) =>
                                    HomeScreen(userName: widget.userName),
                              ),
                            );
                          },
                        ),
                        const SizedBox(width: 10),
                        // Title
                        const Text(
                          "Kelas Saya",
                          style: TextStyle(
                            fontSize: 28,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 10),
                    Text(
                      "Hello, ${widget.userName}",
                      style: const TextStyle(
                        fontSize: 18,
                        color: Colors.white70,
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 20),

              // Classes Section
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: _classes.isEmpty
                      ? _buildEmptyState()
                      : _buildClassesList(),
                ),
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: _buildBottomNavigationBar(),
    );
  }

  Widget _buildEmptyState() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.school, size: 80, color: Colors.white.withOpacity(0.5)),
          const SizedBox(height: 20),
          const Text(
            "Belum ada kelas yang diambil",
            style: TextStyle(fontSize: 18, color: Colors.white70),
          ),
          const SizedBox(height: 10),
          const Text(
            "Mulai dengan mengikuti seorang guru di halaman utama",
            style: TextStyle(fontSize: 14, color: Colors.white70),
          ),
        ],
      ),
    );
  }

  Widget _buildClassesList() {
    return ListView.builder(
      itemCount: _classes.length,
      itemBuilder: (context, index) {
        Map<String, dynamic> classData = _classes[index];
        return _buildClassCard(classData, index);
      },
    );
  }

  Widget _buildClassCard(Map<String, dynamic> classData, int index) {
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
            Row(
              children: [
                // Class Code
                Container(
                  width: 50,
                  height: 50,
                  decoration: BoxDecoration(
                    color: Colors.blue[100],
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Center(
                    child: Text(
                      classData['code'],
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Colors.blue,
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 15),
                // Class Info
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        classData['name'],
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                        ),
                      ),
                      Text(
                        "Dosen: ${classData['teacher']}",
                        style: TextStyle(fontSize: 14, color: Colors.grey[600]),
                      ),
                      Text(
                        classData['schedule'],
                        style: TextStyle(fontSize: 12, color: Colors.grey[500]),
                      ),
                    ],
                  ),
                ),
                // Progress indicator
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "${classData['progress']}%",
                      style: const TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                        color: Colors.blue,
                      ),
                    ),
                    const SizedBox(height: 5),
                    Container(
                      width: 40,
                      height: 40,
                      child: CircularProgressIndicator(
                        value: classData['progress'] / 100,
                        strokeWidth: 4,
                        backgroundColor: Colors.grey[200],
                        valueColor: const AlwaysStoppedAnimation<Color>(
                          Colors.blue,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
            const SizedBox(height: 15),
            // Progress bar
            LinearProgressIndicator(
              value: classData['progress'] / 100,
              backgroundColor: Colors.grey[200],
              valueColor: const AlwaysStoppedAnimation<Color>(Colors.blue),
            ),
            const SizedBox(height: 10),
            Text(
              "${classData['progress']}% Selesai",
              style: const TextStyle(fontSize: 12, color: Colors.grey),
            ),
            const SizedBox(height: 10),
            // View Details Button
            Align(
              alignment: Alignment.centerRight,
              child: ElevatedButton(
                onPressed: () {
                  _showClassDetails(classData);
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blue,
                  foregroundColor: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                ),
                child: const Text("Lihat Detail"),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _showClassDetails(Map<String, dynamic> classData) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(classData['name']),
          content: SizedBox(
            width: double.maxFinite,
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Kode Kelas: ${classData['code']}",
                    style: const TextStyle(fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 5),
                  Text(
                    "Dosen: ${classData['teacher']}",
                    style: const TextStyle(fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 5),
                  Text(
                    "Durasi: ${classData['duration']}",
                    style: const TextStyle(fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 5),
                  Text(
                    "Jadwal: ${classData['schedule']}",
                    style: const TextStyle(fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 10),
                  const Text(
                    "Deskripsi:",
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  Text(classData['description']),
                  const SizedBox(height: 10),
                  const Text(
                    "Topik Pembahasan:",
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  ...classData['topics']
                      .map<Widget>(
                        (topic) => Padding(
                          padding: const EdgeInsets.only(left: 10, top: 5),
                          child: Row(
                            children: [
                              Container(
                                width: 6,
                                height: 6,
                                decoration: BoxDecoration(
                                  color: Colors.blue,
                                  shape: BoxShape.circle,
                                ),
                              ),
                              const SizedBox(width: 8),
                              Text(topic),
                            ],
                          ),
                        ),
                      )
                      .toList(),
                ],
              ),
            ),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text("Tutup"),
            ),
          ],
        );
      },
    );
  }

  Widget _buildBottomNavigationBar() {
    return BottomNavigationBar(
      type: BottomNavigationBarType.fixed,
      backgroundColor: Colors.blue[600],
      selectedItemColor: Colors.white,
      unselectedItemColor: Colors.white70,
      currentIndex: 1, // Academic tab selected
      items: const [
        BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Beranda'),
        BottomNavigationBarItem(icon: Icon(Icons.school), label: 'Akademik'),
        BottomNavigationBarItem(icon: Icon(Icons.lightbulb), label: 'Ideas'),
        BottomNavigationBarItem(
          icon: Icon(Icons.notifications),
          label: 'Notifikasi',
        ),
        BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Profil'),
      ],
      onTap: (index) {
        // Handle navigation
        switch (index) {
          case 0: // Home
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                builder: (context) => HomeScreen(userName: widget.userName),
              ),
            );
            break;
          case 1: // Academic - stay on current screen
            break;
          case 2: // Ideas
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                builder: (context) => QuizScreen(userName: widget.userName),
              ),
            );
            break;
          case 3: // Notifications
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                builder: (context) =>
                    NotifikasiScreen(userName: widget.userName),
              ),
            );
            break;
          case 4: // Profile
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                builder: (context) => ProfileScreen(userName: widget.userName),
              ),
            );
            break;
        }
      },
    );
  }
}
