import 'package:flutter/foundation.dart';

class AppState extends ChangeNotifier {
  List<String> _enrolledTeachers = [];

  List<String> get enrolledTeachers => _enrolledTeachers;

  void addEnrolledTeacher(String teacherName) {
    if (!_enrolledTeachers.contains(teacherName)) {
      _enrolledTeachers.add(teacherName);
      notifyListeners();
    }
  }

  void removeEnrolledTeacher(String teacherName) {
    _enrolledTeachers.remove(teacherName);
    notifyListeners();
  }

  bool isTeacherEnrolled(String teacherName) {
    return _enrolledTeachers.contains(teacherName);
  }
}
