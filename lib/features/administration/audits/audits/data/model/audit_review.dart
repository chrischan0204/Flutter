import '/common_libraries.dart';

class AuditReview extends Equatable {
  final String id;
  final String auditId;
  final String? reviewerName;
  final String reviewerId;
  final DateTime? reviewDate;
  final String? reviewComments;

  const AuditReview({
    required this.id,
    required this.auditId,
    this.reviewerName,
    required this.reviewerId,
    this.reviewDate,
    this.reviewComments,
  });

  AuditReview copyWith({
    String? id,
    String? auditId,
    String? reviewerName,
    DateTime? reviewDate,
    String? reviewComments,
    String? reviewerId,
  }) {
    return AuditReview(
      id: id ?? this.id,
      auditId: auditId ?? this.auditId,
      reviewerName: reviewerName ?? this.reviewerName,
      reviewDate: reviewDate ?? this.reviewDate,
      reviewComments: reviewComments ?? this.reviewComments,
      reviewerId: reviewerId ?? this.reviewerId,
    );
  }

  AuditReviewUpdate get reviewUpate => AuditReviewUpdate(
        id: id,
        reviewComments: reviewComments ?? '',
        userId: reviewerId,
      );

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'auditId': auditId,
      'reviewerName': reviewerName,
      'reviewDate': reviewDate?.toIso8601String(),
      'reviewComments': reviewComments,
      'reviewerId': reviewerId,
    };
  }

  factory AuditReview.fromMap(Map<String, dynamic> map) {
    return AuditReview(
      id: map['id'] as String,
      auditId: map['auditId'] as String,
      reviewerName:
          map['reviewerName'] != null ? map['reviewerName'] as String : null,
      reviewDate:
          map['reviewDate'] != null ? DateTime.parse(map['reviewDate']) : null,
      reviewComments: map['reviewComments'] != null
          ? map['reviewComments'] as String
          : null,
      reviewerId: map['reviewerId'],
    );
  }

  String toJson() => json.encode(toMap());

  factory AuditReview.fromJson(String source) =>
      AuditReview.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  List<Object?> get props => [
        id,
        auditId,
        reviewerName,
        reviewDate,
        reviewComments,
        reviewerId,
      ];
}
