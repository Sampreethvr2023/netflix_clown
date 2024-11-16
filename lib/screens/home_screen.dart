import 'package:flutter/material.dart';
import '../models/movie_model.dart';
import '../widgets/movie_card.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late Future<List<MovieModel>> _movieList;

  @override
  void initState() {
    super.initState();
    _movieList = fetchMovies(); // Fetch the movie data
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Movies')),
      body: FutureBuilder<List<MovieModel>>(
        future: _movieList,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return Center(child: Text('No movies found'));
          }

          // If data is available, show list of movies
          final movies = snapshot.data!;
          return ListView.builder(
            itemCount: movies.length,
            itemBuilder: (context, index) {
              final movie = movies[index]; // This is now a MovieModel object
              return MovieCard(
                movie: movie,
                onTap: () {
                  Navigator.pushNamed(
                    context,
                    '/details',
                    arguments: movie, // Pass the movie object to DetailsScreen
                  );
                },
              );
            },
          );
        },
      ),
    );
  }
}
