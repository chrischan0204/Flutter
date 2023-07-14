import 'package:safety_eta/common_libraries.dart';

class AuditComment extends Equatable {
  final String id;
  final String? commentText;
  final String auditId;
  final String auditSectionItemId;
  final bool deleted;
  final DateTime? lastModifiedOn;
  final String? lastModifiedBy;
  final String createdBy;
  final DateTime createdOn;
  const AuditComment({
    required this.id,
    this.commentText,
    required this.auditId,
    required this.auditSectionItemId,
    required this.deleted,
    this.lastModifiedOn,
    this.lastModifiedBy,
    required this.createdBy,
    required this.createdOn,
  });

  AuditComment copyWith({
    String? id,
    String? commentText,
    String? auditId,
    String? auditSectionItemId,
    bool? deleted,
    DateTime? lastModifiedOn,
    String? lastModifiedBy,
    String? createdBy,
    DateTime? createdOn,
  }) {
    return AuditComment(
      id: id ?? this.id,
      commentText: commentText ?? this.commentText,
      auditId: auditId ?? this.auditId,
      auditSectionItemId: auditSectionItemId ?? this.auditSectionItemId,
      deleted: deleted ?? this.deleted,
      lastModifiedOn: lastModifiedOn ?? this.lastModifiedOn,
      lastModifiedBy: lastModifiedBy ?? this.lastModifiedBy,
      createdBy: createdBy ?? this.createdBy,
      createdOn: createdOn ?? this.createdOn,
    );
  }

  factory AuditComment.fromMap(Map<String, dynamic> map) {
    return AuditComment(
      id: map['id'] as String,
      commentText:
          map['commentText'] != null ? map['commentText'] as String : null,
      auditId: map['auditId'] as String,
      auditSectionItemId: map['auditSectionItemId'] as String,
      deleted: map['deleted'] as bool,
      lastModifiedOn: map['lastModifiedOn'] != null
          ? DateTime.parse(map['lastModifiedOn'])
          : null,
      lastModifiedBy: map['lastModifiedBy'] != null
          ? map['lastModifiedBy'] as String
          : null,
      createdBy: map['createdBy'] as String,
      createdOn: DateTime.parse(map['createdOn']),
    );
  }

  factory AuditComment.fromJson(String source) =>
      AuditComment.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  List<Object?> get props => [
        id,
        createdBy,
        createdOn,
        lastModifiedBy,
        lastModifiedOn,
        deleted,
        auditId,
        auditSectionItemId,
        commentText,
      ];
}
