import 'package:flutter/material.dart';

import 'package:http/http.dart' as http;

import 'package:movies_app/models/models.dart';

class MoviesProvider extends ChangeNotifier {
  final String _apiKey = '5b10cc3f5c9bf78fd803aa65ec24ef7d';
  final String _baseUrl = 'api.themoviedb.org';
  final String _language = 'es-ES';

  MoviesProvider() {
    print('Movies Provider init');
    getOnDisplayMovies();
  }

  getOnDisplayMovies() async {
    /* Creamos la url para la peticion (dominio, endpoint, parametros) */
    var url = Uri.https(_baseUrl, '3/movie/now_playing', {
      'api_key': _apiKey,
      'language': _language,
      'page': '1'
    });

    final response = await http.get(url);
    final nowPlayingResponse = NowPlayingResponse.fromJson(response.body);

    print(nowPlayingResponse.results[0].title);
  }
}
