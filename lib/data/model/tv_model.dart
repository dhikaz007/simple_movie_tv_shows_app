
// ignore_for_file: no_leading_underscores_for_local_identifiers

class TVModel {
  int? page;
  List<TVResult>? results;
  int? totalPages;
  int? totalResults;

  TVModel({this.page, this.results, this.totalPages, this.totalResults});

  TVModel.fromJson(Map<String, dynamic> json) {
    if(json["page"] is int) {
      page = json["page"];
    }
    if(json["results"] is List) {
      results = json["results"] == null ? null : (json["results"] as List).map((e) => TVResult.fromJson(e)).toList();
    }
    if(json["total_pages"] is int) {
      totalPages = json["total_pages"];
    }
    if(json["total_results"] is int) {
      totalResults = json["total_results"];
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> _data = <String, dynamic>{};
    _data["page"] = page;
    if(results != null) {
      _data["results"] = results?.map((e) => e.toJson()).toList();
    }
    _data["total_pages"] = totalPages;
    _data["total_results"] = totalResults;
    return _data;
  }
}

class TVResult {
  String? backdropPath;
  String? firstAirDate;
  List<int>? genreIds;
  int? id;
  String? name;
  List<String>? originCountry;
  String? originalLanguage;
  String? originalName;
  String? overview;
  double? popularity;
  String? posterPath;
  double? voteAverage;
  int? voteCount;

  TVResult({this.backdropPath, this.firstAirDate, this.genreIds, this.id, this.name, this.originCountry, this.originalLanguage, this.originalName, this.overview, this.popularity, this.posterPath, this.voteAverage, this.voteCount});

  TVResult.fromJson(Map<String, dynamic> json) {
    if(json["backdrop_path"] is String) {
      backdropPath = json["backdrop_path"];
    }
    if(json["first_air_date"] is String) {
      firstAirDate = json["first_air_date"];
    }
    if(json["genre_ids"] is List) {
      genreIds = json["genre_ids"] == null ? null : List<int>.from(json["genre_ids"]);
    }
    if(json["id"] is int) {
      id = json["id"];
    }
    if(json["name"] is String) {
      name = json["name"];
    }
    if(json["origin_country"] is List) {
      originCountry = json["origin_country"] == null ? null : List<String>.from(json["origin_country"]);
    }
    if(json["original_language"] is String) {
      originalLanguage = json["original_language"];
    }
    if(json["original_name"] is String) {
      originalName = json["original_name"];
    }
    if(json["overview"] is String) {
      overview = json["overview"];
    }
    if(json["popularity"] is double) {
      popularity = json["popularity"];
    }
    if(json["poster_path"] is String) {
      posterPath = json["poster_path"];
    }
    if(json["vote_average"] is double) {
      voteAverage = json["vote_average"];
    }
    if(json["vote_count"] is int) {
      voteCount = json["vote_count"];
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> _data = <String, dynamic>{};
    _data["backdrop_path"] = backdropPath;
    _data["first_air_date"] = firstAirDate;
    if(genreIds != null) {
      _data["genre_ids"] = genreIds;
    }
    _data["id"] = id;
    _data["name"] = name;
    if(originCountry != null) {
      _data["origin_country"] = originCountry;
    }
    _data["original_language"] = originalLanguage;
    _data["original_name"] = originalName;
    _data["overview"] = overview;
    _data["popularity"] = popularity;
    _data["poster_path"] = posterPath;
    _data["vote_average"] = voteAverage;
    _data["vote_count"] = voteCount;
    return _data;
  }
}