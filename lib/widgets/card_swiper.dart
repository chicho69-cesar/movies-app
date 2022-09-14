import 'package:flutter/material.dart';

import 'package:card_swiper/card_swiper.dart';
import 'package:movies_app/models/models.dart';

class CardSwiper extends StatelessWidget {
  const CardSwiper({Key? key, required this.movies}) : super(key: key);

  final List<Movie> movies;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    if (movies.isEmpty) {
      // ignore: sized_box_for_whitespace
      return Container(
        width: double.infinity,
        height: size.height * 0.5,
        child: const Center(
          child: CircularProgressIndicator()
        ),
      );
    }

    // ignore: sized_box_for_whitespace
    return Container(
      width: double.infinity,
      height: size.height * 0.5,
      child: Swiper(
        itemCount: movies.length,
        layout: SwiperLayout.STACK,
        itemWidth: size.width * 0.6,
        itemHeight: size.height * 0.4,
        itemBuilder: ( _ , index) {
          final movie = movies[index];

          /* Armamos el hero id de la pelicula para el swiper */
          movie.heroId = 'swiper-${ movie.id }';

          return GestureDetector(
            onTap: () => Navigator.pushNamed(
              context, 
              'details',
              arguments: movie
            ),
            /* El widget Hero nos ayuda a hacer animaciones de transicion entre dos screens
            cuando usamos un Hero por fuerza debemos de usar un tag, el cual puede ser cualquier
            Object, la unica condicion es que este debe de ser unico en relacion con el que
            va a recibir la animacion */
            child: Hero(
              tag: movie.heroId!,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(20),
                child: FadeInImage(
                  placeholder: const AssetImage('assets/no-image.jpg'), 
                  image: NetworkImage(movie.fullPosterImage),
                  // image: AssetImage('assets/no-image.jpg'), 
                  fit: BoxFit.cover,
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
