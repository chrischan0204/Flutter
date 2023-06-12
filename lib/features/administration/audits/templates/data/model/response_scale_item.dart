import 'dart:convert';

import 'package:equatable/equatable.dart';

class ResponseScaleItem extends Equatable {
  final String id;
  final String name;
  final String? responseScaleItemId;
  final bool isRequired;
  final bool included;
  final double score;
  final bool commentRequired;
  final bool actionItemRequired;
  final bool followUpRequired;
  final int order;
  const ResponseScaleItem({
    required this.id,
    required this.name,
    this.responseScaleItemId,
    required this.isRequired,
    required this.included,
    required this.score,
    required this.commentRequired,
    required this.actionItemRequired,
    required this.followUpRequired,
    required this.order,
  });

  @override
  List<Object?> get props => [
        id,
        name,
        responseScaleItemId,
        isRequired,
        included,
        score,
        commentRequired,
        actionItemRequired,
        followUpRequired,
        order,
      ];

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'name': name,
      'responseScaleItemId': id,
      'score': score,
      'commentRequired': commentRequired,
      'actionItemRequired': actionItemRequired,
      'followUpRequired': followUpRequired,
    };
  }

  factory ResponseScaleItem.fromMap(Map<String, dynamic> map) {
    return ResponseScaleItem(
      id: map['id'] ?? '',
      name: map['name'] ?? '',
      isRequired: map['isRequired'] ?? false,
      included:
          (map['isRequired'] as bool) == true ? true : map['included'] ?? false,
      responseScaleItemId: map['responseScaleItemId'] ?? '',
      score: map['score'] ?? 0,
      commentRequired: map['commentRequired'] ?? false,
      actionItemRequired: map['actionItemRequired'] ?? false,
      followUpRequired: map['followUpRequired'] ?? false,
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

  ResponseScaleItem copyWith({
    String? id,
    String? name,
    String? responseScaleItemId,
    bool? isRequired,
    bool? included,
    double? score,
    bool? commentRequired,
    bool? actionItemRequired,
    bool? followUpRequired,
    int? order,
  }) {
    return ResponseScaleItem(
      id: id ?? this.id,
      name: name ?? this.name,
      responseScaleItemId: responseScaleItemId ?? this.responseScaleItemId,
      isRequired: isRequired ?? this.isRequired,
      included: included ?? this.included,
      score: score ?? this.score,
      commentRequired: commentRequired ?? this.commentRequired,
      actionItemRequired: actionItemRequired ?? this.actionItemRequired,
      followUpRequired: followUpRequired ?? this.followUpRequired,
      order: order ?? this.order,
    );
  }
}
