import 'package:flutter/material.dart';
import 'package:responsiapp/services/movie_service.dart';
import 'package:hive_flutter/hive_flutter.dart';

class HomeScreens extends StatefulWidget {
  const HomeScreens({super.key});

  @override
  State<HomeScreens> createState() => _HomeScreensState();
}

class _HomeScreensState extends State<HomeScreens> {
  final MovieService movieService = MovieService();

  @override
  Widget build(BuildContext context) {
    var box = Hive.box('session');
    String username = box.get('username', defaultValue: 'User');

    return Scaffold(
      appBar: AppBar(title: Text("${username}")),
      body: FutureBuilder(
        future: movieService.fetchMovieData(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            debugPrint(snapshot.error.toString());
            return const Text("error cik");
          } else if (snapshot.data!.isEmpty) {
            return const Text("kosong cik");
          }
          final movie = snapshot.data!;
          return ListView.builder(
            itemCount: movie.length,
            itemBuilder: (context, index) {
              final Movie = movie[index];
              return _movieList(Movie);
            },
          );
        },
      ),
      
    );
    
  }

  Widget _movieList(movie) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      child: Card(
        elevation: 3,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadiusGeometry.circular(12),
        ),
        child: ListTile(
          leading: ClipRRect(
            borderRadius: BorderRadiusGeometry.circular(8),
            child: Image.network(movie.imgUrl, fit: BoxFit.cover),
          ),
          title: Text(
            movie.title,
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          subtitle: Text(
            "${movie.release_date} | ${movie.genre} | ${movie.rating}",
          ),
          
          // trailing: IconButton(
          //   icon: const Icon(Icons.favorite_border),
          //   onPressed: () async {
          //     await FavoriteServices().addFavorite(amiibo);
          //     ScaffoldMessenger.of(context).showSnackBar(
          //       SnackBar(content: Text("Ditambahkan ke Favorite")),
          //     );
          //   },
          // ),
          onTap: () {
            // Navigator.push(
            //   context,
            //   MaterialPageRoute(
            //     builder: (context) {
            //       return DetailScreens(amiibo: amiibo);
            //     },
            //   ),
            // );
          },
        ),
      ),
    );
  }

  // Widget _amiiboList(context, amiibo) {
  //   return InkWell(
  //     onTap: () {},
  //     child: Container(
  //       decoration: BoxDecoration(
  //         color: Colors.blueGrey.shade100,
  //         borderRadius: BorderRadius.all(Radius.circular(15)),
  //       ),
  //       child: Column(
  //         children: [
  //           Image.network(amiibo.image),
  //           Text(amiibo.name, style: TextStyle(fontWeight: FontWeight.bold)),
  //           Text("Game Series: ${amiibo.gameSeries}"),
  //         ],
  //       ),
  //     ),
  //   );
  // }
}
