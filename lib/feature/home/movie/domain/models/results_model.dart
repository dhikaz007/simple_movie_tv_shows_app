part of 'models.dart';

class ResultsModel {
  final bool? adult;
  final String? backdropPath;
  final List<int>? genreIds;
  final int? id;
  final String? originalLanguage;
  final String? originalTitle;
  final String? overview;
  final double? popularity;
  final String? posterPath;
  final DateTime? releaseDate;
  final String? title;
  final bool? video;
  final double? voteAverage;
  final int? voteCount;

  const ResultsModel({
    this.adult,
    this.backdropPath,
    this.genreIds,
    this.id,
    this.originalLanguage,
    this.originalTitle,
    this.overview,
    this.popularity,
    this.posterPath,
    this.releaseDate,
    this.title,
    this.video,
    this.voteAverage,
    this.voteCount,
  });

  factory ResultsModel.fromJson(Map<String, dynamic> json) {
    return ResultsModel(
      adult: json['adult'] != null ? json['adult'] as bool : null,
      backdropPath: json['backdrop_path'] != null
          ? json['backdrop_path'] as String
          : null,
      genreIds:
          json['genre_ids'] != null ? List<int>.from(json['genre_ids']) : null,
      id: json['id'] != null ? json['id'] as int : null,
      originalLanguage: json['original_language'] != null
          ? json['original_language'] as String
          : null,
      originalTitle: json['original_title'] != null
          ? json['original_title'] as String
          : null,
      overview: json['overview'] != null ? json['overview'] as String : null,
      popularity:
          json['popularity'] != null ? json['popularity'] as double : null,
      posterPath:
          json['poster_path'] != null ? json['poster_path'] as String : null,
      releaseDate: (json['release_date'] != null && json['release_date'] != "")
          ? DateTime.parse(json['release_date'] as String)
          : null,
      title: json['title'] != null ? json['title'] as String : null,
      video: json['video'] != null ? json['video'] as bool : null,
      voteAverage:
          json['vote_average'] != null ? json['vote_average'] as double : null,
      voteCount: json['vote_count'] != null ? json['vote_count'] as int : null,
    );
  }

  @override
  String toString() {
    return 'ResultsModel(adult: $adult, backdropPath: $backdropPath, genreIds: $genreIds, id: $id, originalLanguage: $originalLanguage, originalTitle: $originalTitle, overview: $overview, popularity: $popularity, posterPath: $posterPath, releaseDate: $releaseDate, title: $title, video: $video, voteAverage: $voteAverage, voteCount: $voteCount)';
  }
}
