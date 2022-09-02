import 'package:flutter/material.dart';

import 'package:movies_app/widgets/widgets.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(5),
      child: Scaffold(
        appBar: AppBar(
          title: const Text(
            'Peliculas en cines',
            style: TextStyle(fontSize: 25),
          ),
          actions: [
            IconButton(
              onPressed: () {}, 
              icon: const Icon(Icons.search_outlined)
            ),
          ],
        ),
        body: SingleChildScrollView(
          child: Column(
            children: const [
              // Main cards
              CardSwiper(),
        
              // Slider of movies
              MovieSlider(),
            ],
          ),
        ),
      ),
    );
  }
}
