import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(5),
      child: const Scaffold(
        body: Center(
          child: Text(
            'Home Screen'
          ),
        ),
      ),
    );
  }
}
