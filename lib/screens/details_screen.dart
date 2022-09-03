import 'package:flutter/material.dart';

import 'package:movies_app/widgets/widgets.dart';

class DetailsScreen extends StatelessWidget {
  const DetailsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // TODO: Cambiar luego por una instancia de movie
    final String movie = ModalRoute.of(context)?.settings.arguments.toString() ?? 'no-movie';

    return Scaffold(
      body: CustomScrollView(
        /* Los slivers no son mas que widgets que tienen cierto comportamiento que es preprogramado
        cuando se hace scroll en el contenido del padre */
        slivers: [
          _CustomAppBar(),
          SliverList(
            delegate: SliverChildListDelegate([
              _PosterAndTitle(),
              _Overview(),
              _Overview(),
              _Overview(),
              _Overview(),
              _Overview(),
              CastingCards(),
            ]),
          ),
        ],
      ),
    );
  }
}

class _CustomAppBar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
      backgroundColor: Colors.indigo,
      expandedHeight: 200,
      floating: false,
      pinned: true,
      flexibleSpace: FlexibleSpaceBar(
        centerTitle: true,
        titlePadding: const EdgeInsets.all(0),
        title: Container(
          width: double.infinity,
          padding: const EdgeInsets.only(bottom: 10),
          alignment: Alignment.bottomCenter,
          color: Colors.black12,
          child: const Text(
            'movie.title',
            style: TextStyle(
              fontSize: 16
            ),
          ),
        ),
        background: const FadeInImage(
          width: double.infinity,
          placeholder: AssetImage('assets/loading.gif'), 
          // image: AssetImage('assets/no-image.jpg'), 
          image: NetworkImage('https://via.placeholder.com/600x300'),
        ),
      ),
    );
  }
}

class _PosterAndTitle extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final TextTheme textTheme = Theme.of(context).textTheme;

    return Container(
      margin: const EdgeInsets.only(top: 20),
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Row(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(20),
            child: const FadeInImage(
              placeholder: AssetImage('assets/no-image.jpg'), 
              image: NetworkImage('https://via.placeholder.com/200x300'),
              height: 150,
            ),
          ),

          const SizedBox(width: 20),

          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'movie.title',
                style: textTheme.headline5,
                overflow: TextOverflow.ellipsis,
                maxLines: 2,
              ),

              Text(
                'movie.originalTitle',
                style: textTheme.subtitle1,
                overflow: TextOverflow.ellipsis,
                maxLines: 1,
              ),

              Row(
                children: [
                  const Icon(
                    Icons.star_outline, 
                    size: 15,
                    color: Colors.grey,
                  ),

                  const SizedBox(width: 5),

                  Text(
                    'movie.voteAverage',
                    style: textTheme.caption,
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _Overview extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 10),
      child: Text(
        'Amet pariatur ea fugiat officia sit occaecat. Cillum cillum ipsum esse pariatur voluptate consequat laboris ad est. Occaecat culpa nisi officia enim sunt laborum do dolor velit. Proident ea ex aliquip ad ea dolor magna do occaecat velit reprehenderit laborum excepteur irure. Adipisicing dolor dolore dolor eiusmod elit consequat dolore deserunt fugiat irure qui commodo cillum. Cupidatat est nisi ullamco sit qui aliqua. Eiusmod aliqua ex in ullamco esse amet deserunt id magna ipsum. Incididunt cupidatat eu nisi consequat incididunt sit aute nulla labore velit.',
        textAlign: TextAlign.justify,
        style: Theme.of(context).textTheme.subtitle1,
      ),
    );
  }
}
