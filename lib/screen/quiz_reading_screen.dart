import 'package:flutter/material.dart';
import 'home_screen.dart'; // Import home screen
import 'academic_screen.dart'; // Import academic screen
import 'quiz_screen.dart'; // Import quiz screen
import 'notifikasi_screen.dart'; // Import notifications screen
import 'profile_screen.dart'; // Import profile screen
import 'quiz_answer_screen.dart'; // Import quiz answer screen

class QuizReadingScreen extends StatefulWidget {
  final String userName;
  final Map<String, dynamic> quiz;
  final int questionIndex;

  const QuizReadingScreen({
    required this.userName,
    required this.quiz,
    this.questionIndex = 0,
  });

  @override
  _QuizReadingScreenState createState() => _QuizReadingScreenState();
}

class _QuizReadingScreenState extends State<QuizReadingScreen> {
  @override
  Widget build(BuildContext context) {
    // Sample questions data - in a real app, this would come from an API or database
    List<Map<String, dynamic>> questions = [
      {
        'title': 'What is the meaning of UI UX Design?',
        'description':
            'UI (User Interface) refers to the visual elements of a product, while UX (User Experience) refers to the overall experience of using the product. Together, they form the foundation of creating digital products that are both beautiful and functional.',
        'story':
            'In the bustling city of Techville, there lived a young designer named Alex. Alex was passionate about creating digital experiences that made people\'s lives easier. One day, Alex received a project to redesign an app for a local restaurant. The challenge was not just about making it look beautiful, but ensuring that every user could navigate it effortlessly, whether they were tech-savvy teenagers or elderly customers. This is where UI/UX Design came into play - making the interface beautiful while ensuring the experience was intuitive for all users.',
        'minWords': 100,
      },
      {
        'title': 'Explain Design Thinking Process',
        'description':
            'Design Thinking is a human-centered approach to innovation that draws from the designer\'s toolkit to integrate the needs of people, the possibilities of technology, and the requirements for business success.',
        'story':
            'At the Innovation Hub of Techville, a team of designers led by Maya were facing a challenge. They needed to create a new educational platform for children with learning disabilities. Traditional approaches had failed, so Maya introduced Design Thinking. They started by empathizing with the children, then defined the core problems, ideated various solutions, created prototypes, and tested them with the children. This iterative process led to a revolutionary platform that transformed how these children learned.',
        'minWords': 150,
      },
      {
        'title': 'The Role of User Research in UX Design',
        'description':
            'User research is the systematic study of target users and their requirements to add realistic contexts to design processes.',
        'story':
            'Sarah, a UX researcher, was working on a health app project. She knew that understanding users was crucial for success. She conducted interviews, surveys, and observed users in their natural environment. One day, while observing elderly users, she discovered that many struggled with small buttons and complex navigation. This insight led to a complete redesign of the app, making it accessible and user-friendly for the elderly, ultimately increasing user satisfaction by 75%.',
        'minWords': 120,
      },
    ];

    // Get current question based on index
    Map<String, dynamic> currentQuestion = questions[widget.questionIndex];

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
                              "Question ${widget.questionIndex + 1} of ${questions.length}",
                              style: const TextStyle(
                                fontSize: 16,
                                color: Colors.grey,
                              ),
                            ),
                            const Spacer(),
                            Text(
                              "${((widget.questionIndex + 1) / questions.length * 100).round()}%",
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
                          value: (widget.questionIndex + 1) / questions.length,
                          backgroundColor: Colors.grey[300],
                          valueColor: const AlwaysStoppedAnimation<Color>(
                            Colors.blue,
                          ),
                        ),
                        const SizedBox(height: 20),

                        // Question title
                        Text(
                          currentQuestion['title'],
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
                            currentQuestion['description'],
                            style: const TextStyle(
                              fontSize: 14,
                              color: Colors.black87,
                            ),
                          ),
                        ),
                        const SizedBox(height: 20),

                        // Story section
                        Container(
                          padding: const EdgeInsets.all(15),
                          decoration: BoxDecoration(
                            color: Colors.grey[100],
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text(
                                "Interesting Story:",
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.blue,
                                ),
                              ),
                              const SizedBox(height: 10),
                              Text(
                                currentQuestion['story'],
                                style: const TextStyle(
                                  fontSize: 14,
                                  color: Colors.black87,
                                  height: 1.5,
                                ),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(height: 20),

                        // Next button
                        Container(
                          width: double.infinity,
                          height: 55,
                          child: ElevatedButton(
                            onPressed: () {
                              // Navigate to answer screen
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => QuizAnswerScreen(
                                    userName: widget.userName,
                                    quiz: widget.quiz,
                                    question: currentQuestion,
                                    questionIndex: widget.questionIndex,
                                    totalQuestions: questions.length,
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
                              padding: const EdgeInsets.symmetric(vertical: 15),
                            ),
                            child: const Text(
                              "Start Answering",
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
