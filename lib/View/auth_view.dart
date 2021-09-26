import 'package:firebase_todo_app/Service/auth_service.dart';
import 'package:flutter/material.dart';

import 'home.dart';

class GoogleAuthPage extends StatefulWidget {
  const GoogleAuthPage({Key? key}) : super(key: key);

  @override
  _GoogleAuthPageState createState() => _GoogleAuthPageState();
}

class _GoogleAuthPageState extends State<GoogleAuthPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Center(
            child: GestureDetector(
      onTap: () {
        AuthClass().signInWithGoogle().then((value) {
          if (value == 'Success') {
            ///Naviagate
            Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(builder: (_) => const HomePage()),
                (route) => false);
          } else {
            ScaffoldMessenger.of(context)
                .showSnackBar(const SnackBar(content: Text("Error occured")));
          }
        });
      },
      child: Container(
        padding: const EdgeInsets.all(15),
        decoration: BoxDecoration(
          color: Colors.red,
          borderRadius: BorderRadius.circular(10),
        ),
        child: const Text(
          "Continue with google",
          style: TextStyle(color: Colors.white),
        ),
      ),
    )));
  }
}
