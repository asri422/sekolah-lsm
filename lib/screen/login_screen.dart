import 'package:flutter/material.dart';
import 'dart:async';
import 'package:intl/intl.dart';
import 'signup_screen.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  late Timer _timer;
  String _currentTime = '';
  bool _isPasswordVisible = false;
  bool _showError = false;
  String _errorMessage = '';

  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _updateTime();
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      _updateTime();
    });
  }

  void _updateTime() {
    if (mounted) {
      setState(() {
        _currentTime = DateFormat('HH:mm').format(DateTime.now());
      });
    }
  }

  @override
  void dispose() {
    _timer.cancel();
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          color: Color(0xFF87CEEB), // Sky Blue background
        ),
        child: SafeArea(
          child: Column(
            children: [
              // Status Bar
              _buildStatusBar(),

              // Error message bar
              if (_showError)
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 8,
                  ),
                  color: Colors.red,
                  child: Row(
                    children: [
                      const Icon(Icons.error, color: Colors.white, size: 18),
                      const SizedBox(width: 8),
                      Expanded(
                        child: Text(
                          _errorMessage,
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 14,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),

              SizedBox(height: _showError ? 20 : 40),

              // Illustration (Handshake)
              Expanded(
                flex: 2,
                child: Container(
                  padding: _showError
                      ? EdgeInsets.only(top: 20, left: 20, right: 20)
                      : EdgeInsets.all(20),
                  child: Center(
                    child: Container(
                      width: 180,
                      height: 180,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(20),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.1),
                            blurRadius: 15,
                            offset: const Offset(0, 5),
                          ),
                        ],
                      ),
                      child: Center(
                        child: Icon(
                          Icons.handyman, // Using a handshake-like icon
                          size: 100,
                          color: Colors.blue[600],
                        ),
                      ),
                    ),
                  ),
                ),
              ),

              const SizedBox(height: 30),

              // Form Fields
              Expanded(
                flex: 2,
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 30),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      // Email Field
                      Container(
                        decoration: BoxDecoration(
                          color: Colors.white.withOpacity(0.2),
                          borderRadius: BorderRadius.circular(15),
                          border: Border.all(color: Colors.white, width: 1),
                        ),
                        child: TextField(
                          controller: _emailController,
                          style: const TextStyle(color: Colors.white),
                          decoration: InputDecoration(
                            hintText: "Email",
                            hintStyle: TextStyle(color: Colors.white70),
                            prefixIcon: Icon(Icons.email, color: Colors.white),
                            border: InputBorder.none,
                            contentPadding: const EdgeInsets.symmetric(
                              horizontal: 20,
                              vertical: 15,
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(height: 15),

                      // Password Field
                      Container(
                        decoration: BoxDecoration(
                          color: Colors.white.withOpacity(0.2),
                          borderRadius: BorderRadius.circular(15),
                          border: Border.all(color: Colors.white, width: 1),
                        ),
                        child: TextField(
                          controller: _passwordController,
                          obscureText: !_isPasswordVisible,
                          style: const TextStyle(color: Colors.white),
                          decoration: InputDecoration(
                            hintText: "Password",
                            hintStyle: TextStyle(color: Colors.white70),
                            prefixIcon: Icon(Icons.lock, color: Colors.white),
                            suffixIcon: IconButton(
                              icon: Icon(
                                _isPasswordVisible
                                    ? Icons.visibility
                                    : Icons.visibility_off,
                                color: Colors.white,
                              ),
                              onPressed: () {
                                setState(() {
                                  _isPasswordVisible = !_isPasswordVisible;
                                });
                              },
                            ),
                            border: InputBorder.none,
                            contentPadding: const EdgeInsets.symmetric(
                              horizontal: 20,
                              vertical: 15,
                            ),
                          ),
                        ),
                      ),

                      const SizedBox(height: 10),

                      // Forget Password
                      Align(
                        alignment: Alignment.centerRight,
                        child: TextButton(
                          onPressed: () {
                            // Handle forget password
                          },
                          child: Text(
                            "Forget Password?",
                            style: TextStyle(color: Colors.white, fontSize: 14),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),

              const SizedBox(height: 20),

              // Login Button
              Expanded(
                flex: 0,
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 30),
                  width: double.infinity,
                  height: 50,
                  child: ElevatedButton(
                    onPressed: () {
                      // Handle login
                      _handleLogin();
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.white,
                      foregroundColor: Theme.of(context).primaryColor,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30),
                      ),
                      shadowColor: Colors.black.withOpacity(0.1),
                      elevation: 5,
                    ),
                    child: const Text(
                      "Login",
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ),

              const SizedBox(height: 25),

              // Social Media Login
              Expanded(
                flex: 0,
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 30),
                  child: Column(
                    children: [
                      Text(
                        "Or Login with",
                        style: TextStyle(color: Colors.white70, fontSize: 14),
                      ),
                      const SizedBox(height: 15),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          // Google Button
                          Container(
                            width: 50,
                            height: 50,
                            decoration: BoxDecoration(
                              color: Colors.white,
                              shape: BoxShape.circle,
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
                                _handleGoogleLogin();
                              },
                              style: TextButton.styleFrom(
                                padding: EdgeInsets.zero,
                                shape: const CircleBorder(),
                              ),
                              child: Container(
                                width: 30,
                                height: 30,
                                decoration: BoxDecoration(
                                  gradient: const LinearGradient(
                                    colors: [
                                      Color(0xFF4285F4), // Blue
                                      Color(0xFF34A853), // Green
                                      Color(0xFFFBBC05), // Yellow
                                      Color(0xFFEA4335), // Red
                                    ],
                                  ),
                                  shape: BoxShape.circle,
                                ),
                                child: const Center(
                                  child: Text(
                                    "G",
                                    style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),

                          // Facebook Button
                          Container(
                            width: 50,
                            height: 50,
                            decoration: BoxDecoration(
                              color: Colors.blue[600],
                              shape: BoxShape.circle,
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
                                _handleFacebookLogin();
                              },
                              style: TextButton.styleFrom(
                                padding: EdgeInsets.zero,
                                shape: const CircleBorder(),
                              ),
                              child: const Icon(
                                Icons.facebook,
                                color: Colors.white,
                                size: 24,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),

              const SizedBox(height: 20),

              // Sign Up Link
              Expanded(
                flex: 0,
                child: TextButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const SignUpScreen(),
                      ),
                    );
                  },
                  child: Text(
                    "Don't Have Account? Signup here !",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 14,
                      decoration: TextDecoration.underline,
                    ),
                  ),
                ),
              ),

              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildStatusBar() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          // Signal and WiFi indicators
          Row(
            children: [
              Icon(Icons.signal_cellular_alt, color: Colors.white, size: 18),
              const SizedBox(width: 5),
              Icon(Icons.wifi, color: Colors.white, size: 18),
            ],
          ),

          // Time
          Text(
            _currentTime,
            style: const TextStyle(
              fontSize: 16,
              color: Colors.white,
              fontWeight: FontWeight.bold,
            ),
          ),

          // Battery indicator
          Container(
            width: 30,
            height: 15,
            decoration: BoxDecoration(
              border: Border.all(color: Colors.white, width: 1),
              borderRadius: BorderRadius.circular(2),
            ),
            child: Container(
              width: 20,
              margin: const EdgeInsets.only(left: 1),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(1),
              ),
            ),
          ),
        ],
      ),
    );
  }

  void _handleLogin() {
    // Reset error state
    setState(() {
      _showError = false;
      _errorMessage = '';
    });

    // Validation
    if (_emailController.text.isEmpty && _passwordController.text.isEmpty) {
      setState(() {
        _showError = true;
        _errorMessage = "Email and Password Required!";
      });
    } else if (_emailController.text.isEmpty) {
      setState(() {
        _showError = true;
        _errorMessage = "Email Required!";
      });
    } else if (_passwordController.text.isEmpty) {
      setState(() {
        _showError = true;
        _errorMessage = "Password Required!";
      });
    } else {
      // Check for invalid credentials (for demo purposes)
      if (_emailController.text != "asriyaaa8@gmail.com" ||
          _passwordController.text != "password123") {
        // Show invalid credentials message
        setState(() {
          _showError = true;
          _errorMessage = "Invalid email or password!";
        });
      } else {
        // Successful login
        _showSuccessMessage();
      }
    }
  }

  void _handleGoogleLogin() async {
    try {
      final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();

      if (googleUser == null) {
        // User canceled login
        return;
      }

      // Get Google authentication details
      final GoogleSignInAuthentication googleAuth =
          await googleUser.authentication;

      // Here you would typically send the idToken and accessToken to your backend
      // For demo purposes, we'll just show a success message
      _showSocialLoginSuccess(
        "Google",
        googleUser.displayName ?? "User",
        googleUser.email,
      );
    } catch (error) {
      setState(() {
        _showError = true;
        _errorMessage = "Google login failed: ${error.toString()}";
      });
    }
  }

  void _handleFacebookLogin() async {
    try {
      // Trigger the Facebook login process
      final LoginResult result = await FacebookAuth.instance
          .login(); // by default requests email and public profile

      if (result.status == LoginStatus.success) {
        // Get user data
        final userData = await FacebookAuth.instance.getUserData();

        _showSocialLoginSuccess(
          "Facebook",
          userData["name"] ?? "User",
          userData["email"] ?? "",
        );
      } else {
        setState(() {
          _showError = true;
          _errorMessage = "Facebook login failed: ${result.message}";
        });
      }
    } catch (error) {
      setState(() {
        _showError = true;
        _errorMessage = "Facebook login failed: ${error.toString()}";
      });
    }
  }

  void _showSocialLoginSuccess(String provider, String name, String email) {
    // Show success message
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text("$provider login successful! Welcome, $name!"),
        backgroundColor: Colors.green,
      ),
    );

    // In a real app, you would navigate to the home screen
    // For now, let's just show a dialog
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text("$provider Login Successful"),
          content: Text(
            "Welcome back, $name!\n\n"
            "You've successfully logged in with $provider.\n"
            "Email: $email",
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text("OK"),
            ),
          ],
        );
      },
    );
  }

  void _showSuccessMessage() {
    // Show success message
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text("Login Successful!"),
        backgroundColor: Colors.green,
      ),
    );

    // In a real app, you would navigate to the home screen
    // For now, let's just show a dialog
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text("Login Successful"),
          content: const Text("Welcome back! You've successfully logged in."),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text("OK"),
            ),
          ],
        );
      },
    );
  }
}
