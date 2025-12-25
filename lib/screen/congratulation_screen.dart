@override
Widget build(BuildContext context) {
  return Scaffold(
    body: Stack(
      children: [
        // Confetti Widget
        ConfettiWidget(
          confettiController: _confettiController,
          blastDirectionality: BlastDirectionality.explosive,
          shouldLoop: false,
          emissionFrequency: 0.01,
          numberOfParticles: 50,
          maxBlastForce: 100,
          minBlastForce: 80,
          gravity: 0.3,
        ),
        // Main Content
        Container(
          decoration: const BoxDecoration(
            color: Color(0xFF87CEEB), // Sky Blue background
          ),
          child: SafeArea(
            child: Column(
              children: [
                // Status Bar
                _buildStatusBar(),

                const SizedBox(height: 50),

                // Main Content
                Expanded(
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 30),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        // Curved Banner with "CONGRATULATIONS"
                        Container(
                          width: 250,
                          height: 60,
                          decoration: BoxDecoration(
                            color: Colors.black,
                            borderRadius: BorderRadius.circular(30),
                          ),
                          child: const Center(
                            child: Text(
                              "CONGRATULATIONS",
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ),

                        const SizedBox(height: 30),

                        // Decorative elements (stars and dots)
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            Icon(
                              Icons.star,
                              color: Colors.yellow[600],
                              size: 24,
                            ),
                            Icon(
                              Icons.circle,
                              color: Colors.orange[400],
                              size: 12,
                            ),
                            Icon(
                              Icons.star,
                              color: Colors.yellow[600],
                              size: 20,
                            ),
                            Icon(
                              Icons.circle,
                              color: Colors.orange[400],
                              size: 8,
                            ),
                            Icon(
                              Icons.star,
                              color: Colors.yellow[600],
                              size: 22,
                            ),
                          ],
                        ),

                        const SizedBox(height: 50),

                        // Main Congratulations text
                        Text(
                          "Congratulations !",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 28,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                            shadows: [
                              Shadow(
                                offset: const Offset(1, 1),
                                blurRadius: 3,
                                color: Colors.black.withOpacity(0.3),
                              ),
                            ],
                          ),
                        ),

                        const SizedBox(height: 10),

                        // User name
                        Text(
                          widget.name,
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.w500,
                            color: Colors.white,
                            shadows: [
                              Shadow(
                                offset: const Offset(1, 1),
                                blurRadius: 3,
                                color: Colors.black.withOpacity(0.3),
                              ),
                            ],
                          ),
                        ),

                        const SizedBox(height: 15),

                        // Confirmation message
                        Text(
                          "Your Account Has been created !",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 18,
                            color: Colors.white70,
                            shadows: [
                              Shadow(
                                offset: const Offset(1, 1),
                                blurRadius: 3,
                                color: Colors.black.withOpacity(0.3),
                              ),
                            ],
                          ),
                        ),

                        const SizedBox(height: 60),

                        // Login Now Button
                        Container(
                          width: double.infinity,
                          height: 50,
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
                          child: TextButton(
                            onPressed: () {
                              // Navigate to login screen
                              Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => const LoginScreen(),
                                ),
                              );
                            },
                            style: TextButton.styleFrom(
                              padding: EdgeInsets.zero,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(30),
                              ),
                            ),
                            child: Text(
                              "Login Now !",
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                                color: Theme.of(context).primaryColor,
                              ),
                            ),
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
      ],
    ),
  );
}
