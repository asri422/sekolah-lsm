import 'package:flutter/material.dart';
import 'home_screen.dart'; // Import home screen
import 'academic_screen.dart'; // Import academic screen
import 'quiz_screen.dart'; // Import quiz screen
import 'notifikasi_screen.dart'; // Import notifications screen
import 'dashboard_screen.dart'; // Import dashboard screen

class ProfileScreen extends StatefulWidget {
  final String userName;

  const ProfileScreen({required this.userName});

  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  // Sample user data
  final String _userFullName = "Asri Barokatul Jannah";
  final String _userStatus = "MAHASISWA";
  final String _userBirthDate = "15 Juli 1999";
  final String _userBirthPlace = "Jakarta";
  final int _userClasses = 3;
  final int _userCompletedTasks = 12;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Color(0xFF8B0000),
              Color(0xFF00008B),
            ], // Dark red to dark blue gradient
          ),
        ),
        child: SafeArea(
          child: Column(
            children: [
              // Header with profile info
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(20),
                child: Column(
                  children: [
                    // Profile picture
                    Container(
                      width: 120,
                      height: 120,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        border: Border.all(color: Colors.white, width: 3),
                        color: Colors.white.withOpacity(0.2),
                      ),
                      child: const CircleAvatar(
                        backgroundColor: Colors.white,
                        radius: 55,
                        child: Icon(
                          Icons.person,
                          size: 50,
                          color: Color(0xFF8B0000), // Dark red
                        ),
                      ),
                    ),
                    const SizedBox(height: 15),
                    // User name
                    Text(
                      _userFullName,
                      style: const TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                    const SizedBox(height: 5),
                    // Status badge
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 15,
                        vertical: 5,
                      ),
                      decoration: BoxDecoration(
                        color: Colors.red,
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Text(
                        _userStatus,
                        style: const TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                ),
              ),

              // Main content
              Expanded(
                child: Container(
                  decoration: const BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(30),
                      topRight: Radius.circular(30),
                    ),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(20),
                    child: SingleChildScrollView(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // User details section
                          const Text(
                            "Detail Pengguna",
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              color: Colors.black,
                            ),
                          ),
                          const SizedBox(height: 15),

                          // User identity information
                          Container(
                            padding: const EdgeInsets.all(15),
                            decoration: BoxDecoration(
                              color: Colors.grey[100],
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: Column(
                              children: [
                                _buildInfoRow("Nama Lengkap", _userFullName),
                                const Divider(height: 20),
                                _buildInfoRow("Tanggal Lahir", _userBirthDate),
                                const Divider(height: 20),
                                _buildInfoRow("Tempat Lahir", _userBirthPlace),
                              ],
                            ),
                          ),
                          const SizedBox(height: 20),

                          // Stats section
                          const Text(
                            "Statistik Akun",
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              color: Colors.black,
                            ),
                          ),
                          const SizedBox(height: 15),

                          // Stats cards
                          Row(
                            children: [
                              Expanded(
                                child: Container(
                                  padding: const EdgeInsets.all(15),
                                  decoration: BoxDecoration(
                                    color: Colors.blue[50],
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  child: Column(
                                    children: [
                                      Text(
                                        _userClasses.toString(),
                                        style: const TextStyle(
                                          fontSize: 24,
                                          fontWeight: FontWeight.bold,
                                          color: Colors.blue,
                                        ),
                                      ),
                                      const Text(
                                        "Kelas Diikuti",
                                        style: TextStyle(
                                          fontSize: 14,
                                          color: Colors.grey,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              const SizedBox(width: 15),
                              Expanded(
                                child: Container(
                                  padding: const EdgeInsets.all(15),
                                  decoration: BoxDecoration(
                                    color: Colors.green[50],
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  child: Column(
                                    children: [
                                      Text(
                                        _userCompletedTasks.toString(),
                                        style: const TextStyle(
                                          fontSize: 24,
                                          fontWeight: FontWeight.bold,
                                          color: Colors.green,
                                        ),
                                      ),
                                      const Text(
                                        "Tugas Selesai",
                                        style: TextStyle(
                                          fontSize: 14,
                                          color: Colors.grey,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 30),

                          // Logout button
                          Container(
                            width: double.infinity,
                            height: 55,
                            margin: const EdgeInsets.only(bottom: 20),
                            child: ElevatedButton(
                              onPressed: () {
                                // Handle logout action
                                _showLogoutConfirmation();
                              },
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.red,
                                foregroundColor: Colors.white,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(30),
                                ),
                                padding: const EdgeInsets.symmetric(
                                  vertical: 15,
                                ),
                              ),
                              child: const Text(
                                "Logout",
                                style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: _buildBottomNavigationBar(),
    );
  }

  Widget _buildInfoRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 100,
            child: Text(
              label,
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                color: Colors.black54,
              ),
            ),
          ),
          const Text(
            ": ",
            style: TextStyle(
              fontWeight: FontWeight.bold,
              color: Colors.black54,
            ),
          ),
          Expanded(
            child: Text(value, style: const TextStyle(color: Colors.black87)),
          ),
        ],
      ),
    );
  }

  void _showLogoutConfirmation() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text("Konfirmasi Logout"),
          content: const Text("Apakah Anda yakin ingin logout dari aplikasi?"),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(); // Close dialog
              },
              child: const Text("Batal"),
            ),
            ElevatedButton(
              onPressed: () {
                // Perform logout action
                Navigator.of(context).pop(); // Close dialog
                // In a real app, you would clear user session here
                // For now, we'll just navigate back to login screen
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                    builder: (context) =>
                        const Placeholder(), // This would be login screen in real app
                  ),
                );
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.red,
                foregroundColor: Colors.white,
              ),
              child: const Text("Logout"),
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
      currentIndex: 4, // Profile tab selected
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
          case 1: // Academic
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                builder: (context) => AcademicScreen(userName: widget.userName),
              ),
            );
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
          case 4: // Profile - stay on current screen
            break;
        }
      },
    );
  }
}
