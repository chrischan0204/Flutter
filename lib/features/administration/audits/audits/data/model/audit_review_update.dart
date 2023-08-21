import '/common_libraries.dart';

class AuditReviewUpdate extends Equatable {
  final String id;
  final String reviewComments;
  final String userId;

  const AuditReviewUpdate({
    required this.id,
    required this.reviewComments,
    required this.userId,
  });

  @override
  List<Object> get props => [
        id,
        reviewComments,
        userId,
      ];

  AuditReviewUpdate copyWith({
    String? id,
    String? reviewComments,
    String? userId,
  }) {
    return AuditReviewUpdate(
      id: id ?? this.id,
      reviewComments: reviewComments ?? this.reviewComments,
      userId: userId ?? this.userId,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'reviewComments': reviewComments,
      'userId': userId,
    };
  }

  String toJson() => json.encode(toMap());
}
