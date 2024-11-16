import 'package:flutter/material.dart';
import '../models/movie_model.dart'; // Import MovieModel

class DetailsScreen extends StatelessWidget {
  final MovieModel movie;

  const DetailsScreen({Key? key, required this.movie}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(movie.name)),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Image.network(movie.imageUrl),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(movie.name,
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(movie.summary),
          ),
        ],
      ),
    );
  }
}
