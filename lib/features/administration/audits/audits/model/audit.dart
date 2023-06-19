// import '/common_libraries.dart';

// class Audit extends Entity {
//   final String auditNumber;

//   final String auditDate;
//   final String auditStatusName;
  
//   final double completed;

//   final String siteName;

//   final String projectName;

//   final String templateName;

//   final String owner;

//   final int score;

//   const Audit({
//     super.id,
//     super.name,
//     required this.auditNumber,
//     required this.auditDate,
//     required this.auditStatusName,
//     required this.completed,
//     required this.siteName,
//     required this.projectName,
//     required this.templateName,
//     required this.owner,
//     required this.score,
//     super.active,
//     super.createdByUserName,
//     super.createdOn,
//     super.columns,
//     super.deleted,
//   });

//   @override
//   List<Object?> get props => [
//         ...super.props,
//         auditNumber,
//         auditStatusName,
//         completed,
//         siteName,
//         projectName,
//         templateName,
//         owner,
//         score,
//       ];

//   String get formatedAuditDate => auditDate.isNotEmpty
//       ? FormatDate(format: 'd MMMM y', dateString: auditDate).formatDate
//       : '--';

//   @override
//   Map<String, dynamic> tableItemsToMap() {
//     return {
//       'Audit': name,
//       'Status': auditStatusName,
//       'Complete': completed,
//       'Site': siteName,
//       'Template': templateName,
//       'Owner': owner,
//       'Score': score,
//     };
//   }

//   @override
//   Map<String, dynamic> sideDetailItemsToMap() {
//     return {
//       'Audit': name,
//       'Status': auditStatusName,
//       'Complete': completed,
//       'Site': siteName,
//       'Template': templateName,
//       'Owner': owner,
//       'Score': score,
//     };
//   }

//   @override
//   Map<String, dynamic> toMap() {
//     Map<String, dynamic> map = {
//       'userId': 'revisionDate',
//       'name': name,
//       'auditDate': auditDate,
//     };
    
//     return map;
//   }

//   factory Audit.fromMap(Map<String, dynamic> map) {
//     Entity entity = Entity.fromMap(map);
//     return Audit(
//       id: entity.id,
//       name: entity.name,
//       revisionDate: map['revisionDate'] ?? '',
//       locked: map['locked'] ?? false,
//       usedInAudits: map['usedInAudits'] ?? 0,
//       usedInSites: map['usedInSites'] ?? 0,
//       templateSites: map['templateSites'] ?? '',
//       active: entity.active,
//       createdByUserName: entity.createdByUserName,
//       createdOn: entity.createdOn,
//     );
//   }

//   @override
//   Map<String, dynamic> detailItemsToMap() {
//     return {
//       'Template Description': name,
//       'Revision Date': revisionDate,
//     };
//   }

//   String toJson() => json.encode(toMap());

//   factory Audit.fromJson(String source) =>
//       Audit.fromMap(json.decode(source) as Map<String, dynamic>);

//   Template copyWith({
//     String? id,
//     String? name,
//     String? revisionDate,
//     bool? usedInAudit,
//     bool? usedInInspection,
//     bool? locked,
//     int? usedInAudits,
//     bool? active,
//     String? createdOn,
//     String? createdByUserName,
//     bool? deleted,
//     List<String>? columns,
//   }) {
//     return Template(
//       id: id ?? this.id,
//       name: name ?? this.name,
//       revisionDate: revisionDate ?? this.revisionDate,
//       locked: locked ?? this.locked,
//       usedInAudits: usedInAudits ?? this.usedInAudits,
//       active: active ?? this.active,
//       createdOn: createdOn ?? this.createdOn,
//       createdByUserName: createdByUserName ?? this.createdByUserName,
//       deleted: deleted ?? this.deleted,
//       columns: columns ?? this.columns,
//     );
//   }
// }
