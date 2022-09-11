import 'package:flutter/material.dart';

import 'package:provider/provider.dart';

import 'package:movies_app/providers/movies_provider.dart';
import 'package:movies_app/search/search_delegate.dart';
import 'package:movies_app/widgets/widgets.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    /* Creamos una instancia de MoviesProvider para poder manejar las peliculas que obtenemos
    desde la API, la propiedad listen nos permite redibujar el widget cada que haya un cambio en
    los elementos que manejamos con provider */
    final moviesProvider = Provider.of<MoviesProvider>(context, listen: true);

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
              onPressed: () => showSearch(
                context: context, 
                /* Un delegate es una clase o un widget que tiene ciertas condiciones */
                delegate: MovieSearchDelegate()
              ), 
              icon: const Icon(Icons.search_outlined)
            ),
          ],
        ),
        body: SingleChildScrollView(
          child: Column(
            children: [
              // Main cards
              CardSwiper(
                movies: moviesProvider.onDisplayMovies
              ),
        
              // Slider of movies
              MovieSlider(
                movies: moviesProvider.popularMovies,
                title: 'Populares!',
                onNextPage: () => moviesProvider.getPopularMovies(),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
