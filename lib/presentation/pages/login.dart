import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'home_view.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  _signOut() async {
    await FirebaseAuth.instance.signOut();

    return const HomeView(
      title: 'lôgin',
    );
  }

  @override
  Widget build(BuildContext context) {
    return Center(
        child: TextButton(
            onPressed: () {
              _signOut();
            },
            child: const Text("logout")));
  }
}
