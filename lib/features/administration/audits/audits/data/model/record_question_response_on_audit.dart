import 'package:safety_eta/common_libraries.dart';

class RecordQuestionResponseOnAudit extends Equatable {
  final String auditId;
  final String questionId;
  final String selectedResponseId;
  final String userId;

  const RecordQuestionResponseOnAudit({
    required this.auditId,
    required this.questionId,
    required this.selectedResponseId,
    required this.userId,
  });

  @override
  List<Object?> get props => [
        auditId,
        questionId,
        selectedResponseId,
        userId,
      ];

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'auditId': auditId,
      'questionId': questionId,
      'selectedResponseId': selectedResponseId,
      'userId': userId,
    };
  }

  String toJson() => json.encode(toMap());
}
