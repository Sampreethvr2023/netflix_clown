import 'dart:convert';
import 'package:http/http.dart' as http;

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

class MovieModel {
  final String name;
  final String imageUrl;
  final String summary;

  MovieModel({
    required this.name,
    required this.imageUrl,
    required this.summary,
  });

  // Factory method to create a MovieModel from JSON data
  factory MovieModel.fromJson(Map<String, dynamic> json) {
    return MovieModel(
      name: json['show']['name'],
      imageUrl:
          json['show']['image'] != null ? json['show']['image']['medium'] : '',
      summary: json['show']['summary'] ?? '',
    );
  }
}
