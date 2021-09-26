import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'auth_view.dart';
import 'home.dart';

class Splash extends StatelessWidget {
  Splash({Key? key}) : super(key: key);

  User? user = FirebaseAuth.instance.currentUser;

  @override
  Widget build(BuildContext context) {
    ///
    Future.delayed(const Duration(seconds: 2), () {
      if (user == null) {
        Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(builder: (_) => const GoogleAuthPage()),
            (route) => false);
      } else {
        Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(builder: (_) => const HomePage()),
            (route) => false);
      }
    });

    //
    return const Scaffold(
      body: Center(
          child: FlutterLogo(
        size: 100,
      )),
    );
  }
}
