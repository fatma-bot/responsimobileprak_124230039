import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:responsiapp/models/movie_model.dart';

class FavoriteService {
  static const String _key = 'favorite_movie';

  // AMBIL DATA FAVORIT
  Future<List<MovieModel>> getFavorites() async {
    final prefs = await SharedPreferences.getInstance();
    final List<String>? dataString = prefs.getStringList(_key);

    if (dataString == null) return [];

    // Ubah dari List<String> JSON menjadi List<MealsModel>
    return dataString.map((item) {
      return MovieModel.fromJson(jsonDecode(item));
    }).toList();
  }

  // TAMBAH FAVORIT
  Future<void> addFavorite(MovieModel movie) async {
    final prefs = await SharedPreferences.getInstance();
    final List<MovieModel> currentList = await getFavorites();
    
    // Cek biar gak duplikat
    // if (!currentList.any((element) => element.id == meal.id)) {
    //   currentList.add(Movie);
    //   _saveList(prefs, currentList);
    // }
  }

  // HAPUS FAVORIT
  Future<void> removeFavorite(String id) async {
    final prefs = await SharedPreferences.getInstance();
    final List<MovieModel> currentList = await getFavorites();
    
    // Hapus berdasarkan ID
    currentList.removeWhere((item) => item.id == id);
    _saveList(prefs, currentList);
  }

  // CEK APAKAH SUDAH FAVORIT? (Untuk icon love)
  Future<bool> isFavorite(String id) async {
    final List<MovieModel> currentList = await getFavorites();
    return currentList.any((item) => item.id == id);
  }

  // FUNGSI PRIVAT UNTUK SIMPAN KE STORAGE
  Future<void> _saveList(SharedPreferences prefs, List<MovieModel> list) async {
    // Ubah List Object jadi List String JSON
    final List<String> stringList = list.map((item) => jsonEncode(item.toJson())).toList();
    await prefs.setStringList(_key, stringList);
  }
}