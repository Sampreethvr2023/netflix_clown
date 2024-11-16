import 'package:flutter/material.dart';
import '../providers/movie_provider.dart';
import '../models/movie_model.dart';
import '../widgets/movie_card.dart';

class SearchScreen extends StatefulWidget {
  @override
  _SearchScreenState createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  final MovieProvider _movieProvider = MovieProvider();
  final TextEditingController _searchController = TextEditingController();
  Future<List<MovieModel>>? _searchResults;

  void _searchMovies(String query) {
    setState(() {
      _searchResults = _movieProvider.searchMovies(query);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Search Movies'),
        backgroundColor: Colors.red,
      ),
      body: Column(
        children: [
          // Search Bar
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              controller: _searchController,
              decoration: InputDecoration(
                hintText: 'Search movies...',
                border: OutlineInputBorder(),
                suffixIcon: IconButton(
                  icon: const Icon(
                    Icons.search,
                    color: Colors.black,
                  ),
                  onPressed: () {
                    _searchMovies(_searchController.text);
                  },
                ),
              ),
              onSubmitted: _searchMovies,
            ),
          ),
          // Search Results
          Expanded(
            child: FutureBuilder<List<MovieModel>>(
              future: _searchResults,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator());
                } else if (snapshot.hasError) {
                  return Center(child: Text('Error: ${snapshot.error}'));
                } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                  return const Center(child: Text('No movies found.'));
                }

                final movies = snapshot.data!;
                return ListView.builder(
                  itemCount: movies.length,
                  itemBuilder: (context, index) {
                    final movie = movies[index];
                    return MovieCard(
                      movie: movie,
                      onTap: () {
                        // Navigate to the Details Screen with the selected movie
                        Navigator.pushNamed(
                          context,
                          '/details',
                          arguments: movie,
                        );
                      },
                    );
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
