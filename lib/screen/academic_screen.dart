import 'package:flutter/material.dart';
import 'home_screen.dart'; // Import home screen
import 'notifikasi_screen.dart'; // Import notifications screen
import 'quiz_screen.dart'; // Import quiz screen
import 'profile_screen.dart'; // Import profile screen
import 'dashboard_screen.dart'; // Import dashboard screen

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
  late List<String> _enrolledTeachers;

  @override
  void initState() {
    super.initState();
    // Initialize with the provided enrolled teachers or an empty list
    _enrolledTeachers = List.from(widget.enrolledTeachers);
  }

  void addEnrolledTeacher(String teacherName) {
    if (!_enrolledTeachers.contains(teacherName)) {
      setState(() {
        _enrolledTeachers.add(teacherName);
      });
    }
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
                          "Akademik",
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
        child: Row(
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
                    Icon(Icons.thumb_up, color: Colors.orange[600], size: 16),
                    const SizedBox(width: 3),
                    Text(
                      likes.toString(),
                      style: const TextStyle(fontSize: 12, color: Colors.grey),
                    ),
                  ],
                ),
                const SizedBox(height: 8),
                Icon(Icons.bookmark_border, color: Colors.grey[600], size: 16),
              ],
            ),
          ],
        ),
      ),
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
