import 'package:shared_preferences/shared_preferences.dart';

Future<void> emailsave(String email) async {
  final prefs = await SharedPreferences.getInstance();

  await prefs.setString('email', email);
}

Future<String?> getEmail() async {
  final prefs = await SharedPreferences.getInstance();
  return prefs.getString('email');
}

Future<void> emaildelete() async {
  final prefs = await SharedPreferences.getInstance();
  prefs.remove('email');
}
