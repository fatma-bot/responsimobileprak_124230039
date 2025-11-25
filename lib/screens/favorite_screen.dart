import 'package:flutter/material.dart';
import 'package:responsiapp/models/movie_model.dart';
import 'package:responsiapp/services/favorite_service.dart';
import 'package:responsiapp/services/movie_service.dart';

class FavoriteScreen extends StatefulWidget {
  const FavoriteScreen({super.key});

  @override
  State<FavoriteScreen> createState() => _FavoriteScreenState();
}

class _FavoriteScreenState extends State<FavoriteScreen> {
  final FavoriteService favService = FavoriteService();
  late Future<List<MovieModel>> _favoriteFuture;

  @override
  void initState() {
    super.initState();
    _refreshList();
  }

  // Fungsi untuk memuat ulang data
  void _refreshList() {
    setState(() {
      _favoriteFuture = favService.getFavorites();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Favorites")),
      body: FutureBuilder<List<MovieModel>>(
        future: _favoriteFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(child: Text("Belum ada data favorite"));
          }

          final favorites = snapshot.data!;

          return ListView.builder(
            itemCount: favorites.length,
            itemBuilder: (context, index) {
              final movie = favorites[index];

              return Dismissible(
                // Key Wajib Unik (Pakai ID)
                key: Key(movie.id ?? UniqueKey().toString()),
                direction: DismissDirection.endToStart,
                background: Container(
                  color: Colors.red,
                  alignment: Alignment.centerRight,
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: const Icon(Icons.delete, color: Colors.white),
                ),

                // LOGIKA HAPUS SAAT DI-
                onDismissed: (direction) async {
                  // 1. Hapus dari SharedPreferences
                  await favService.removeFavorite(movie.id ?? '');

                  // 2. Tampilkan SnackBar
                  if (mounted) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text("${movie.title} dihapus")),
                    );
                  }
                },

                // Tampilan Kartu
                child: Card(
                  margin: const EdgeInsets.symmetric(
                    horizontal: 15,
                    vertical: 8,
                  ),
                  child: ListTile(
                    leading: ClipRRect(
                      borderRadius: BorderRadius.circular(8),
                      child: Image.network(
                        movie.imgUrl ?? '',
                        width: 50,
                        height: 50,
                        fit: BoxFit.cover,
                        errorBuilder: (_, __, ___) =>
                            const Icon(Icons.fastfood),
                      ),
                    ),
                    title: Text(movie.title ?? "-"),
                    subtitle: Text(movie.description ?? "-"),
                    onTap: () {
                      // Navigasi ke Detail kalau mau
                    },
                  ),
                ),
              );
            },
          );
        },
      ),
      
    );
  }
}
