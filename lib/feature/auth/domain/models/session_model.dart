part of 'models.dart';

class SessionModel {
  final bool? success;
  final String? sessionId;

  const SessionModel({this.success, this.sessionId});

  factory SessionModel.fromJson(Map<String, dynamic> json) {
    return SessionModel(
      success: json['success'] != null ? json['success'] as bool : null,
      sessionId:
          json['session_id'] != null ? json['session_id'] as String : null,
    );
  }

  @override
  String toString() => 'SessionModel(success: $success, sessionId: $sessionId)';
}
