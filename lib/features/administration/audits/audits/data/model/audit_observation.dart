import 'dart:convert';

import 'package:equatable/equatable.dart';
import 'package:intl/intl.dart';

class AuditObservation extends Equatable {
  final String id;
  final String description;
  final String status;
  final String reportedByName;
  final DateTime reportedAt;

  const AuditObservation({
    required this.id,
    required this.description,
    required this.status,
    required this.reportedByName,
    required this.reportedAt,
  });

  @override
  List<Object?> get props => [
        id,
        description,
        status,
        reportedByName,
        reportedAt,
      ];

  String get formatedReportedAt => DateFormat('MM/dd/yyyy').format(reportedAt);

  factory AuditObservation.fromMap(Map<String, dynamic> map) {
    return AuditObservation(
      id: map['id'] ?? '',
      description: map['description'] ?? '',
      status: map['status'] ?? '',
      reportedByName: map['reportedByName'] ?? '',
      reportedAt: DateTime.parse(map['reportedAt']),
    );
  }

  factory AuditObservation.fromJson(String source) =>
      AuditObservation.fromMap(json.decode(source) as Map<String, dynamic>);

  AuditObservation copyWith({
    String? id,
    String? description,
    String? status,
    String? reportedByName,
    DateTime? reportedAt,
  }) {
    return AuditObservation(
      id: id ?? this.id,
      description: description ?? this.description,
      status: status ?? this.status,
      reportedByName: reportedByName ?? this.reportedByName,
      reportedAt: reportedAt ?? this.reportedAt,
    );
  }
}
