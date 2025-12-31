import 'package:flutter/material.dart';
import 'email_service.dart'; // Import email service
import 'academic_screen.dart'; // Import academic screen
import 'home_screen.dart'; // Import home screen
import 'notifikasi_screen.dart'; // Import notifications screen
import 'quiz_screen.dart'; // Import quiz screen
import 'profile_screen.dart'; // Import profile screen
import '../user_data.dart'; // Import user data

class TeacherDetailScreen extends StatefulWidget {
  final String teacherName;
  final String teacherTitle;
  final String teacherSubject;
  final String teacherRating;
  final String userName; // Add user name parameter
  final String userEmail; // Add user email parameter
  final List<String>? enrolledTeachers; // Add enrolled teachers parameter
  final Function(String)? onEnroll; // Callback for enrollment

  const TeacherDetailScreen({
    Key? key,
    this.teacherName = "Bapak Rofiuddin",
    this.teacherTitle = "Rofiuddin S.Kom M.Kom",
    this.teacherSubject = "HCI Lecturer",
    this.teacherRating = "4.8",
    this.userName = "User",
    this.userEmail = "user@example.com",
    this.enrolledTeachers,
    this.onEnroll,
  }) : super(key: key);

  @override
  _TeacherDetailScreenState createState() => _TeacherDetailScreenState();
}

class _TeacherDetailScreenState extends State<TeacherDetailScreen>
    with TickerProviderStateMixin {
  late TabController _tabController;
  int _selectedTab = 3; // Computer tab is active by default
  bool _isEnrolled = false;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 4, vsync: this);
    _tabController.index = _selectedTab;
    _tabController.addListener(() {
      setState(() {
        _selectedTab = _tabController.index;
      });
    });

    _checkEnrollmentStatus();
  }

  Future<void> _checkEnrollmentStatus() async {
    _isEnrolled = await UserData.isTeacherEnrolled(widget.teacherName);
    setState(() {});
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  // Function to handle enrollment and update statistics
  void _enrollNow() async {
    // Send enrollment data to email
    EmailService.sendEnrollmentEmail(
      teacherName: widget.teacherName,
      userName: widget.userName,
      userEmail: widget.userEmail,
    );

    // Call the callback if provided
    if (widget.onEnroll != null) {
      widget.onEnroll!(widget.teacherName);
    }

    // Enroll in the teacher/course which will increment the count
    await UserData.enrollInTeacher(widget.teacherName);

    // Show confirmation message
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          'Enrollment request sent to asriyaaa8@gmail.com for ${widget.teacherName}',
        ),
        duration: Duration(seconds: 2),
      ),
    );

    // Update profile statistics after enrollment
    List<String> enrolledTeachers = await UserData.getEnrolledTeachers();
    await UserData.setEnrolledCoursesCount(enrolledTeachers.length);
  }

  @override
  Widget build(BuildContext context) {
    // Get screen size for responsive design
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;

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
                height: screenHeight * 0.25,
                width: double.infinity,
                decoration: const BoxDecoration(
                  color: Color(0xFF2196F3), // Blue header
                  borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(20),
                    bottomRight: Radius.circular(20),
                  ),
                ),
                child: Stack(
                  children: [
                    // Back button
                    Positioned(
                      left: 16,
                      top: 16,
                      child: IconButton(
                        icon: const Icon(
                          Icons.arrow_back,
                          color: Colors.white,
                          size: 28,
                        ),
                        onPressed: () {
                          Navigator.pop(context);
                        },
                      ),
                    ),
                    // Menu icon and rating
                    Positioned(
                      top: 16,
                      right: 16,
                      child: Row(
                        children: [
                          IconButton(
                            icon: const Icon(
                              Icons.apps,
                              color: Colors.white,
                              size: 28,
                            ),
                            onPressed: () {
                              // Handle menu press
                            },
                          ),
                          Text(
                            "Top Rated ⭐ ${widget.teacherRating}",
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 14,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ],
                      ),
                    ),
                    // Teacher avatar
                    Positioned(
                      top: 70,
                      left: 0,
                      right: 0,
                      child: Container(
                        width: 100,
                        height: 100,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: Colors.white,
                          border: Border.all(color: Colors.white, width: 3),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.2),
                              blurRadius: 10,
                              offset: const Offset(0, 5),
                            ),
                          ],
                        ),
                        child: const Icon(
                          Icons.person,
                          size: 60,
                          color: Color(0xFF2196F3),
                        ),
                      ),
                    ),
                    // Teacher name
                    Positioned(
                      top: 180,
                      left: 0,
                      right: 0,
                      child: Text(
                        widget.teacherTitle,
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              // Content
              Expanded(
                child: Container(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Start Learning text
                      const Text(
                        "Start Learning with",
                        style: TextStyle(color: Colors.grey, fontSize: 14),
                      ),
                      const SizedBox(height: 5),
                      Text(
                        widget.teacherName,
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 20),
                      // Tab bar
                      Container(
                        width: double.infinity,
                        child: TabBar(
                          controller: _tabController,
                          indicatorColor: const Color(0xFF2196F3),
                          labelColor: const Color(0xFF2196F3),
                          unselectedLabelColor: Colors.grey,
                          tabs: const [
                            Tab(text: "Popular"),
                            Tab(text: "Science"),
                            Tab(text: "Mathematic"),
                            Tab(text: "Computer"),
                          ],
                        ),
                      ),
                      const SizedBox(height: 15),
                      // Course list
                      Expanded(
                        child: ListView(
                          children: [
                            _buildCourseCard(
                              "UI/UX Design",
                              "10 Question",
                              "1 hour 15 min",
                              widget.teacherRating,
                            ),
                            const SizedBox(height: 15),
                            _buildCourseCard(
                              "Graphic Design",
                              "10 Question",
                              "1 hour 15 min",
                              widget.teacherRating,
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: _buildBottomNavigationBar(),
      // Floating action button for "Continue to Learn!" - replacing the missing element
      floatingActionButton: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          if (!_isEnrolled) ...[
            // Enroll Now button (moved to be above Continue to Learn)
            Container(
              width: screenWidth * 0.8,
              height: 50,
              margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              child: ElevatedButton(
                onPressed: _enrollNow,
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF2196F3),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30),
                  ),
                  padding: const EdgeInsets.symmetric(vertical: 15),
                ),
                child: const Text(
                  "Enroll Now",
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          ] else ...[
            // Already Enrolled button
            Container(
              width: screenWidth * 0.8,
              height: 50,
              margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              child: ElevatedButton(
                onPressed: null, // Disabled since already enrolled
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.grey,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30),
                  ),
                  padding: const EdgeInsets.symmetric(vertical: 15),
                ),
                child: const Text(
                  "Already Enrolled",
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          ],
          // Continue to Learn button (only show if enrolled)
          if (_isEnrolled)
            Container(
              width: screenWidth * 0.8,
              height: 50,
              margin: const EdgeInsets.symmetric(horizontal: 20),
              child: ElevatedButton(
                onPressed: () {
                  // Refresh the current screen to show updated enrollment status
                  setState(() {});
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF2196F3),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30),
                  ),
                  padding: const EdgeInsets.symmetric(vertical: 15),
                ),
                child: const Text(
                  "Continue to Learn!",
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
        ],
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }

  Widget _buildCourseCard(
    String title,
    String questions,
    String duration,
    String rating,
  ) {
    return GestureDetector(
      onTap: () {
        // Enroll user in the course and navigate to Academic screen
        _enrollNow();
      },
      child: Card(
        elevation: 4,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
        child: Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(15),
          ),
          child: Row(
            children: [
              // Course image placeholder
              Container(
                width: 60,
                height: 60,
                decoration: BoxDecoration(
                  color: const Color(0xFF2196F3).withOpacity(0.1),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: const Icon(Icons.book, color: Color(0xFF2196F3)),
              ),
              const SizedBox(width: 15),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Row(
                      children: [
                        Icon(
                          Icons.question_answer,
                          size: 16,
                          color: Colors.grey[600],
                        ),
                        const SizedBox(width: 5),
                        Text(
                          questions,
                          style: TextStyle(
                            fontSize: 14,
                            color: Colors.grey[600],
                          ),
                        ),
                        const SizedBox(width: 15),
                        Icon(
                          Icons.access_time,
                          size: 16,
                          color: Colors.grey[600],
                        ),
                        const SizedBox(width: 5),
                        Text(
                          duration,
                          style: TextStyle(
                            fontSize: 14,
                            color: Colors.grey[600],
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              const Icon(Icons.star, color: Colors.orange, size: 20),
              const SizedBox(width: 5),
              Text(
                rating,
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
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
      currentIndex: 1, // Course tab selected by default
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
            // Could implement profile screen later
            break;
        }
      },
    );
  }
}
