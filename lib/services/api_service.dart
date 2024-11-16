import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/movie_model.dart';

Future<List<MovieModel>> fetchMovies() async {
  final response =
      await http.get(Uri.parse('https://api.tvmaze.com/search/shows?q=all'));

  if (response.statusCode == 200) {
    // Parse the JSON data and convert to a list of MovieModel
    final List<dynamic> data = json.decode(response.body);
    return data.map((item) => MovieModel.fromJson(item)).toList();
  } else {
    throw Exception('Failed to load movies');
  }
}
