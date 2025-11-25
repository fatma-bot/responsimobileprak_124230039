import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:responsiapp/models/movie_model.dart';

class MovieService {
  final String baseUrl =
      "https://681388b3129f6313e2119693.mockapi.io/api/v1/movie";


  Future<List<MovieModel>> fetchMovieData() async {
    final response = await http.get(Uri.parse(baseUrl));
    if (response.statusCode == 200) {
      final result = jsonDecode(response.body);
      final movieData = result['data'];

      List<MovieModel> listMovieModel = [];
      for (var data in movieData) {
        
        MovieModel movieModel = MovieModel(
          id: data['id'] ?? "",
          title: data['title'] ?? "",
          release_date: data['release_date'] ?? "",
          imgUrl: data['imgUrl'] ?? "",
          rating: data['rating'] ?? "",
          genre: data['genre'] ?? "",
          created_at: data['created_at'] ?? "",
          description: data['description'] ?? "",
          director: data['director'] ?? "",
          cast: data['cast'] ?? "",
          language: data['language'] ?? "",
          duration: data['duration'] ?? "",
        );
        listMovieModel.add(movieModel);
      }
      return listMovieModel;
    }
    return [];
  }
}
