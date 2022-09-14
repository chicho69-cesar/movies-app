import 'dart:async';

import 'package:flutter/material.dart';

import 'package:http/http.dart' as http;

import 'package:movies_app/helpers/debouncer.dart';
import 'package:movies_app/models/models.dart';
import 'package:movies_app/models/search_movies_response.dart';

class MoviesProvider extends ChangeNotifier {
  final String _apiKey = '5b10cc3f5c9bf78fd803aa65ec24ef7d';
  final String _baseUrl = 'api.themoviedb.org';
  final String _language = 'es-ES';

  List<Movie> onDisplayMovies = [];
  List<Movie> popularMovies = [];

  Map<int, List<Cast>> moviesCast = {};

  int _popularPage = 0;

  final debouncer = Debouncer(
    duration: const Duration(milliseconds: 500),
  );

  /* Creamos nuestro Stream para recibir informacion de la busqueda */
  // ignore: unnecessary_new
  final StreamController<List<Movie>> _suggestionStreamController = new StreamController.broadcast();
  Stream<List<Movie>> get suggestionStream => _suggestionStreamController.stream;

  MoviesProvider() {
    getOnDisplayMovies();
    getPopularMovies();
  }

  /* Cuando usamos un parametro entre [] quiere decir que el parametro es opcional */
  Future<String> _getJsonData(String endpoint, [int page = 1]) async {
    try {
      /* Creamos la url para la peticion (dominio, endpoint, parametros) */
      final url = Uri.https(_baseUrl, endpoint, {
        'api_key': _apiKey,
        'language': _language,
        'page': '$page'
      });

      final response = await http.get(url);
      return response.body;
    } on Exception {
      return '';
    }
  }

  getOnDisplayMovies() async {
    final jsonData = await _getJsonData('3/movie/now_playing');
    
    if (jsonData != '') {
      final nowPlayingResponse = NowPlayingResponse.fromJson(jsonData);
      onDisplayMovies = nowPlayingResponse.results;
      notifyListeners();
    }
  }

  getPopularMovies() async {
    _popularPage++;
    final jsonData = await _getJsonData('3/movie/popular', _popularPage);
    
    if (jsonData != '') {
      final popularResponse = PopularResponse.fromJson(jsonData);
      popularMovies = [ ...popularMovies, ...popularResponse.results ];
      notifyListeners();
    }
  }

  Future<List<Cast>> getMoviecast(int movieId) async {
    if (moviesCast.containsKey(movieId)) return moviesCast[movieId]!;

    final jsonData = await _getJsonData('3/movie/$movieId/credits', _popularPage);
    final creditsResponse = CreditsResponse.fromJson(jsonData);
    moviesCast[movieId] = creditsResponse.cast;
    return creditsResponse.cast;
  }

  Future<List<Movie>> searchMovies(String query) async {
    final url = Uri.https(_baseUrl, '3/search/movie', {
      'api_key': _apiKey,
      'language': _language,
      'query': query
    });

    final response = await http.get(url);
    final searchResponse = SearchResponse.fromJson(response.body);
    return searchResponse.results;
  }

  void getSuggestionsByQuery(String searchTerm) {
    debouncer.value = '';
    
    debouncer.onValue = (value) async {
      final results = await searchMovies(value);
      _suggestionStreamController.add(results);
    };

    final timer = Timer.periodic(
      const Duration(milliseconds: 300), 
      (_) { 
        debouncer.value = searchTerm;
      }
    );

    Future.delayed(const Duration(milliseconds: 301))
      .then((value) => timer.cancel());
  }
}
