import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/movie_model.dart';

class MovieProvider {
  final String _baseUrl = 'https://api.tvmaze.com';

  // Fetch all movies
  Future<List<MovieModel>> fetchAllMovies() async {
    final url = Uri.parse('$_baseUrl/search/shows?q=all');

    try {
      final response = await http.get(url);

      if (response.statusCode == 200) {
        final List<dynamic> data = json.decode(response.body);

        // Parse the API response into a list of MovieModel
        return data.map((json) => MovieModel.fromJson(json['show'])).toList();
      } else {
        throw Exception('Failed to load movies');
      }
    } catch (error) {
      throw Exception('Error fetching movies: $error');
    }
  }

  // Search movies
  Future<List<MovieModel>> searchMovies(String searchTerm) async {
    final url = Uri.parse('$_baseUrl/search/shows?q=$searchTerm');

    try {
      final response = await http.get(url);

      if (response.statusCode == 200) {
        final List<dynamic> data = json.decode(response.body);

        // Parse the API response into a list of MovieModel
        return data.map((json) => MovieModel.fromJson(json['show'])).toList();
      } else {
        throw Exception('Failed to search movies');
      }
    } catch (error) {
      throw Exception('Error searching movies: $error');
    }
  }
}
