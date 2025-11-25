class MovieModel {
  String id;
  String title;
  String release_date;
  String imgUrl;
  String rating;
  List<String> genre;
  String created_at;
  String description;
  String director;
  List<String> cast;
  String language;
  String duration;

  MovieModel({
    required this.id,
    required this.title,
    required this.release_date,
    required this.imgUrl,
    required this.rating,
    required this.genre,
    required this.created_at,
    required this.description,
    required this.director,
    required this.cast,
    required this.language,
    required this.duration,
  });

  //JSON -> Object
  factory MovieModel.fromJson(Map<String, dynamic> json) {
    return MovieModel(
      id: json['id'] ?? "",
      title: json['title'] ?? "",
      release_date: json['release_date'] ?? "",
      imgUrl: json['imgUrl'] ?? "",
      rating: json['rating'] ?? "",
      genre: json['genre'] ?? "",
      created_at: json['created_at'] ?? "",
      description: json['description'] ?? "",
      director: json['director'] ?? "",
      cast: json['cast'] ?? "",
      language: json['language'] ?? "",
      duration: json['duration'] ?? "",
    );
  }

  //Object -> JSON
  Map<String, dynamic> toJson() {
    return {
      id: id,
      title: title,
      release_date: release_date,
      imgUrl: imgUrl,
      rating: rating,
      //genre: genre,
      created_at: created_at,
      description: description,
      director: director,
      //cast: cast,
      language: language,
      duration: duration,
    };
  }
}
