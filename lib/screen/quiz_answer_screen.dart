import 'package:flutter/material.dart';
import 'home_screen.dart'; // Import home screen
import 'academic_screen.dart'; // Import academic screen
import 'quiz_screen.dart'; // Import quiz screen
import 'notifikasi_screen.dart'; // Import notifications screen
import 'profile_screen.dart'; // Import profile screen
import 'quiz_reading_screen.dart'; // Import quiz reading screen
import 'quiz_results_screen.dart'; // Import quiz results screen

class QuizAnswerScreen extends StatefulWidget {
  final String userName;
  final Map<String, dynamic> quiz;
  final Map<String, dynamic> question;
  final int questionIndex;
  final int totalQuestions;

  const QuizAnswerScreen({
    required this.userName,
    required this.quiz,
    required this.question,
    required this.questionIndex,
    required this.totalQuestions,
  });

  @override
  _QuizAnswerScreenState createState() => _QuizAnswerScreenState();
}

class _QuizAnswerScreenState extends State<QuizAnswerScreen> {
  final TextEditingController _answerController = TextEditingController();
  List<String> _answers = [];

  @override
  void initState() {
    super.initState();
    // Initialize answers list
    _answers = List.filled(widget.totalQuestions, '');
    _answerController.text = _answers[widget.questionIndex];
  }

  @override
  void dispose() {
    _answerController.dispose();
    super.dispose();
  }

  void _submitAnswer() {
    String answer = _answerController.text.trim();
    _answers[widget.questionIndex] = answer;

    if (widget.questionIndex < widget.totalQuestions - 1) {
      // Move to next question
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => QuizReadingScreen(
            userName: widget.userName,
            quiz: widget.quiz,
            questionIndex: widget.questionIndex + 1,
          ),
        ),
      );
    } else {
      // Calculate score based on answer length (for essay questions)
      int score = 0;
      int totalPossibleScore =
          widget.totalQuestions * 10; // Assuming 10 points per question

      // For essay questions, we can calculate score based on answer length or other criteria
      for (int i = 0; i < _answers.length; i++) {
        if (_answers[i].length > 50) {
          // Minimum length for a decent answer
          score += 10; // Full points for answers with sufficient length
        } else if (_answers[i].length > 20) {
          score += 5; // Partial points for shorter but not too short answers
        }
        // Otherwise, 0 points for very short answers
      }

      // Navigate to results screen
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => QuizResultsScreen(
            userName: widget.userName,
            quiz: widget.quiz,
            score: score,
            totalPossibleScore: totalPossibleScore,
            correctAnswers: (score / 10).round(), // Approximate correct answers
            totalQuestions: widget.totalQuestions,
          ),
        ),
      );
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
                      "Hello, ${widget.userName}",
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
                        // Progress indicator
                        Row(
                          children: [
                            Container(
                              width: 40,
                              height: 40,
                              decoration: BoxDecoration(
                                color: Colors.blue,
                                borderRadius: BorderRadius.circular(20),
                              ),
                              child: Center(
                                child: Text(
                                  "${widget.questionIndex + 1}",
                                  style: const TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            ),
                            const SizedBox(width: 10),
                            Text(
                              "Question ${widget.questionIndex + 1} of ${widget.totalQuestions}",
                              style: const TextStyle(
                                fontSize: 16,
                                color: Colors.grey,
                              ),
                            ),
                            const Spacer(),
                            Text(
                              "${((widget.questionIndex + 1) / widget.totalQuestions * 100).round()}%",
                              style: const TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                color: Colors.blue,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 10),
                        LinearProgressIndicator(
                          value:
                              (widget.questionIndex + 1) /
                              widget.totalQuestions,
                          backgroundColor: Colors.grey[300],
                          valueColor: const AlwaysStoppedAnimation<Color>(
                            Colors.blue,
                          ),
                        ),
                        const SizedBox(height: 20),

                        // Question title
                        Text(
                          widget.question['title'],
                          style: const TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: Colors.black,
                          ),
                        ),
                        const SizedBox(height: 15),

                        // Question description
                        Container(
                          padding: const EdgeInsets.all(15),
                          decoration: BoxDecoration(
                            color: Colors.blue[50],
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Text(
                            widget.question['description'],
                            style: const TextStyle(
                              fontSize: 14,
                              color: Colors.black87,
                            ),
                          ),
                        ),
                        const SizedBox(height: 20),

                        // Answer input
                        const Text(
                          "Your Answer:",
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: Colors.black,
                          ),
                        ),
                        const SizedBox(height: 10),
                        Container(
                          decoration: BoxDecoration(
                            border: Border.all(color: Colors.grey),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: TextField(
                            controller: _answerController,
                            maxLines: 8,
                            decoration: const InputDecoration(
                              hintText: "Type your answer here!",
                              hintStyle: TextStyle(color: Colors.grey),
                              border: InputBorder.none,
                              contentPadding: EdgeInsets.all(15),
                            ),
                            onChanged: (value) {
                              _answers[widget.questionIndex] = value;
                            },
                          ),
                        ),
                        const SizedBox(height: 10),
                        Text(
                          "${_answerController.text.length} characters",
                          style: TextStyle(
                            fontSize: 12,
                            color: Colors.grey[600],
                          ),
                        ),

                        const SizedBox(height: 20),

                        // Submit button
                        Container(
                          width: double.infinity,
                          height: 55,
                          child: ElevatedButton(
                            onPressed: _submitAnswer,
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.blue,
                              foregroundColor: Colors.white,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(30),
                              ),
                              padding: const EdgeInsets.symmetric(vertical: 15),
                            ),
                            child: Text(
                              widget.questionIndex < widget.totalQuestions - 1
                                  ? "Submit & Next"
                                  : "Submit Quiz",
                              style: const TextStyle(
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
