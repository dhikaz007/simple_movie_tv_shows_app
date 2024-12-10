part of 'utils.dart';

class ResponseAPI<T> {
  final T? data;

  const ResponseAPI({this.data});

  factory ResponseAPI.fromJson(T? json) {
    return ResponseAPI(
      data: json,
    );
  }

  @override
  String toString() => 'ResponseAPI(data: $data)';
}

class PaginationResponseAPI<T> {
  final Dates? dates;
  final int page;
  final List<T> results;
  final int totalPages;
  final int totalResults;

  const PaginationResponseAPI({
    this.dates,
    this.page = 0,
    this.results = const [],
    this.totalPages = 1,
    this.totalResults = 0,
  });

  factory PaginationResponseAPI.fromJson(Map<String, dynamic> json) {
    return PaginationResponseAPI<T>(
      dates: json['dates'] != null
          ? Dates.fromJson(json['dates'] as Map<String, dynamic>)
          : null,
      page: json['page'] != 0 ? json['page'] as int : 0,
      results: json['results'] != [] ? List<T>.from(json['results']) : [],
      totalPages: json['total_pages'] != 0 ? json['total_pages'] as int : 1,
      totalResults:
          json['total_results'] != 0 ? json['total_results'] as int : 0,
    );
  }

  @override
  String toString() {
    return 'PaginationResponseAPI(dates: $dates, page: $page, results: $results, totalPages: $totalPages, totalResults: $totalResults)';
  }
}

class Dates {
  final DateTime? maximum;
  final DateTime? minimum;

  const Dates({this.maximum, this.minimum});

  factory Dates.fromJson(Map<String, dynamic> json) {
    return Dates(
      maximum: json['maximum'] != null
          ? DateTime.parse(json['maximum'] as String)
          : null,
      minimum: json['minimum'] != null
          ? DateTime.parse(json['minimum'] as String)
          : null,
    );
  }

  @override
  String toString() => 'Dates(maximum: $maximum, minimum: $minimum)';
}
