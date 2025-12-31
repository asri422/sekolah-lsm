import 'package:flutter/material.dart';
import 'home_screen.dart'; // Import home screen
import 'academic_screen.dart'; // Import academic screen
import 'quiz_screen.dart'; // Import quiz screen
import 'notifikasi_screen.dart'; // Import notifications screen
import 'profile_screen.dart'; // Import profile screen
import 'quiz_results_screen.dart'; // Import quiz results screen

class QuizContentScreen extends StatefulWidget {
  final String userName;
  final Map<String, dynamic> quiz;

  const QuizContentScreen({required this.userName, required this.quiz});

  @override
  _QuizContentScreenState createState() => _QuizContentScreenState();
}

class _QuizContentScreenState extends State<QuizContentScreen> {
  int _currentQuestionIndex = 0;
  List<Map<String, dynamic>> _questions = [];
  List<String?> _userAnswers = [];
  bool _isQuizCompleted = false;

  @override
  void initState() {
    super.initState();
    _initializeQuiz();
  }

  void _initializeQuiz() {
    // In a real app, this would come from an API or database
    // For now, we'll create sample questions based on the quiz subject
    String subject = widget.quiz['subject'].toLowerCase();

    if (subject.contains('hci') ||
        subject.contains('ui') ||
        subject.contains('ux')) {
      _questions = [
        {
          'question': 'Apa yang dimaksud dengan User Interface (UI)?',
          'options': [
            'Antarmuka yang digunakan pengguna untuk berinteraksi dengan sistem',
            'Proses pengembangan perangkat lunak',
            'Model matematika untuk perhitungan',
            'Jaringan komputer',
          ],
          'correctAnswer': 0,
        },
        {
          'question': 'Apa yang dimaksud dengan User Experience (UX)?',
          'options': [
            'Pengalaman keseluruhan yang dirasakan pengguna saat berinteraksi dengan produk',
            'Tampilan visual dari aplikasi',
            'Kecepatan loading aplikasi',
            'Fitur keamanan aplikasi',
          ],
          'correctAnswer': 0,
        },
        {
          'question': 'Prinsip dasar desain UI yang baik adalah?',
          'options': [
            'Konsistensi, kesederhanaan, dan fokus pada pengguna',
            'Kompleksitas tinggi',
            'Banyak warna mencolok',
            'Animasi berlebihan',
          ],
          'correctAnswer': 0,
        },
        {
          'question': 'Fungsi dari wireframe dalam desain UI adalah?',
          'options': [
            'Menunjukkan struktur layout tanpa elemen desain',
            'Menentukan warna tema aplikasi',
            'Menentukan font yang digunakan',
            'Menentukan interaksi pengguna',
          ],
          'correctAnswer': 0,
        },
        {
          'question': 'Apa yang dimaksud dengan prototyping?',
          'options': [
            'Membuat model awal dari produk untuk pengujian',
            'Membuat produk akhir',
            'Mengembangkan produk',
            'Menguji produk',
          ],
          'correctAnswer': 0,
        },
      ];
    } else if (subject.contains('math') || subject.contains('algebra')) {
      _questions = [
        {
          'question': 'Apa hasil dari 2x + 5 = 15?',
          'options': ['x = 5', 'x = 10', 'x = 7.5', 'x = 3'],
          'correctAnswer': 0,
        },
        {
          'question': 'Apa yang dimaksud dengan matriks identitas?',
          'options': [
            'Matriks dengan elemen diagonal utama bernilai 1 dan lainnya 0',
            'Matriks dengan semua elemen bernilai 1',
            'Matriks dengan elemen diagonal utama bernilai 0',
            'Matriks dengan semua elemen bernilai 0',
          ],
          'correctAnswer': 0,
        },
        {
          'question': 'Apa hasil dari (a + b)²?',
          'options': ['a² + 2ab + b²', 'a² + b²', 'a² - 2ab + b²', '2a + 2b'],
          'correctAnswer': 0,
        },
        {
          'question':
              'Dalam sistem persamaan linear, berapa banyak solusi yang mungkin?',
          'options': [
            'Tidak ada, satu, atau tak hingga',
            'Hanya satu',
            'Selalu tak hingga',
            'Selalu nol',
          ],
          'correctAnswer': 0,
        },
        {
          'question': 'Apa yang dimaksud dengan determinan matriks?',
          'options': [
            'Nilai skalar yang menunjukkan sifat matriks',
            'Jumlah semua elemen matriks',
            'Rata-rata elemen matriks',
            'Produk semua elemen matriks',
          ],
          'correctAnswer': 0,
        },
      ];
    } else {
      // Default questions
      _questions = [
        {
          'question': 'Apa yang dimaksud dengan algoritma?',
          'options': [
            'Langkah-langkah sistematis untuk menyelesaikan masalah',
            'Program komputer',
            'Bahasa pemrograman',
            'Sistem operasi',
          ],
          'correctAnswer': 0,
        },
        {
          'question': 'Apa kepanjangan dari UI?',
          'options': [
            'User Interface',
            'User Interaction',
            'Universal Interface',
            'Unified Interaction',
          ],
          'correctAnswer': 0,
        },
        {
          'question': 'Apa yang dimaksud dengan variabel dalam pemrograman?',
          'options': [
            'Tempat menyimpan data yang bisa berubah-ubah',
            'Fungsi matematika',
            'Jenis bahasa pemrograman',
            'Sistem operasi',
          ],
          'correctAnswer': 0,
        },
        {
          'question': 'Apa yang dimaksud dengan loop dalam pemrograman?',
          'options': [
            'Struktur untuk mengulang eksekusi kode',
            'Fungsi untuk menghentikan program',
            'Cara untuk menyimpan data',
            'Metode untuk menghitung angka',
          ],
          'correctAnswer': 0,
        },
        {
          'question': 'Apa yang dimaksud dengan fungsi dalam pemrograman?',
          'options': [
            'Kumpulan instruksi yang melakukan tugas tertentu',
            'Variabel khusus',
            'Tipe data',
            'Operator matematika',
          ],
          'correctAnswer': 0,
        },
      ];
    }

    // Initialize user answers
    _userAnswers = List<String?>.filled(_questions.length, null);
  }

  void _selectAnswer(int optionIndex) {
    setState(() {
      _userAnswers[_currentQuestionIndex] =
          _questions[_currentQuestionIndex]['options'][optionIndex];
    });
  }

  void _nextQuestion() {
    if (_currentQuestionIndex < _questions.length - 1) {
      setState(() {
        _currentQuestionIndex++;
      });
    } else {
      _finishQuiz();
    }
  }

  void _previousQuestion() {
    if (_currentQuestionIndex > 0) {
      setState(() {
        _currentQuestionIndex--;
      });
    }
  }

  void _finishQuiz() {
    int score = _calculateScore();
    int totalPossibleScore = _questions.length * 10;
    int correctAnswers = score ~/ 10;
    int totalQuestions = _questions.length;

    // Navigate to results screen instead of showing results in the same screen
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (context) => QuizResultsScreen(
          userName: widget.userName,
          quiz: widget.quiz,
          score: score,
          totalPossibleScore: totalPossibleScore,
          correctAnswers: correctAnswers,
          totalQuestions: totalQuestions,
        ),
      ),
    );
  }

  int _calculateScore() {
    int score = 0;
    for (int i = 0; i < _questions.length; i++) {
      if (_userAnswers[i] != null &&
          _userAnswers[i] ==
              _questions[i]['options'][_questions[i]['correctAnswer']]) {
        score +=
            10; // 10 points for each correct answer as mentioned in requirements
      }
    }
    return score;
  }

  @override
  Widget build(BuildContext context) {
    if (_isQuizCompleted) {
      int score = _calculateScore();
      int totalPossibleScore = _questions.length * 10;
      double percentage = (score / totalPossibleScore) * 100;

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
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
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
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            percentage >= 70
                                ? Icons.check_circle
                                : Icons.cancel,
                            size: 100,
                            color: percentage >= 70 ? Colors.green : Colors.red,
                          ),
                          const SizedBox(height: 20),
                          Text(
                            percentage >= 70 ? "Selamat!" : "Tetap Semangat!",
                            style: const TextStyle(
                              fontSize: 24,
                              fontWeight: FontWeight.bold,
                              color: Colors.blue,
                            ),
                          ),
                          const SizedBox(height: 10),
                          Text(
                            "Nilai Anda: $score/$totalPossibleScore",
                            style: const TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              color: Colors.black,
                            ),
                          ),
                          const SizedBox(height: 10),
                          Text(
                            "Persentase: ${percentage.toStringAsFixed(1)}%",
                            style: const TextStyle(
                              fontSize: 18,
                              color: Colors.grey,
                            ),
                          ),
                          const SizedBox(height: 30),
                          Container(
                            width: double.infinity,
                            height: 55,
                            child: ElevatedButton(
                              onPressed: () {
                                Navigator.pushReplacement(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) =>
                                        QuizScreen(userName: widget.userName),
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
                              child: const Text(
                                "Kembali ke Daftar Kuis",
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
                            Text(
                              "Soal ${_currentQuestionIndex + 1} dari ${_questions.length}",
                              style: const TextStyle(
                                fontSize: 16,
                                color: Colors.grey,
                              ),
                            ),
                            const Spacer(),
                            Text(
                              "${(_currentQuestionIndex + 1) * 100 ~/ _questions.length}%",
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
                              (_currentQuestionIndex + 1) / _questions.length,
                          backgroundColor: Colors.grey[300],
                          valueColor: const AlwaysStoppedAnimation<Color>(
                            Colors.blue,
                          ),
                        ),
                        const SizedBox(height: 20),

                        // Question
                        Text(
                          _questions[_currentQuestionIndex]['question'],
                          style: const TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: Colors.black,
                          ),
                        ),
                        const SizedBox(height: 20),

                        // Options
                        ...List.generate(
                          _questions[_currentQuestionIndex]['options'].length,
                          (index) {
                            String option =
                                _questions[_currentQuestionIndex]['options'][index];
                            bool isSelected =
                                _userAnswers[_currentQuestionIndex] == option;

                            return Container(
                              margin: const EdgeInsets.only(bottom: 10),
                              child: ElevatedButton(
                                onPressed: () => _selectAnswer(index),
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: isSelected
                                      ? Colors.blue
                                      : Colors.grey[200],
                                  foregroundColor: isSelected
                                      ? Colors.white
                                      : Colors.black,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10),
                                    side: BorderSide(
                                      color: isSelected
                                          ? Colors.blue
                                          : Colors.grey,
                                    ),
                                  ),
                                  padding: const EdgeInsets.symmetric(
                                    vertical: 15,
                                  ),
                                ),
                                child: Row(
                                  children: [
                                    Container(
                                      width: 20,
                                      height: 20,
                                      decoration: BoxDecoration(
                                        shape: BoxShape.circle,
                                        border: Border.all(
                                          color: isSelected
                                              ? Colors.white
                                              : Colors.grey,
                                        ),
                                        color: isSelected
                                            ? Colors.white
                                            : Colors.transparent,
                                      ),
                                      child: isSelected
                                          ? const Icon(
                                              Icons.check,
                                              size: 16,
                                              color: Colors.blue,
                                            )
                                          : null,
                                    ),
                                    const SizedBox(width: 10),
                                    Expanded(
                                      child: Text(
                                        option,
                                        style: TextStyle(
                                          fontSize: 16,
                                          color: isSelected
                                              ? Colors.white
                                              : Colors.black,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            );
                          },
                        ),
                        const SizedBox(height: 30),

                        // Navigation buttons
                        Row(
                          children: [
                            Expanded(
                              child: ElevatedButton(
                                onPressed: _currentQuestionIndex > 0
                                    ? _previousQuestion
                                    : null,
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: Colors.grey[300],
                                  foregroundColor: Colors.black,
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
                              flex: 2,
                              child: ElevatedButton(
                                onPressed:
                                    _userAnswers[_currentQuestionIndex] != null
                                    ? _nextQuestion
                                    : null,
                                style: ElevatedButton.styleFrom(
                                  backgroundColor:
                                      _userAnswers[_currentQuestionIndex] !=
                                          null
                                      ? Colors.blue
                                      : Colors.grey[300],
                                  foregroundColor:
                                      _userAnswers[_currentQuestionIndex] !=
                                          null
                                      ? Colors.white
                                      : Colors.grey,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(30),
                                  ),
                                  padding: const EdgeInsets.symmetric(
                                    vertical: 15,
                                  ),
                                ),
                                child: Text(
                                  _currentQuestionIndex == _questions.length - 1
                                      ? "Selesai"
                                      : "Selanjutnya",
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
