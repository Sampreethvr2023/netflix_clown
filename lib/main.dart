import 'package:flutter/material.dart';
import 'screens/home_screen.dart';
import 'screens/search_screen.dart';
import 'screens/details_screen.dart';
import 'models/movie_model.dart'; // Import MovieModel

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Movie App',
      theme: ThemeData(
        primarySwatch: Colors.red,
        primaryColor: Colors.red,
      ),
      initialRoute: '/',
      routes: {
        '/': (context) => HomeScreen(),
        '/search': (context) => SearchScreen(),
        '/details': (context) {
          // Ensure you fetch the movie argument correctly
          final MovieModel movie =
              ModalRoute.of(context)!.settings.arguments as MovieModel;
          return DetailsScreen(
              movie: movie); // Correctly passing movie to DetailsScreen
        },
      },
    );
  }
}
