import 'package:safety_eta/common_libraries.dart';

class AuditCommentUpdate extends Equatable {
  final String id;
  final String userId;
  final String auditId;
  final String questionId;
  final String commentText;

  const AuditCommentUpdate({
    required this.id,
    required this.userId,
    required this.auditId,
    required this.questionId,
    required this.commentText,
  });

  @override
  List<Object> get props {
    return [
      id,
      userId,
      auditId,
      questionId,
      commentText,
    ];
  }

  AuditCommentUpdate copyWith({
    String? id,
    String? userId,
    String? auditId,
    String? questionId,
    String? commentText,
  }) {
    return AuditCommentUpdate(
      id: id ?? this.id,
      userId: userId ?? this.userId,
      auditId: auditId ?? this.auditId,
      questionId: questionId ?? this.questionId,
      commentText: commentText ?? this.commentText,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'userId': userId,
      'auditId': auditId,
      'questionId': questionId,
      'commentText': commentText,
    };
  }

  factory AuditCommentUpdate.fromMap(Map<String, dynamic> map) {
    return AuditCommentUpdate(
      id: map['id'] as String,
      userId: map['userId'] as String,
      auditId: map['auditId'] as String,
      questionId: map['questionId'] as String,
      commentText: map['commentText'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory AuditCommentUpdate.fromJson(String source) =>
      AuditCommentUpdate.fromMap(json.decode(source) as Map<String, dynamic>);
}
