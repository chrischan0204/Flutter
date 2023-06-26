import '/common_libraries.dart';

class AuditQuestionAssociation extends Equatable {
  final String auditId;
  final String questionId;
  final String userId;
  final bool isIncluded;

  const AuditQuestionAssociation({
    required this.auditId,
    required this.questionId,
    required this.userId,
    required this.isIncluded,
  });

  @override
  List<Object?> get props => [
        auditId,
        questionId,
        userId,
        isIncluded,
      ];

  AuditQuestionAssociation copyWith({
    String? auditId,
    String? questionId,
    String? userId,
    bool? isIncluded,
  }) {
    return AuditQuestionAssociation(
      auditId: auditId ?? this.auditId,
      questionId: questionId ?? this.questionId,
      userId: userId ?? this.userId,
      isIncluded: isIncluded ?? this.isIncluded,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'auditId': auditId,
      'questionId': questionId,
      'userId': userId,
      'isIncluded': isIncluded,
    };
  }

  String toJson() => json.encode(toMap());
}
