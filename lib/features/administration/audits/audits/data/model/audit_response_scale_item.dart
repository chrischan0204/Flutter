
import 'package:safety_eta/common_libraries.dart';

class AuditResponseScaleItem extends Equatable {
  final String id;
  final bool isSelected;
  final String name;
  final bool commentRequired;
  final bool actionItemRequired;
  final bool followUpRequired;
  final double score;
  final int order;

  const AuditResponseScaleItem({
    required this.id,
    required this.isSelected,
    required this.name,
    required this.commentRequired,
    required this.actionItemRequired,
    required this.followUpRequired,
    required this.score,
    required this.order,
  });

  AuditResponseScaleItem copyWith({
    String? id,
    bool? isSelected,
    String? name,
    bool? commentRequired,
    bool? actionItemRequired,
    bool? followUpRequired,
    double? score,
    int? order,
  }) {
    return AuditResponseScaleItem(
      id: id ?? this.id,
      isSelected: isSelected ?? this.isSelected,
      name: name ?? this.name,
      commentRequired: commentRequired ?? this.commentRequired,
      actionItemRequired: actionItemRequired ?? this.actionItemRequired,
      followUpRequired: followUpRequired ?? this.followUpRequired,
      score: score ?? this.score,
      order: order ?? this.order,
    );
  }

  @override
  List<Object?> get props => [
        id,
        isSelected,
        name,
        commentRequired,
        actionItemRequired,
        followUpRequired,
        score,
        order,
      ];

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'isSelected': isSelected,
      'name': name,
      'commentRequired': commentRequired,
      'actionItemRequired': actionItemRequired,
      'followUpRequired': followUpRequired,
      'score': score,
      'order': order,
    };
  }

  factory AuditResponseScaleItem.fromMap(Map<String, dynamic> map) {
    return AuditResponseScaleItem(
      id: map['id'] as String,
      isSelected: map['isSelected'] as bool,
      name: map['name'] as String,
      commentRequired: map['commentRequired'] as bool,
      actionItemRequired: map['actionItemRequired'] as bool,
      followUpRequired: map['followUpRequired'] as bool,
      score: map['score'] as double,
      order: map['order'] as int,
    );
  }

  String toJson() => json.encode(toMap());

  factory AuditResponseScaleItem.fromJson(String source) =>
      AuditResponseScaleItem.fromMap(
          json.decode(source) as Map<String, dynamic>);
}
