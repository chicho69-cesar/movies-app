import 'package:flutter/material.dart';

import 'package:provider/provider.dart';

import 'package:movies_app/models/models.dart';
import 'package:movies_app/providers/movies_provider.dart';

class MovieSearchDelegate extends SearchDelegate {
  @override
  String? get searchFieldLabel => 'Buscar película';

  @override
  List<Widget>? buildActions(BuildContext context) {
    return [
      IconButton(
        icon: const Icon(Icons.clear),
        onPressed: () => query = ''
      ),
    ];
  }

  @override
  Widget? buildLeading(BuildContext context) {
    return IconButton(
      icon: const Icon(Icons.arrow_back_ios),
      onPressed: () {
        close(context, null);
      }
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    if (query.isEmpty) {
      return _emptyContainer();
    }

    final moviesProvider = Provider.of<MoviesProvider>(context, listen: false);

    return FutureBuilder(
      future: moviesProvider.searchMovies(query),
      builder: (_, AsyncSnapshot<List<Movie>> snapshot) {
        if (!snapshot.hasData) return _emptyContainer();

        final List<Movie> movies = snapshot.data!;

        return ListView.builder(
          itemCount: movies.length,
          itemBuilder: (_, int index) => _MovieItem(movies[index]),
        );
      },
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    if (query.isEmpty) {
      return _emptyContainer();
    }

    final moviesProvider = Provider.of<MoviesProvider>(context, listen: false);
    moviesProvider.getSuggestionsByQuery(query);

    /* Creamos un StreamBuilder para obtener las sugerencias de peliculas una vez que acabamos
    de escribir la busqueda en lugar de en cada caracter que escribimos */
    return StreamBuilder(
      /* Nos subscribimos al stream */
      stream: moviesProvider.suggestionStream,
      builder: (_, AsyncSnapshot<List<Movie>> snapshot) {
        if (!snapshot.hasData) return _emptyContainer();

        final movies = snapshot.data!;

        return ListView.builder(
          itemCount: movies.length,
          itemBuilder: (_, int index) => _MovieItem(movies[index]),
        );
      },
    );
  }

  Widget _emptyContainer() {
    // ignore: avoid_unnecessary_containers
    return Container(
        child: const Center(
          child: Icon(
            Icons.movie_creation_outlined,
            color: Colors.black38,
            size: 130,
          ),
        ),
      );
  }
}

class _MovieItem extends StatelessWidget {
  const _MovieItem(this.movie);

  final Movie movie;

  @override
  Widget build(BuildContext context) {
    /* Armamos el heroId para el search-delegate */
    movie.heroId = 'search-${ movie.id }';

    return ListTile(
      leading: Hero(
        tag: movie.heroId!,
        child: FadeInImage(
          placeholder: const AssetImage('assets/no-image.jpg'),
          image: NetworkImage(movie.fullPosterImage),
          width: 50,
          fit: BoxFit.contain,
        ),
      ),
      title: Text(
        movie.title,
        style: const TextStyle(fontSize: 18),
      ),
      subtitle: Text(
        movie.originalTitle,
        style: const TextStyle(fontSize: 14),
      ),
      onTap: () {
        Navigator.pushNamed(context, 'details', arguments: movie);
      },
    );
  }
}
