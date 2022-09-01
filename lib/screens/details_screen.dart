import 'package:flutter/material.dart';

class DetailsScreen extends StatelessWidget {
  const DetailsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(5),
      child: const Scaffold(
        body: Center(
          child: Text(
            'Details Screen'
          ),
        ),
      ),
    );
  }
}
