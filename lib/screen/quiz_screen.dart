import 'package:flutter/material.dart';
import 'home_screen.dart'; // Import home screen
import 'academic_screen.dart'; // Import academic screen
import 'notifikasi_screen.dart'; // Import notifications screen
import 'quiz_detail_screen.dart'; // Import quiz detail screen
import 'quiz_content_screen.dart'; // Import quiz content screen
import 'profile_screen.dart'; // Import profile screen
import 'dashboard_screen.dart'; // Import dashboard screen

class QuizScreen extends StatefulWidget {
  final String userName;

  const QuizScreen({required this.userName});

  @override
  _QuizScreenState createState() => _QuizScreenState();
}

class _QuizScreenState extends State<QuizScreen> with TickerProviderStateMixin {
  String _searchQuery = '';
  bool _showSearchResults = false;
  List<Map<String, dynamic>> _searchResults = [];
  List<Map<String, dynamic>> _allQuizzes = [];
  int _selectedCategory = 0;
  List<String> _categories = ['Popular', 'Science', 'Mathematic', 'Computer'];

  // Sample ongoing quiz data
  Map<String, dynamic>? _ongoingQuiz;

  @override
  void initState() {
    super.initState();
    _initializeQuizData();
    // Simulate an ongoing quiz
    _ongoingQuiz = {
      'title': 'UI UX Design Quiz',
      'questionsCompleted': 8,
      'totalQuestions': 10,
      'subject': 'HCI Lecturer',
      'teacher': 'Bapak Rofiuddin',
    };
  }

  void _initializeQuizData() {
    _allQuizzes = [
      {
        'title': 'UI UX Design Quiz',
        'subject': 'HCI Lecturer',
        'teacher': 'Bapak Rofiuddin',
        'questions': '10 Questions',
        'duration': '30 mins',
        'rating': '4.8',
        'category': 'Computer',
      },
      {
        'title': 'Linear Algebra Quiz',
        'subject': 'Mathematics',
        'teacher': 'Bapak Hamzah',
        'questions': '15 Questions',
        'duration': '45 mins',
        'rating': '4.7',
        'category': 'Mathematic',
      },
      {
        'title': 'Chemistry Fundamentals Quiz',
        'subject': 'Chemistry',
        'teacher': 'Ibu Siti',
        'questions': '20 Questions',
        'duration': '60 mins',
        'rating': '4.9',
        'category': 'Science',
      },
      {
        'title': 'Programming Basics Quiz',
        'subject': 'Computer Science',
        'teacher': 'Bapak Rofiuddin',
        'questions': '12 Questions',
        'duration': '35 mins',
        'rating': '4.6',
        'category': 'Computer',
      },
    ];
  }

  void _performSearch(String query) {
    setState(() {
      _searchQuery = query;
      if (query.isEmpty) {
        _showSearchResults = false;
      } else {
        _searchResults = _allQuizzes
            .where(
              (quiz) =>
                  quiz['title'].toLowerCase().contains(query.toLowerCase()) ||
                  quiz['subject'].toLowerCase().contains(query.toLowerCase()) ||
                  quiz['teacher'].toLowerCase().contains(query.toLowerCase()),
            )
            .toList();
        _showSearchResults = true;
      }
    });
  }

  Widget _buildCategoryChip(String label, int index) {
    return GestureDetector(
      onTap: () {
        setState(() {
          _selectedCategory = index;
        });
      },
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 8),
        decoration: BoxDecoration(
          color: _selectedCategory == index ? Colors.blue : Colors.white,
          borderRadius: BorderRadius.circular(20),
          border: Border.all(
            color: _selectedCategory == index ? Colors.blue : Colors.grey,
          ),
        ),
        child: Center(
          child: Text(
            label,
            style: TextStyle(
              color: _selectedCategory == index ? Colors.white : Colors.blue,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
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
                    const Text(
                      "Let's test your knowledge",
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
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
                      hintText: "Search quiz...",
                      prefixIcon: const Icon(Icons.search, color: Colors.grey),
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
                    children: List.generate(
                      _categories.length,
                      (index) => Container(
                        margin: const EdgeInsets.only(right: 10),
                        child: _buildCategoryChip(_categories[index], index),
                      ),
                    ),
                  ),
                ),
              ),

              const SizedBox(height: 20),

              // Continue Quiz Section (if there's an ongoing quiz)
              if (_ongoingQuiz != null)
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Container(
                    margin: const EdgeInsets.only(bottom: 20),
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
                          const Text(
                            "Continue Quiz",
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: Colors.blue,
                            ),
                          ),
                          const SizedBox(height: 10),
                          Row(
                            children: [
                              // Quiz Image Placeholder
                              Container(
                                width: 60,
                                height: 60,
                                decoration: BoxDecoration(
                                  color: const Color(
                                    0xFF2196F3,
                                  ).withOpacity(0.1),
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                child: const Icon(
                                  Icons.quiz,
                                  color: Color(0xFF2196F3),
                                ),
                              ),
                              const SizedBox(width: 15),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      _ongoingQuiz!['title'],
                                      style: const TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    Text(
                                      _ongoingQuiz!['subject'],
                                      style: TextStyle(
                                        fontSize: 14,
                                        color: Colors.grey[600],
                                      ),
                                    ),
                                    const SizedBox(height: 5),
                                    Text(
                                      "${_ongoingQuiz!['questionsCompleted']}/${_ongoingQuiz!['totalQuestions']} Questions",
                                      style: const TextStyle(
                                        fontSize: 12,
                                        color: Colors.orange,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              ElevatedButton(
                                onPressed: () {
                                  // Handle continue quiz action
                                  _showQuizDetail(_ongoingQuiz!);
                                },
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: Colors.blue,
                                  foregroundColor: Colors.white,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(20),
                                  ),
                                ),
                                child: const Text("Continue"),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ),

              // Quiz List
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: _showSearchResults
                      ? _buildSearchResults()
                      : _buildQuizList(),
                ),
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: _buildBottomNavigationBar(),
    );
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
              "Quiz tidak ditemukan",
              style: TextStyle(fontSize: 16, color: Colors.white70),
            ),
          ],
        ),
      );
    }

    return ListView.builder(
      itemCount: _searchResults.length,
      itemBuilder: (context, index) {
        var quiz = _searchResults[index];
        return _buildQuizCard(quiz);
      },
    );
  }

  Widget _buildQuizList() {
    return ListView.builder(
      itemCount: _allQuizzes.length,
      itemBuilder: (context, index) {
        var quiz = _allQuizzes[index];
        // Filter by selected category
        if (_selectedCategory != 0 &&
            quiz['category'] != _categories[_selectedCategory]) {
          return Container(); // Skip this item
        }

        return _buildQuizCard(quiz);
      },
    );
  }

  Widget _buildQuizCard(Map<String, dynamic> quiz) {
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
                // Quiz Image Placeholder
                Container(
                  width: 60,
                  height: 60,
                  decoration: BoxDecoration(
                    color: const Color(0xFF2196F3).withOpacity(0.1),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: const Icon(Icons.quiz, color: Color(0xFF2196F3)),
                ),
                const SizedBox(width: 15),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        quiz['title'],
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        quiz['subject'],
                        style: TextStyle(fontSize: 14, color: Colors.grey[600]),
                      ),
                      Text(
                        quiz['teacher'],
                        style: TextStyle(fontSize: 12, color: Colors.grey[500]),
                      ),
                    ],
                  ),
                ),
                const Icon(Icons.star, color: Colors.orange, size: 20),
                const SizedBox(width: 5),
                Text(
                  quiz['rating'],
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 10),
            Row(
              children: [
                Expanded(
                  child: Row(
                    children: [
                      Icon(
                        Icons.question_answer,
                        size: 16,
                        color: Colors.grey[600],
                      ),
                      const SizedBox(width: 5),
                      Text(
                        quiz['questions'],
                        style: TextStyle(fontSize: 14, color: Colors.grey[600]),
                      ),
                      const SizedBox(width: 15),
                      Icon(
                        Icons.access_time,
                        size: 16,
                        color: Colors.grey[600],
                      ),
                      const SizedBox(width: 5),
                      Text(
                        quiz['duration'],
                        style: TextStyle(fontSize: 14, color: Colors.grey[600]),
                      ),
                    ],
                  ),
                ),
                ElevatedButton(
                  onPressed: () {
                    _showQuizDetail(quiz);
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.blue,
                    foregroundColor: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                  ),
                  child: const Text("Start Quiz"),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  void _showQuizDetail(Map<String, dynamic> quiz) {
    // Navigate to quiz detail screen
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) =>
            QuizDetailScreen(userName: widget.userName, quiz: quiz),
      ),
    );
  }

  Widget _buildBottomNavigationBar() {
    return BottomNavigationBar(
      type: BottomNavigationBarType.fixed,
      backgroundColor: Colors.blue[600],
      selectedItemColor: Colors.white,
      unselectedItemColor: Colors.white70,
      currentIndex: 2, // Quiz tab selected
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
          case 1: // Academic
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                builder: (context) => AcademicScreen(userName: widget.userName),
              ),
            );
            break;
          case 2: // Ideas - stay on current screen
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
