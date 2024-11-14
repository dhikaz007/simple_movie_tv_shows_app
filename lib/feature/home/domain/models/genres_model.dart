part of 'models.dart';

class GenresModel {
  final List<Genres>? genres;

  const GenresModel({this.genres});

  factory GenresModel.fromJson(Map<String, dynamic> json) {
    return GenresModel(
      genres: json['genres'] != null
          ? List<Genres>.from(json['genres']?.map((x) => Genres.fromJson(x)))
          : null,
    );
  }

  @override
  String toString() => 'GenresModel(genres: $genres)';
}

class Genres {
  final int? id;
  final String? name;

  const Genres({this.id, this.name});

  factory Genres.fromJson(Map<String, dynamic> json) {
    return Genres(
      id: json['id'] != null ? json['id'] as int : null,
      name: json['name'] != null ? json['name'] as String : null,
    );
  }

  @override
  String toString() => 'Genres(id: $id, name: $name)';
}
