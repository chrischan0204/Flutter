import 'dart:convert';

import 'package:equatable/equatable.dart';

class ResponseScaleItem extends Equatable {
  final String id;
  final String name;
  final String responseScaleId;
  final int score;
  final String colorCode;
  final bool canComment;
  final bool hasActionItem;
  final bool hasFollowup;
  const ResponseScaleItem({
    required this.id,
    required this.name,
    required this.responseScaleId,
    required this.score,
    required this.colorCode,
    required this.canComment,
    required this.hasActionItem,
    required this.hasFollowup,
  });

  @override
  List<Object?> get props => [
        id,
        name,
        responseScaleId,
        score,
        colorCode,
        canComment,
        hasActionItem,
        hasFollowup,
      ];

  ResponseScaleItem copyWith({
    String? id,
    String? name,
    String? responseScaleId,
    int? score,
    String? colorCode,
    bool? canComment,
    bool? hasActionItem,
    bool? hasFollowup,
  }) {
    return ResponseScaleItem(
      id: id ?? this.id,
      name: name ?? this.name,
      responseScaleId: responseScaleId ?? this.responseScaleId,
      score: score ?? this.score,
      colorCode: colorCode ?? this.colorCode,
      canComment: canComment ?? this.canComment,
      hasActionItem: hasActionItem ?? this.hasActionItem,
      hasFollowup: hasFollowup ?? this.hasFollowup,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'name': name,
      'responseScaleId': responseScaleId,
      'score': score,
      'colorCode': colorCode,
      'canComment': canComment,
      'hasActionItem': hasActionItem,
      'hasFollowup': hasFollowup,
    };
  }

  factory ResponseScaleItem.fromMap(Map<String, dynamic> map) {
    return ResponseScaleItem(
      id: map['id'] as String,
      name: map['name'] as String,
      responseScaleId: map['responseScaleId'] as String,
      score: map['score'] as int,
      colorCode: map['colorCode'] as String,
      canComment: map['canComment'] as bool,
      hasActionItem: map['hasActionItem'] as bool,
      hasFollowup: map['hasFollowup'] as bool,
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
