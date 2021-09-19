import 'package:flutter/material.dart';
import 'package:practial_task/homepage.dart';
import 'package:practial_task/loginpage.dart';
import 'package:shared_preferences/shared_preferences.dart';

Future<void> main() async {
      WidgetsFlutterBinding.ensureInitialized();
      SharedPreferences prefs = await SharedPreferences.getInstance();
      var _email = prefs.getString('_email');
      print(_email);
      runApp(MaterialApp(home: _email == null ? LoginPage() : HomePage()));
    }

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: LoginPage(),
    );
  }
}
