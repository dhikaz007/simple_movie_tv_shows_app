part of 'models.dart';

class WatchListModel {
  final bool? success;
  final int? statusCode;
  final String? statusMessage;

  const WatchListModel({
    required this.success,
    required this.statusCode,
    required this.statusMessage,
  });

  factory WatchListModel.fromJson(Map<String, dynamic> json) {
    return WatchListModel(
      success: json['success'] != null ? json['success'] as bool : null,
      statusCode:
          json['status_code'] != null ? json['status_code'] as int : null,
      statusMessage: json['status_message'] != null
          ? json['status_message'] as String
          : null,
    );
  }

  @override
  String toString() =>
      'WatchListModel(success: $success, statusCode: $statusCode, statusMessage: $statusMessage)';
}
