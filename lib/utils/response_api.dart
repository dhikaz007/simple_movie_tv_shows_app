part of 'utils.dart';

class ResponseAPI<T> {
  final T? data;

  const ResponseAPI({this.data});

  factory ResponseAPI.fromJson(T? json) {
    return ResponseAPI(data: json);
  }

  @override
  String toString() => 'ResponseAPI(data: $data)';
}

class PaginationResponseAPI<T> {
  final Dates? dates;
  final int? page;
  final List<T>? results;
  final int? totalPages;
  final int? totalResults;

  const PaginationResponseAPI({
    this.dates,
    this.page,
    this.results,
    this.totalPages,
    this.totalResults,
  });

  factory PaginationResponseAPI.fromJson(Map<String, dynamic> json) {
    return PaginationResponseAPI<T>(
      dates: json['dates'] != null
          ? Dates.fromJson(json['dates'] as Map<String, dynamic>)
          : null,
      page: json['page'] != null ? json['page'] as int : null,
      results: json['results'] != null ? List<T>.from(json['results']) : null,
      totalPages:
          json['total_pages'] != null ? json['total_pages'] as int : null,
      totalResults:
          json['total_results'] != null ? json['total_results'] as int : null,
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
