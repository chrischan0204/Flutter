// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:safety_eta/common_libraries.dart';

class AuditCommentCreate extends Equatable {
  final String userId;
  final String auditId;
  final String questionId;
  final String commentText;

  const AuditCommentCreate({
    required this.userId,
    required this.auditId,
    required this.questionId,
    required this.commentText,
  });

  @override
  List<Object> get props => [userId, auditId, questionId, commentText];

  AuditCommentCreate copyWith({
    String? userId,
    String? auditId,
    String? questionId,
    String? commentText,
  }) {
    return AuditCommentCreate(
      userId: userId ?? this.userId,
      auditId: auditId ?? this.auditId,
      questionId: questionId ?? this.questionId,
      commentText: commentText ?? this.commentText,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'userId': userId,
      'auditId': auditId,
      'questionId': questionId,
      'commentText': commentText,
    };
  }

  String toJson() => json.encode(toMap());
}
