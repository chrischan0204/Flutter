import '/common_libraries.dart';

class QuestionDetail extends Equatable {
  final String id;
  final String name;
  final String responseScaleId;
  final int order;
  final List<ResponseScaleItem> responseScaleItems;
  const QuestionDetail({
    required this.id,
    required this.name,
    required this.responseScaleId,
    required this.order,
    required this.responseScaleItems,
  });

  QuestionDetail copyWith({
    String? id,
    String? name,
    String? responseScaleId,
    int? order,
    List<ResponseScaleItem>? responseScaleItems,
  }) {
    return QuestionDetail(
      id: id ?? this.id,
      name: name ?? this.name,
      responseScaleId: responseScaleId ?? this.responseScaleId,
      order: order ?? this.order,
      responseScaleItems: responseScaleItems ?? this.responseScaleItems,
    );
  }

  @override
  List<Object?> get props => [
        id,
        name,
        responseScaleId,
        order,
        responseScaleItems,
      ];

  factory QuestionDetail.fromMap(Map<String, dynamic> map) {
    return QuestionDetail(
      id: map['id'] as String,
      name: map['name'] as String,
      responseScaleId: map['responseScaleId'] as String,
      order: map['order'] as int,
      responseScaleItems: List.from(
        (map['responseScaleItems']).map((x) => ResponseScaleItem.fromMap(x)),
      ),
    );
  }

  factory QuestionDetail.fromJson(String source) =>
      QuestionDetail.fromMap(json.decode(source) as Map<String, dynamic>);
}
