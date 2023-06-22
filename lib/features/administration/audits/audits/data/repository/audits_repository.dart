import 'package:uuid/uuid.dart';

import '/common_libraries.dart';

class AuditsRepository extends BaseRepository {
  AuditsRepository({
    required super.token,
    required super.authBloc,
  }) : super(url: '/api/audits');

  // get audits list
  Future<List<Audit>> getAuditList() async {
    Response response = await super.get(url);
    if (response.statusCode == 200) {
      return List.from(jsonDecode(response.body))
          .map((auditMap) => Audit.fromMap(auditMap))
          .toList();
    }
    return [];
  }

  // get audit by id
  Future<Audit> getAuditById(
    String auditId,
  ) async {
    Response response = await super.get('$url/$auditId');

    if (response.statusCode == 200) {
      return Audit.fromJson(response.body);
    }

    throw Exception();
  }

  // add audit
  Future<Audit> addAudit(AuditCreate audit) async {
    Response response = await super.post(url, body: audit.toJson());

    if (response.statusCode == 200) {
      return Audit.fromJson(response.body);
    }
    throw Exception();
  }

  // edit audit
  Future<EntityResponse> editAudit(AuditCreate audit) async {
    Response response = await super.put(
      url,
      body: audit.toJson(),
    );

    if (response.statusCode != 500) {
      if (response.statusCode == 200) {
        return EntityResponse(
          statusCode: response.statusCode,
          isSuccess: true,
          message: response.body,
        );
      }
      return EntityResponse.fromJson(response.body);
    }
    throw Exception();
  }

  Future<EntityResponse> deleteAudit(String auditId) async {
    Response response = await super.delete('$url/$auditId');

    if (response.statusCode != 500) {
      if (response.statusCode == 200) {
        return EntityResponse(
          statusCode: response.statusCode,
          isSuccess: true,
          message: response.body,
        );
      }
      return EntityResponse.fromJson(response.body);
    }

    throw Exception();
  }

  Future<FilteredAuditData> getFilteredAuditList(
      FilteredTableParameter option) async {
    Response response = await super.filter(option);

    if (response.statusCode == 200) {
      return FilteredAuditData.fromJson(response.body);
    }
    throw Exception();
  }

  Future<List<AuditQuestionSnapshot>> getAuditQuestionSnapshotList(
      String auditId) async {
    return const [
      AuditQuestionSnapshot(
        section: 'Electric inspection',
        totalQuestionCount: 8,
        includedQuestionCount: 8,
        maxScore: 43,
        includedScore: 2,
      ),
      AuditQuestionSnapshot(
        section: 'Signage Inspection',
        totalQuestionCount: 8,
        includedQuestionCount: 8,
        maxScore: 2,
        includedScore: 32,
      ),
      AuditQuestionSnapshot(
        section: 'Housekeeping interviews',
        totalQuestionCount: 5,
        includedQuestionCount: 2,
        maxScore: 31,
        includedScore: 2,
      ),
      AuditQuestionSnapshot(
        section: 'Cafe supplies inspection',
        totalQuestionCount: 8,
        includedQuestionCount: 8,
        maxScore: 12,
        includedScore: 53,
      ),
    ];
  }

  Future<List<AuditSection>> getAuditSectionList(String auditId) async {
    return [
      AuditSection(
        id: const Uuid().v1(),
        name: 'Electric Inspection',
        status: AuditSectionStatus.done,
        questionCount: 8,
        maxScore: 32,
        auditQuestionList: [
          AuditQuestion(
            id: const Uuid().v1(),
            no: 1,
            score: 2,
            question: 'Is the WFH employees percentage less than 20%?',
            scale: 'Yes/No',
            answered: true,
          ),
          AuditQuestion(
            id: const Uuid().v1(),
            no: 1,
            score: 3,
            question: 'Is the current number of employees that are working?',
            scale: 'Satisfactory/ unsatisfactory',
            answered: true,
          ),
          AuditQuestion(
            id: const Uuid().v1(),
            no: 1,
            score: 4,
            question:
                'Are there signs posted visibly for employees to practice social distancing?',
            scale: 'Yes/No',
            answered: true,
          ),
          AuditQuestion(
            id: const Uuid().v1(),
            no: 1,
            score: 5,
            question: 'How satisfied are the employees who are WFH?',
            scale: 'Survey',
            answered: true,
          ),
        ],
      ),
      AuditSection(
        id: const Uuid().v1(),
        name: 'Signage inspection',
        status: AuditSectionStatus.partial,
        questionCount: 12,
        maxScore: 41,
        auditQuestionList: [
          AuditQuestion(
            id: const Uuid().v1(),
            no: 1,
            score: 2,
            question: 'How well do the employees know about social distancing?',
            scale: 'Yes/No',
            answered: false,
          ),
          AuditQuestion(
            id: const Uuid().v1(),
            no: 1,
            score: 3,
            question: 'Does the number of people wearing masks exceed 50%?',
            scale: 'Satisfactory/ unsatisfactory',
            answered: true,
          ),
          AuditQuestion(
            id: const Uuid().v1(),
            no: 1,
            score: 3,
            question: 'Does the number of people wearing masks exceed 50%?',
            scale: 'Yes/No',
            answered: true,
          ),
          AuditQuestion(
            id: const Uuid().v1(),
            no: 1,
            score: 2,
            question:
                'Are there safety measures in place for social places like conference rooms?',
            scale: 'Rating',
            answered: true,
          ),
        ],
      ),
      AuditSection(
        id: const Uuid().v1(),
        name: 'Housekeeping interviews',
        status: AuditSectionStatus.inProgress,
        questionCount: 4,
        maxScore: 20,
        auditQuestionList: [
          AuditQuestion(
            id: const Uuid().v1(),
            no: 1,
            score: 2,
            question:
                'Does the documentation cover a section about safe distancing?',
            scale: 'Yes/No',
            answered: true,
          ),
          AuditQuestion(
            id: const Uuid().v1(),
            no: 1,
            score: 3,
            question: 'How well do the employees know about social distancing?',
            scale: 'Satisfactory/ unsatisfactory',
            answered: false,
          ),
          AuditQuestion(
            id: const Uuid().v1(),
            no: 1,
            score: 4,
            question: 'Does the number of people wearing masks exceed 50%?',
            scale: 'Yes/No',
            answered: true,
          ),
          AuditQuestion(
            id: const Uuid().v1(),
            no: 1,
            score: 5,
            question:
                'Are there safety measures in place for social places like conference rooms?',
            scale: 'Rating',
            answered: false,
          ),
        ],
      ),
      AuditSection(
        id: const Uuid().v1(),
        name: 'Cafe supplies inspection',
        status: AuditSectionStatus.notStarted,
        questionCount: 11,
        maxScore: 28,
        auditQuestionList: [
          AuditQuestion(
            id: const Uuid().v1(),
            no: 1,
            score: 2,
            question: 'Are the soap dispensers cleaned every day?',
            scale: 'Yes/No',
            answered: false,
          ),
          AuditQuestion(
            id: const Uuid().v1(),
            no: 1,
            score: 3,
            question:
                'Are the store rooms stocked with at least 6 weeks of cleaning supplies?',
            scale: 'Satisfactory/ unsatisfactory',
            answered: false,
          ),
          AuditQuestion(
            id: const Uuid().v1(),
            no: 1,
            score: 4,
            question: 'Are there sufficient dispensars for hand sanitization?',
            scale: 'Yes/No',
            answered: false,
          ),
          AuditQuestion(
            id: const Uuid().v1(),
            no: 1,
            score: 5,
            question:
                'Is the cleaning crew following workstation cleaning instructions?',
            scale: 'Survey',
            answered: false,
          ),
          AuditQuestion(
            id: const Uuid().v1(),
            no: 1,
            score: 5,
            question:
                'Have safety instructions being distributed to all employees regularly?',
            scale: 'Survey',
            answered: false,
          ),
        ],
      )
    ];
  }
}
