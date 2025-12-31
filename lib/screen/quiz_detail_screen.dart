import 'package:flutter/material.dart';
import 'quiz_screen.dart'; // Import quiz screen
import 'quiz_type_selection_screen.dart'; // Import quiz type selection screen
import 'quiz_content_screen.dart'; // Import quiz content screen
import 'academic_screen.dart'; // Import academic screen
import 'notifikasi_screen.dart'; // Import notifications screen
import 'profile_screen.dart'; // Import profile screen

class QuizDetailScreen extends StatefulWidget {
  final String userName;
  final Map<String, dynamic> quiz;

  const QuizDetailScreen({required this.userName, required this.quiz});

  @override
  _QuizDetailScreenState createState() => _QuizDetailScreenState();
}

class _QuizDetailScreenState extends State<QuizDetailScreen> {
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
                    // Back button
                    IconButton(
                      icon: const Icon(
                        Icons.arrow_back,
                        color: Colors.white,
                        size: 28,
                      ),
                      onPressed: () {
                        Navigator.pop(context);
                      },
                    ),
                    const SizedBox(height: 10),
                    Text(
                      "Hello, \${widget.userName}",
                      style: const TextStyle(
                        fontSize: 18,
                        color: Colors.white70,
                      ),
                    ),
                  ],
                ),
              ),

              // Main Content
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
                        // Quiz Title
                        Center(
                          child: Text(
                            widget.quiz['title'],
                            style: const TextStyle(
                              fontSize: 24,
                              fontWeight: FontWeight.bold,
                              color: Colors.blue,
                            ),
                          ),
                        ),
                        const SizedBox(height: 10),
                        Center(
                          child: Text(
                            widget.quiz['subject'],
                            style: TextStyle(
                              fontSize: 16,
                              color: Colors.grey[600],
                            ),
                          ),
                        ),
                        const SizedBox(height: 30),

                        // Quiz Info Cards
                        Container(
                          padding: const EdgeInsets.all(15),
                          decoration: BoxDecoration(
                            color: Colors.blue[50],
                            borderRadius: BorderRadius.circular(15),
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              _buildInfoCard(
                                Icons.question_answer,
                                widget.quiz['questions'],
                                "Questions",
                              ),
                              _buildInfoCard(
                                Icons.access_time,
                                widget.quiz['duration'],
                                "Duration",
                              ),
                              _buildInfoCard(
                                Icons.star,
                                widget.quiz['rating'],
                                "Rating",
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(height: 30),

                        // Quiz Type
                        const Text(
                          "MCQ Based Test",
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: Colors.black,
                          ),
                        ),
                        const SizedBox(height: 10),
                        Text(
                          "This quiz is designed to test your knowledge of \${widget.quiz['subject'].toLowerCase()}. "
                          "Complete all questions to assess your understanding of the topic.",
                          style: TextStyle(
                            fontSize: 16,
                            color: Colors.grey[700],
                            height: 1.5,
                          ),
                        ),
                        const SizedBox(height: 30),

                        // Rules Section
                        const Text(
                          "Quiz Rules",
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: Colors.black,
                          ),
                        ),
                        const SizedBox(height: 15),
                        _buildRuleItem(
                          Icons.check_circle,
                          "10 points for a correct answer",
                        ),
                        _buildRuleItem(
                          Icons.check_circle,
                          "No negative marking for wrong answers",
                        ),
                        _buildRuleItem(
                          Icons.check_circle,
                          "Once submitted, answers cannot be changed",
                        ),
                        _buildRuleItem(
                          Icons.check_circle,
                          "You cannot pause the quiz once started",
                        ),
                        const SizedBox(height: 30),

                        // Start Button
                        const Spacer(),
                        Container(
                          width: double.infinity,
                          height: 55,
                          margin: const EdgeInsets.only(bottom: 20),
                          child: ElevatedButton(
                            onPressed: () {
                              // Navigate to actual quiz page
                              _startQuiz();
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.blue,
                              foregroundColor: Colors.white,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(30),
                              ),
                              padding: const EdgeInsets.symmetric(vertical: 15),
                            ),
                            child: const Text(
                              "Start Now!",
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
            ],
          ),
        ),
      ),
      bottomNavigationBar: _buildBottomNavigationBar(),
    );
  }

  Widget _buildInfoCard(IconData icon, String value, String label) {
    return Column(
      children: [
        Icon(icon, color: Colors.blue, size: 30),
        const SizedBox(height: 5),
        Text(
          value,
          style: const TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: Colors.blue,
          ),
        ),
        Text(label, style: TextStyle(fontSize: 12, color: Colors.grey[600])),
      ],
    );
  }

  Widget _buildRuleItem(IconData icon, String rule) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: Row(
        children: [
          Icon(icon, color: Colors.green, size: 20),
          const SizedBox(width: 10),
          Text(rule, style: TextStyle(fontSize: 16, color: Colors.grey[700])),
        ],
      ),
    );
  }

  void _startQuiz() {
    // Show a dialog to confirm quiz start
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text("Confirm Quiz Start"),
          content: Text(
            "Are you ready to start the \${widget.quiz['title']} quiz? "
            "Remember, you cannot pause once started.",
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(); // Close dialog
              },
              child: const Text("Cancel"),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.of(context).pop(); // Close dialog
                // Navigate to quiz type selection page
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => QuizTypeSelectionScreen(
                      userName: widget.userName,
                      quiz: widget.quiz,
                    ),
                  ),
                );
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.blue,
                foregroundColor: Colors.white,
              ),
              child: const Text("Start Quiz"),
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
      currentIndex: 2, // Ideas tab selected
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
                builder: (context) => QuizScreen(userName: widget.userName),
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
