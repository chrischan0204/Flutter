import '/common_libraries.dart';

class AuditSectionAssociation extends Equatable {
  final String auditId;
  final String userId;
  final String sectionId;
  final bool isIncluded;

  const AuditSectionAssociation({
    required this.auditId,
    required this.userId,
    required this.sectionId,
    required this.isIncluded,
  });
  @override
  List<Object?> get props => [
        auditId,
        userId,
        sectionId,
        isIncluded,
      ];

  AuditSectionAssociation copyWith({
    String? auditId,
    String? userId,
    String? sectionId,
    bool? isIncluded,
  }) {
    return AuditSectionAssociation(
      auditId: auditId ?? this.auditId,
      userId: userId ?? this.userId,
      sectionId: sectionId ?? this.sectionId,
      isIncluded: isIncluded ?? this.isIncluded,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'auditId': auditId,
      'userId': userId,
      'sectionId': sectionId,
      'isIncluded': isIncluded,
    };
  }

  String toJson() => json.encode(toMap());
}
