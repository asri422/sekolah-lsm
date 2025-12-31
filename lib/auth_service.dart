import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';

class AuthService {
  static const String _userDataKey = 'user_data';
  static const String _isLoggedInKey = 'is_logged_in';

  static Future<void> saveUserData({
    required String name,
    required String email,
    required String phone,
    required String birthDate,
    required String birthPlace,
    required String status,
  }) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    Map<String, String> userData = {
      'name': name,
      'email': email,
      'phone': phone,
      'birth_date': birthDate,
      'birth_place': birthPlace,
      'status': status,
    };

    String userDataJson = jsonEncode(userData);
    await prefs.setString(_userDataKey, userDataJson);
    await prefs.setBool(_isLoggedInKey, true);
  }

  static Future<Map<String, String>?> getUserData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    bool isLoggedIn = prefs.getBool(_isLoggedInKey) ?? false;

    if (!isLoggedIn) {
      return null;
    }

    String? userDataJson = prefs.getString(_userDataKey);
    if (userDataJson == null) {
      return null;
    }

    Map<String, dynamic> userData = jsonDecode(userDataJson);
    Map<String, String> stringData = {};
    userData.forEach((key, value) {
      stringData[key] = value.toString();
    });

    return stringData;
  }

  static Future<bool> isLoggedIn() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getBool(_isLoggedInKey) ?? false;
  }

  static Future<void> logout() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.remove(_isLoggedInKey);
    await prefs.remove(_userDataKey);
  }
}
