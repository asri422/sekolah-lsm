import 'package:mailer/mailer.dart';
import 'package:mailer/smtp_server/gmail.dart';

class EmailService {
  // This is a simplified version - in production, you would need real email credentials
  // and proper authentication methods

  static Future<void> sendEnrollmentEmail({
    required String teacherName,
    required String userName,
    required String userEmail,
  }) async {
    try {
      // For demonstration purposes, we'll just print to console
      // In a real application, you would use proper email credentials
      print('Enrollment data sent:');
      print('Teacher: $teacherName');
      print('Student: $userName');
      print('Email: $userEmail');
      print('To: asriyaaa8@gmail.com');

      // In a real application, you would use code like this:
      /*
      final smtpServer = gmail('your_email@gmail.com', 'your_app_password');
      final message = Message()
        ..from = Address('your_email@gmail.com', 'Sekolah App')
        ..recipients.add('asriyaaa8@gmail.com')
        ..subject = 'New Enrollment Request'
        ..text = 'Student $userName has requested to enroll with teacher $teacherName. Contact email: $userEmail';
      
      await send(message, smtpServer);
      */
    } catch (e) {
      print('Error sending email: $e');
    }
  }
}
