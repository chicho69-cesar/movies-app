import 'package:flutter/cupertino.dart'  show CupertinoActivityIndicator;
import 'package:flutter/material.dart';

import 'package:provider/provider.dart';

import 'package:movies_app/models/models.dart';
import 'package:movies_app/providers/movies_provider.dart';

class CastingCards extends StatelessWidget {
  const CastingCards(this.movieId, {Key? key}) : super(key: key);
  
  final int movieId;

  @override
  Widget build(BuildContext context) {
    final moviesProvider = Provider.of<MoviesProvider>(context, listen: false);

    return FutureBuilder(
      future: moviesProvider.getMoviecast(movieId),
      builder: (_, AsyncSnapshot<List<Cast>> snapshot) {
        if (!snapshot.hasData) {
          return Container(
            constraints: const BoxConstraints(maxWidth: 150),
            width: double.infinity,
            height: 200,
            margin: const EdgeInsets.only(bottom: 30, top: 60),
            child: const CupertinoActivityIndicator(),
          );
        }

        final List<Cast> cast = snapshot.data!;

        return Container(
          width: double.infinity,
          height: 200,
          margin: const EdgeInsets.only(bottom: 30, top: 60),
          child: ListView.builder(
            itemCount: cast.length,
            scrollDirection: Axis.horizontal,
            itemBuilder: ( _ , int index) => _CastCard(cast[index]),
          ),
        );
      },
    );
  }
}

class _CastCard extends StatelessWidget {
  const _CastCard(this.actor);
  
  final Cast actor;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 110,
      height: 100,
      margin: const EdgeInsets.symmetric(horizontal: 10),
      child: Column(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(20),
            child: FadeInImage(
              height: 140,
              width: 100,
              fit: BoxFit.cover,
              placeholder: const AssetImage('assets/no-image.jpg'),
              image: NetworkImage(actor.fullProfilePath),
            ),
          ),

          const SizedBox(height: 5),

          Text(
            actor.name,
            textAlign: TextAlign.center,
            overflow: TextOverflow.ellipsis,
            maxLines: 2,
          ),
        ],
      ),
    );
  }
}
