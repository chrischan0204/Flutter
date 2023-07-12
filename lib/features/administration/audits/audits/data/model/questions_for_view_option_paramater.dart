import 'package:safety_eta/common_libraries.dart';

class QuestionsForViewOptionParameter extends Equatable {
  final String auditId;
  final String optionType;
  final String optionId;

  const QuestionsForViewOptionParameter({
    required this.auditId,
    required this.optionType,
    required this.optionId,
  });

  @override
  List<Object?> get props => [
        auditId,
        optionType,
        optionId,
      ];

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'auditId': auditId,
      'optionType': optionType,
      'optionId': optionId,
    };
  }

  factory QuestionsForViewOptionParameter.fromMap(Map<String, dynamic> map) {
    return QuestionsForViewOptionParameter(
      auditId: map['auditId'] as String,
      optionType: map['optionType'] as String,
      optionId: map['optionId'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory QuestionsForViewOptionParameter.fromJson(String source) =>
      QuestionsForViewOptionParameter.fromMap(
          json.decode(source) as Map<String, dynamic>);
}
