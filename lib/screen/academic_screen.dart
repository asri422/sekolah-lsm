import 'package:flutter/material.dart';
import 'home_screen.dart'; // Import home screen
import 'notifikasi_screen.dart'; // Import notifications screen
import 'quiz_screen.dart'; // Import quiz screen
import 'profile_screen.dart'; // Import profile screen
import 'dashboard_screen.dart'; // Import dashboard screen
import 'academic_learning_screen.dart'; // Import academic learning screen
import 'academic_class_screen.dart'; // Import academic class screen
import '../user_data.dart'; // Import user data

class AcademicScreen extends StatefulWidget {
  final String userName;
  final List<String> enrolledTeachers;

  const AcademicScreen({
    Key? key,
    this.userName = "User",
    this.enrolledTeachers = const [],
  }) : super(key: key);

  @override
  _AcademicScreenState createState() => _AcademicScreenState();
}

class _AcademicScreenState extends State<AcademicScreen> {
  List<String> _enrolledTeachers = [];
  List<Map<String, dynamic>> _tasks = [];
  bool _showSchedule = false;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _loadEnrolledTeachers();
      _loadTasks();
    });
  }

  Future<void> _loadEnrolledTeachers() async {
    _enrolledTeachers = await UserData.getEnrolledTeachers();
    setState(() {});
  }

  void _loadTasks() {
    // Sample tasks data
    _tasks = [
      {
        'id': 1,
        'title': 'Tugas UI Design',
        'subject': 'Algoritma',
        'teacher': 'Bapak Hamzah',
        'dueDate': DateTime.now().add(Duration(days: 3)),
        'status': 'Pending',
        'priority': 'High',
        'relatedContent': 'Pengantar User Interface Design',
      },
      {
        'id': 2,
        'title': 'Analisis Data Mining',
        'subject': 'Data Mining',
        'teacher': 'Bapak Rofiuddin',
        'dueDate': DateTime.now().add(Duration(days: 5)),
        'status': 'In Progress',
        'priority': 'Medium',
        'relatedContent': 'Konsep Dasar Data Mining',
      },
      {
        'id': 3,
        'title': 'SPK Case Study',
        'subject': 'SPK',
        'teacher': 'Bapak Hamzah',
        'dueDate': DateTime.now().add(Duration(days: 7)),
        'status': 'Not Started',
        'priority': 'Low',
        'relatedContent': 'Sistem Pendukung Keputusan',
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

      // Show success message
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Berhasil mendaftar kelas $teacherName'),
          backgroundColor: Colors.green,
        ),
      );
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
    return _tasks
        .where((task) => task['dueDate'].isAfter(DateTime.now()))
        .toList()
      ..sort((a, b) => a['dueDate'].compareTo(b['dueDate']));
  }

  Widget _buildScheduleView() {
    List<Map<String, dynamic>> upcomingTasks = _getUpcomingTasks();

    return Container(
      padding: const EdgeInsets.all(15),
      decoration: BoxDecoration(
        color: Colors.grey[100],
        borderRadius: BorderRadius.circular(15),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                "Jadwal Tugas",
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),
              ElevatedButton(
                onPressed: () {
                  setState(() {
                    _showSchedule = !_showSchedule;
                  });
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blue,
                  foregroundColor: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                ),
                child: Text(_showSchedule ? "Sembunyikan" : "Tampilkan"),
              ),
            ],
          ),
          const SizedBox(height: 10),
          if (_showSchedule)
            ...upcomingTasks.map(
              (task) => Padding(
                padding: const EdgeInsets.only(bottom: 10),
                child: Container(
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(
                      color: _getPriorityColor(task['priority']),
                      width: 2,
                    ),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        task['title'],
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 14,
                        ),
                      ),
                      Text(
                        "Mata Kuliah: ${task['subject']}",
                        style: const TextStyle(fontSize: 12),
                      ),
                      Text(
                        "Guru: ${task['teacher']}",
                        style: const TextStyle(fontSize: 12),
                      ),
                      Row(
                        children: [
                          Text(
                            "Batas Waktu: ${_formatDate(task['dueDate'])}",
                            style: const TextStyle(fontSize: 12),
                          ),
                          const SizedBox(width: 10),
                          Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 8,
                              vertical: 2,
                            ),
                            decoration: BoxDecoration(
                              color: _getPriorityColor(task['priority']),
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: Text(
                              task['priority'],
                              style: const TextStyle(
                                color: Colors.white,
                                fontSize: 10,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
        ],
      ),
    );
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
                          "Kelas Akademik",
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
                      "Hello, {asri}",
                      style: const TextStyle(
                        fontSize: 18,
                        color: Colors.white70,
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 20),

              // Schedule View
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: _buildScheduleView(),
              ),

              const SizedBox(height: 20),

              // Enrolled Teachers Section
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: _enrolledTeachers.isEmpty
                      ? _buildEmptyState()
                      : _buildEnrolledTeachersList(),
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
            "Belum ada guru yang diikuti",
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

  Widget _buildEnrolledTeachersList() {
    return ListView.builder(
      itemCount: _enrolledTeachers.length,
      itemBuilder: (context, index) {
        String teacherName = _enrolledTeachers[index];
        return _buildTeacherCard(teacherName, index);
      },
    );
  }

  Widget _buildTeacherCard(String teacherName, int index) {
    // Extract teacher info for display
    String name = teacherName.contains("Rofiuddin")
        ? "Bapak Rofiuddin"
        : "Bapak Hamzah";
    String subject = teacherName.contains("Rofiuddin")
        ? "HCI Lecturer"
        : "Linear Algebra";
    String description = teacherName.contains("Rofiuddin")
        ? "Desain UI/UX"
        : "Kode Pemrograman & Algoritma";
    int likes = 1581;

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
                // Teacher Avatar
                Container(
                  width: 50,
                  height: 50,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: Colors.blue[100],
                  ),
                  child: const Icon(Icons.person, color: Colors.blue, size: 25),
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
                        Icon(
                          Icons.thumb_up,
                          color: Colors.orange[600],
                          size: 16,
                        ),
                        const SizedBox(width: 3),
                        Text(
                          likes.toString(),
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
            const SizedBox(height: 15),
            // Continue Learning Button
            Row(
              children: [
                Expanded(
                  child: ElevatedButton(
                    onPressed: () {
                      // Navigate to academic class screen
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) =>
                              AcademicClassScreen(userName: widget.userName),
                        ),
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.blue,
                      foregroundColor: Colors.white,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                    ),
                    child: const Text("Lanjutkan Belajar"),
                  ),
                ),
                const SizedBox(width: 10),
                // View Tasks Button
                ElevatedButton(
                  onPressed: () {
                    // Show task dialog
                    _showTaskDialog(teacherName);
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.grey[200],
                    foregroundColor: Colors.black,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                  ),
                  child: const Text("Tugas"),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  void _showTaskDialog(String teacherName) {
    // Sample tasks data
    List<Map<String, dynamic>> teacherTasks = [
      {
        'id': 1,
        'title': 'Tugas UI Design',
        'subject': 'Algoritma',
        'teacher': 'Bapak Hamzah',
        'dueDate': '15 Jan 2024',
        'status': 'Pending',
        'priority': 'High',
      },
      {
        'id': 2,
        'title': 'Analisis Data Mining',
        'subject': 'Data Mining',
        'teacher': 'Bapak Rofiuddin',
        'dueDate': '20 Jan 2024',
        'status': 'In Progress',
        'priority': 'Medium',
      },
    ];

    List<Map<String, dynamic>> filteredTasks = teacherTasks
        .where((task) => task['teacher'].contains(teacherName.split(" ")[1]))
        .toList();

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text("Tugas dari $teacherName"),
          content: filteredTasks.isEmpty
              ? const Text("Tidak ada tugas saat ini")
              : SizedBox(
                  width: double.maxFinite,
                  child: ListView.builder(
                    shrinkWrap: true,
                    itemCount: filteredTasks.length,
                    itemBuilder: (context, index) {
                      var task = filteredTasks[index];
                      return Card(
                        child: Padding(
                          padding: const EdgeInsets.all(10),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                task['title'],
                                style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 16,
                                ),
                              ),
                              const SizedBox(height: 5),
                              Text("Mata Kuliah: ${task['subject']}"),
                              Text("Batas Waktu: ${task['dueDate']}"),
                              Text("Status: ${task['status']}"),
                              Text("Prioritas: ${task['priority']}"),
                            ],
                          ),
                        ),
                      );
                    },
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
        BottomNavigationBarItem(icon: Icon(Icons.book), label: 'Kelas'),
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
