import 'package:shared_preferences/shared_preferences.dart';

class UserData {
  static const String _enrolledCoursesKey = 'enrolled_courses_count';
  static const String _completedTasksKey = 'completed_tasks_count';
  static const String _enrolledTeachersKey =
      'enrolled_teachers'; // Store enrolled teachers

  // Get enrolled courses count
  static Future<int> getEnrolledCoursesCount() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getInt(_enrolledCoursesKey) ?? 0;
  }

  // Get completed tasks count
  static Future<int> getCompletedTasksCount() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getInt(_completedTasksKey) ?? 0;
  }

  // Get enrolled teachers list
  static Future<List<String>> getEnrolledTeachers() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    List<String>? teachers = prefs.getStringList(_enrolledTeachersKey);
    return teachers ?? [];
  }

  // Check if a teacher is already enrolled
  static Future<bool> isTeacherEnrolled(String teacherName) async {
    List<String> enrolledTeachers = await getEnrolledTeachers();
    return enrolledTeachers.contains(teacherName);
  }

  // Enroll in a teacher/course
  static Future<void> enrollInTeacher(String teacherName) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    // Get current enrolled teachers
    List<String> enrolledTeachers = await getEnrolledTeachers();

    // Add teacher if not already enrolled
    if (!enrolledTeachers.contains(teacherName)) {
      enrolledTeachers.add(teacherName);
      await prefs.setStringList(_enrolledTeachersKey, enrolledTeachers);

      // Increment enrolled courses count
      int currentCount = await getEnrolledCoursesCount();
      await prefs.setInt(_enrolledCoursesKey, currentCount + 1);
    }
  }

  // Increment completed tasks count
  static Future<void> incrementCompletedTasks() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    int currentCount = await getCompletedTasksCount();
    await prefs.setInt(_completedTasksKey, currentCount + 1);
  }

  // Set enrolled courses count
  static Future<void> setEnrolledCoursesCount(int count) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setInt(_enrolledCoursesKey, count);
  }

  // Set completed tasks count
  static Future<void> setCompletedTasksCount(int count) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setInt(_completedTasksKey, count);
  }

  // Remove a teacher from enrollment (if needed)
  static Future<void> unenrollTeacher(String teacherName) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    // Get current enrolled teachers
    List<String> enrolledTeachers = await getEnrolledTeachers();

    // Remove teacher if enrolled
    if (enrolledTeachers.contains(teacherName)) {
      enrolledTeachers.remove(teacherName);
      await prefs.setStringList(_enrolledTeachersKey, enrolledTeachers);

      // Decrement enrolled courses count
      int currentCount = await getEnrolledCoursesCount();
      if (currentCount > 0) {
        await prefs.setInt(_enrolledCoursesKey, currentCount - 1);
      }
    }
  }
}
