import 'dart:convert';

import 'package:equatable/equatable.dart';

class ResponseScaleItem extends Equatable {
  final String id;
  final String name;
  final String responseScaleItemId;
  final double score;
  final bool commentRequiered;
  final bool actionItemRequired;
  final bool followUpRequired;
  final int order;
  const ResponseScaleItem({
    required this.id,
    required this.name,
    required this.responseScaleItemId,
    required this.score,
    required this.commentRequiered,
    required this.actionItemRequired,
    required this.followUpRequired,
    required this.order,
  });

  @override
  List<Object?> get props => [
        id,
        name,
        responseScaleItemId,
        score,
        commentRequiered,
        actionItemRequired,
        followUpRequired,
        order,
      ];

  ResponseScaleItem copyWith({
    String? id,
    String? name,
    String? responseScaleItemId,
    double? score,
    bool? commentRequiered,
    bool? actionItemRequired,
    bool? followUpRequired,
    int? order,
  }) {
    return ResponseScaleItem(
      id: id ?? this.id,
      name: name ?? this.name,
      responseScaleItemId: responseScaleItemId ?? this.responseScaleItemId,
      score: score ?? this.score,
      commentRequiered: commentRequiered ?? this.commentRequiered,
      actionItemRequired: actionItemRequired ?? this.actionItemRequired,
      followUpRequired: followUpRequired ?? this.followUpRequired,
      order: order ?? this.order,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'name': name,
      'responseScaleItemId': responseScaleItemId,
      'score': score,
      'commentRequiered': commentRequiered,
      'actionItemRequired': actionItemRequired,
      'followUpRequired': followUpRequired,
    };
  }

  factory ResponseScaleItem.fromMap(Map<String, dynamic> map) {
    return ResponseScaleItem(
      id: map['id'] ?? '',
      name: map['name'] ?? '',
      responseScaleItemId: map['responseScaleItemId'] ?? '',
      score: map['score'] ?? 0,
      commentRequiered: map['commentRequiered'] ?? true,
      actionItemRequired: map['actionItemRequired'] ?? true,
      followUpRequired: map['followUpRequired'] ?? true,
      order: map['order'] ?? 0,
    );
  }

  String toJson() => json.encode(toMap());

  factory ResponseScaleItem.fromJson(String source) =>
      ResponseScaleItem.fromMap(json.decode(source) as Map<String, dynamic>);

  static List<ResponseScaleItem> fromListJson(String source) {
    return List.from(json.decode(source))
        .map((e) => ResponseScaleItem.fromMap(e))
        .toList();
  }
}
