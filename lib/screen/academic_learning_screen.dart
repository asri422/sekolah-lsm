import 'package:flutter/material.dart';
import 'home_screen.dart';
import 'profile_screen.dart';
import 'notifikasi_screen.dart';
import 'quiz_screen.dart';
import 'dashboard_screen.dart';
import 'academic_screen.dart';
import '../user_data.dart';
import 'dart:math';

class AcademicLearningScreen extends StatefulWidget {
  final String userName;
  final String selectedTeacher;

  const AcademicLearningScreen({
    required this.userName,
    required this.selectedTeacher,
  });

  @override
  _AcademicLearningScreenState createState() => _AcademicLearningScreenState();
}

class _AcademicLearningScreenState extends State<AcademicLearningScreen> {
  int _currentStep = 0;
  int _selectedIndex = 1; // Academic tab selected by default
  List<Map<String, dynamic>> _tasks = [];
  bool _showSchedule = false;

  // Sample learning content data
  List<Map<String, dynamic>> _learningContent = [
    {
      'title': 'Pengantar User Interface Design',
      'subject': 'Algoritma',
      'teacher': 'Bapak Hamzah',
      'content':
          'Desain antarmuka pengguna (User Interface Design) adalah proses merancang antarmuka untuk perangkat lunak atau sistem digital dengan fokus pada penampilan dan interaktivitas. UI yang baik memungkinkan pengguna untuk berinteraksi dengan sistem secara efisien dan menyenangkan.',
      'topics': [
        'Pengertian UI',
        'Prinsip Desain UI',
        'Elemen UI',
        'Konsistensi UI',
      ],
      'duration': '15 menit',
      'progress': 0.3,
      'taskId': 1,
    },
    {
      'title': 'Konsep Dasar Data Mining',
      'subject': 'Data Mining',
      'teacher': 'Bapak Rofiuddin',
      'content':
          'Data mining adalah proses mengekstrak informasi atau pola penting dari sejumlah besar data. Teknik ini digunakan untuk menganalisis data dari berbagai perspektif dan merangkumnya menjadi informasi yang berguna.',
      'topics': [
        'Pengertian Data Mining',
        'Proses Data Mining',
        'Algoritma Data Mining',
        'Aplikasi Data Mining',
      ],
      'duration': '20 menit',
      'progress': 0.5,
      'taskId': 2,
    },
    {
      'title': 'Sistem Pendukung Keputusan',
      'subject': 'SPK',
      'teacher': 'Bapak Hamzah',
      'content':
          'Sistem Pendukung Keputusan (SPK) adalah sistem informasi yang dirancang untuk membantu pengambilan keputusan dengan menggunakan model dan data. SPK digunakan untuk membantu manajer dalam membuat keputusan yang semi-struktural dan non-struktural.',
      'topics': [
        'Pengertian SPK',
        'Komponen SPK',
        'Jenis-jenis SPK',
        'Implementasi SPK',
      ],
      'duration': '25 menit',
      'progress': 0.7,
      'taskId': 3,
    },
    {
      'title': 'Konsep Jaringan Komputer',
      'subject': 'Jaringan',
      'teacher': 'Bapak Rofiuddin',
      'content':
          'Jaringan komputer adalah sistem yang terdiri dari komputer-komputer yang saling terhubung untuk berbagi informasi dan sumber daya. Jaringan memungkinkan komputer untuk berkomunikasi dan berbagi data secara efisien.',
      'topics': [
        'Pengertian Jaringan',
        'Topologi Jaringan',
        'Protokol Jaringan',
        'Keamanan Jaringan',
      ],
      'duration': '18 menit',
      'progress': 1.0,
      'taskId': 4,
    },
  ];

  @override
  void initState() {
    super.initState();
    _loadTasks();
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

  Future<void> _updateProfileStatistics() async {
    // Increment enrolled courses count when completing learning material
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
                                builder: (context) => AcademicScreen(
                                  userName: widget.userName,
                                  enrolledTeachers: [],
                                ),
                              ),
                            );
                          },
                        ),
                        const SizedBox(width: 10),
                        const Text(
                          "Akademik",
                          style: TextStyle(
                            fontSize: 24,
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

              // Learning Content
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
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Progress indicator
                        Container(
                          padding: const EdgeInsets.all(15),
                          decoration: BoxDecoration(
                            color: Colors.blue[50],
                            borderRadius: BorderRadius.circular(15),
                          ),
                          child: Column(
                            children: [
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    "Progress: ${(_learningContent[_currentStep]['progress'] * 100).toInt()}%",
                                    style: const TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.blue,
                                    ),
                                  ),
                                  Text(
                                    "${_currentStep + 1}/${_learningContent.length}",
                                    style: const TextStyle(
                                      fontSize: 16,
                                      color: Colors.grey,
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 10),
                              LinearProgressIndicator(
                                value:
                                    _learningContent[_currentStep]['progress'],
                                backgroundColor: Colors.grey[300],
                                valueColor: const AlwaysStoppedAnimation<Color>(
                                  Colors.blue,
                                ),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(height: 20),

                        // Content Card
                        Expanded(
                          child: Container(
                            padding: const EdgeInsets.all(15),
                            decoration: BoxDecoration(
                              color: Colors.grey[100],
                              borderRadius: BorderRadius.circular(15),
                            ),
                            child: SingleChildScrollView(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  // Content Header
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Expanded(
                                        child: Text(
                                          _learningContent[_currentStep]['title'],
                                          style: const TextStyle(
                                            fontSize: 18,
                                            fontWeight: FontWeight.bold,
                                            color: Colors.black,
                                          ),
                                        ),
                                      ),
                                      Container(
                                        padding: const EdgeInsets.symmetric(
                                          horizontal: 10,
                                          vertical: 5,
                                        ),
                                        decoration: BoxDecoration(
                                          color: Colors.blue[100],
                                          borderRadius: BorderRadius.circular(
                                            10,
                                          ),
                                        ),
                                        child: Text(
                                          _learningContent[_currentStep]['duration'],
                                          style: const TextStyle(
                                            fontSize: 12,
                                            color: Colors.blue,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                  const SizedBox(height: 10),
                                  Text(
                                    _learningContent[_currentStep]['subject'],
                                    style: TextStyle(
                                      fontSize: 14,
                                      color: Colors.grey[600],
                                    ),
                                  ),
                                  Text(
                                    _learningContent[_currentStep]['teacher'],
                                    style: TextStyle(
                                      fontSize: 14,
                                      color: Colors.grey[600],
                                    ),
                                  ),
                                  const SizedBox(height: 15),

                                  // Content
                                  Text(
                                    _learningContent[_currentStep]['content'],
                                    style: const TextStyle(
                                      fontSize: 14,
                                      color: Colors.black87,
                                      height: 1.5,
                                    ),
                                  ),
                                  const SizedBox(height: 20),

                                  // Topics
                                  const Text(
                                    "Topik Pembahasan:",
                                    style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.black,
                                    ),
                                  ),
                                  const SizedBox(height: 10),
                                  ..._learningContent[_currentStep]['topics']
                                      .map<Widget>(
                                        (topic) => Padding(
                                          padding: const EdgeInsets.only(
                                            bottom: 8.0,
                                          ),
                                          child: Row(
                                            children: [
                                              Container(
                                                width: 8,
                                                height: 8,
                                                decoration: BoxDecoration(
                                                  color: Colors.blue,
                                                  shape: BoxShape.circle,
                                                ),
                                              ),
                                              const SizedBox(width: 10),
                                              Text(
                                                topic,
                                                style: const TextStyle(
                                                  fontSize: 14,
                                                  color: Colors.black87,
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      )
                                      .toList(),
                                ],
                              ),
                            ),
                          ),
                        ),

                        const SizedBox(height: 15),

                        // Schedule View
                        _buildScheduleView(),

                        const SizedBox(height: 20),

                        // Navigation Buttons
                        Row(
                          children: [
                            Expanded(
                              child: ElevatedButton(
                                onPressed: _currentStep > 0
                                    ? () {
                                        setState(() {
                                          _currentStep--;
                                        });
                                      }
                                    : null,
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: Colors.grey,
                                  foregroundColor: Colors.white,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(30),
                                  ),
                                  padding: const EdgeInsets.symmetric(
                                    vertical: 15,
                                  ),
                                ),
                                child: const Text(
                                  "Sebelumnya",
                                  style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            ),
                            const SizedBox(width: 10),
                            Expanded(
                              child: ElevatedButton(
                                onPressed:
                                    _currentStep < _learningContent.length - 1
                                    ? () {
                                        setState(() {
                                          _currentStep++;
                                        });
                                      }
                                    : () async {
                                        // Update profile statistics when completing learning material
                                        await _updateProfileStatistics();
                                        // Navigate to quiz screen when finished
                                        Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                            builder: (context) => QuizScreen(
                                              userName: widget.userName,
                                            ),
                                          ),
                                        );
                                      },
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: Colors.blue,
                                  foregroundColor: Colors.white,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(30),
                                  ),
                                  padding: const EdgeInsets.symmetric(
                                    vertical: 15,
                                  ),
                                ),
                                child: Text(
                                  _currentStep < _learningContent.length - 1
                                      ? "Lanjutkan"
                                      : "Kerjakan Kuis",
                                  style: const TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                  ),
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
        ),
      ),
      bottomNavigationBar: _buildBottomNavigationBar(),
    );
  }

  Widget _buildBottomNavigationBar() {
    return BottomNavigationBar(
      type: BottomNavigationBarType.fixed,
      backgroundColor: Colors.blue[600],
      selectedItemColor: Colors.white,
      unselectedItemColor: Colors.white70,
      currentIndex: _selectedIndex,
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
