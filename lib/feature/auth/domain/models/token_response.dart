part of 'models.dart';

class TokenResponse {
  final bool? success;
  final DateTime? expiresAt;
  final String? requestToken;

  const TokenResponse({
    this.success,
    this.expiresAt,
    this.requestToken,
  });

  factory TokenResponse.fromJson(Map<String, dynamic> json) {
    return TokenResponse(
      success: json['success'] != null ? json['success'] as bool : null,
      expiresAt: json['expires_at'] != null
          ? parseDate(json['expires_at'] as String)
          : null,
      requestToken: json['request_token'] != null
          ? json['request_token'] as String
          : null,
    );
  }

  static DateTime parseDate(String dateString) {
    // Replace 'UTC' with 'Z' for ISO 8601 format compatibility
    final replaced = dateString.replaceFirst('UTC', 'Z');
    return DateTime.parse(replaced);
  }

  @override
  String toString() =>
      'TokenResponse(success: $success, expiresAt: $expiresAt, requestToken: $requestToken)';
}
