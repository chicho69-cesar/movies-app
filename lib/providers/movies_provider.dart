import 'package:flutter/material.dart';

import 'package:http/http.dart' as http;

import 'package:movies_app/models/models.dart';

class MoviesProvider extends ChangeNotifier {
  final String _apiKey = '5b10cc3f5c9bf78fd803aa65ec24ef7d';
  final String _baseUrl = 'api.themoviedb.org';
  final String _language = 'es-ES';

  List<Movie> onDisplayMovies = [];
  List<Movie> popularMovies = [];

  int _popularPage = 0;

  MoviesProvider() {
    getOnDisplayMovies();
    getPopularMovies();
  }

  /* Cuando usamos un parametro entre [] quiere decir que el parametro es opcional */
  Future<String> _getJsonData(String endpoint, [int page = 1]) async {
    /* Creamos la url para la peticion (dominio, endpoint, parametros) */
    var url = Uri.https(_baseUrl, endpoint, {
      'api_key': _apiKey,
      'language': _language,
      'page': '$page'
    });

    final response = await http.get(url);
    return response.body;
  }

  getOnDisplayMovies() async {
    final jsonData = await _getJsonData('3/movie/now_playing');
    final nowPlayingResponse = NowPlayingResponse.fromJson(jsonData);
    onDisplayMovies = nowPlayingResponse.results;
    notifyListeners();
  }

  getPopularMovies() async {
    _popularPage++;
    final jsonData = await _getJsonData('3/movie/popular', _popularPage);
    final popularResponse = PopularResponse.fromJson(jsonData);
    popularMovies = [ ...popularMovies, ...popularResponse.results ];
    notifyListeners();
  }
}
