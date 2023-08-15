import '/common_libraries.dart';

class ResponseScaleItem extends Equatable {
  final String? id;
  final String responseScaleId;
  final String? name;
  final bool isRequired;
  final String score;
  final int order;
  final bool isNew;

  const ResponseScaleItem({
    required this.id,
    required this.responseScaleId,
    required this.name,
    required this.isRequired,
    required this.score,
    required this.order,
    this.isNew = false,
  });

  @override
  List<Object?> get props => [
        id,
        responseScaleId,
        name,
        isRequired,
        score,
        order,
        isNew,
      ];

  ResponseScaleItem copyWith({
    String? id,
    String? responseScaleId,
    String? name,
    bool? isRequired,
    String? score,
    int? order,
    bool? isNew,
  }) {
    return ResponseScaleItem(
      id: id ?? this.id,
      responseScaleId: responseScaleId ?? this.responseScaleId,
      name: name ?? this.name,
      isRequired: isRequired ?? this.isRequired,
      score: score ?? this.score,
      order: order ?? this.order,
      isNew: isNew ?? this.isNew,
    );
  }

  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      'id': isNew ? null : id,
      'responseScaleId': responseScaleId,
      'name': name,
      'isRequired': isRequired,
      'score': score,
      'order': order,
    };
  }

  factory ResponseScaleItem.fromMap(Map<String, dynamic> map) {
    return ResponseScaleItem(
      id: map['id'] != null ? map['id'] as String : null,
      responseScaleId: map['responseScaleId'] as String,
      name: map['name'] != null ? map['name'] as String : null,
      isRequired: map['isRequired'] as bool,
      score: map['score'].toString(),
      order: map['order'] as int,
    );
  }

  factory ResponseScaleItem.fromJson(String source) =>
      ResponseScaleItem.fromMap(json.decode(source) as Map<String, dynamic>);
}
