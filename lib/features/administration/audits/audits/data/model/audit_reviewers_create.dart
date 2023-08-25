import '/common_libraries.dart';

class AuditReviewersCreate extends Equatable {
  final String auditId;
  final List<String> reviewers;
  const AuditReviewersCreate({
    required this.auditId,
    required this.reviewers,
  });

  @override
  List<Object?> get props => [
        auditId,
        reviewers,
      ];

  AuditReviewersCreate copyWith({
    String? auditId,
    List<String>? reviewers,
  }) {
    return AuditReviewersCreate(
      auditId: auditId ?? this.auditId,
      reviewers: reviewers ?? this.reviewers,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'auditId': auditId,
      'reviewers': reviewers,
    };
  }

  factory AuditReviewersCreate.fromMap(Map<String, dynamic> map) {
    return AuditReviewersCreate(
      auditId: map['auditId'] as String,
      reviewers: List<String>.from(map['reviewers']),
    );
  }

  String toJson() => json.encode(toMap());

  factory AuditReviewersCreate.fromJson(String source) =>
      AuditReviewersCreate.fromMap(json.decode(source) as Map<String, dynamic>);
}
