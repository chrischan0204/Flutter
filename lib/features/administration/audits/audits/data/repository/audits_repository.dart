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
  Future<EntityResponse> addAudit(AuditCreate audit) async {
    Response response = await super.post(url, body: audit.toJson());

    if (response.statusCode == 200) {
      return EntityResponse(
        isSuccess: true,
        message: Audit.fromJson(response.body).id ?? '',
        data: Audit.fromJson(response.body),
      );
    }
    if (response.statusCode == 500) {
      return EntityResponse.fromJson(response.body);
    }
    throw Exception();
  }

  // edit audit
  Future<EntityResponse> editAudit(AuditCreate audit) async {
    Response response = await super.put(
      url,
      body: audit.toJson(),
    );

    if (response.statusCode == 200) {
      return EntityResponse(
          isSuccess: true, message: Audit.fromJson(response.body).id ?? '');
    }
    if (response.statusCode == 500) {
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

  Future<AuditSummary> getAuditSummary(String auditId) async {
    Response response = await super.get('$url/$auditId/summary');

    if (response.statusCode == 200) {
      return AuditSummary.fromJson(response.body);
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

  Future<List<AuditSectionAndQuestion>> getAuditSectionAndQuestionList(
      String auditId) async {
    Response response = await super.get('$url/$auditId/sectionswithquestions');

    if (response.statusCode == 200) {
      return List.from(json.decode(response.body))
          .map((e) => AuditSectionAndQuestion.fromMap(e))
          .toList();
    }

    throw Exception();
  }

  Future<List<AuditQuestion>> getAuditQuestionList(
      String auditId, String sectionId) async {
    Response response = await super.get(
        '/api/audits/$auditId/sections/$sectionId/auditandtemplatequestions');

    if (response.statusCode == 200) {
      return [
        ...List.from(json.decode(response.body)['questions'])
            .map((e) => AuditQuestion.fromMap(e))
            .toList(),
        ...List.from(json.decode(response.body)['newQuestions'])
            .map((e) => AuditQuestion.fromMap(e).copyWith(isNew: true))
            .toList()
      ];
    }

    throw Exception();
  }

  Future<List<AuditSection>> getAuditSectionList(String auditId) async {
    Response response =
        await super.get('$url/$auditId/auditandtemplatesections');

    if (response.statusCode == 200) {
      return [
        ...List.from(json.decode(response.body)['auditSections'])
            .map((e) => AuditSection.fromMap(e))
            .toList(),
        ...List.from(json.decode(response.body)['templateSections'])
            .map((e) => AuditSection.fromMap(e).copyWith(isNew: true))
            .toList(),
      ];
    }

    throw Exception();
  }

  Future<EntityResponse> toggleIncludeQuestion(
      AuditQuestionAssociation auditQuestionAssociation) async {
    Response response = await super.post(
      '$url/${auditQuestionAssociation.auditId}/question/toggle',
      body: auditQuestionAssociation.toJson(),
    );
    if (response.statusCode == 200) {
      return EntityResponse(
        isSuccess: true,
        message: response.body,
      );
    }

    throw Exception();
  }

  Future<EntityResponse> toggleIncludeSection(
      AuditSectionAssociation auditSectionAssociation) async {
    Response response = await super.post(
      '$url/${auditSectionAssociation.auditId}/section/toggle',
      body: auditSectionAssociation.toJson(),
    );

    if (response.statusCode == 200) {
      return EntityResponse(
        isSuccess: true,
        message: response.body,
      );
    }

    throw Exception();
  }

  Future<EntityResponse> copySection(
    String auditId,
    String sectionId,
  ) async {
    Response response = await super.post('$url/$auditId/sections/$sectionId');

    if (response.statusCode == 200) {
      return EntityResponse(isSuccess: true, message: response.body);
    }

    throw Exception();
  }

  Future<EntityResponse> copyQuestion(
    String auditId,
    String questionId,
  ) async {
    Response response = await super.post('$url/$auditId/question/$questionId');

    if (response.statusCode == 200) {
      return EntityResponse(isSuccess: true, message: response.body);
    }

    throw Exception();
  }

  Future<AuditQuestionViewOption> getQuestionViewOptionList(
      String auditId) async {
    Response response = await super.get('$url/$auditId/questionviewoptions');

    if (response.statusCode == 200) {
      return AuditQuestionViewOption.fromJson(response.body);
    }

    throw Exception();
  }

  Future<List<AuditQuestion>> getAuditQuestionListForExecute(
      QuestionsForViewOptionParameter option) async {
    Response response = await super.post(
        '$url/${option.auditId}/questionsforviewoption',
        body: option.toJson());

    if (response.statusCode == 200) {
      return List.from(json.decode(response.body))
          .map((e) => AuditQuestion.fromMap(e))
          .toList();
    }

    throw Exception();
  }

  Future<AuditQuestion> getFollowupAuditQuestionForExecute(
    String auditId,
    String responseScaleId,
  ) async {
    Response response = await super
        .get('$url/$auditId/responsescales/$responseScaleId/followupquestion');

    if (response.statusCode == 200) {
      return AuditQuestion.fromJson(response.body);
    }

    throw Exception();
  }

  Future<EntityResponse> recordQuestionResponse(
      RecordQuestionResponseOnAudit record) async {
    Response response = await super.post(
      '$url/${record.auditId}/recordquestionresponse',
      body: record.toJson(),
    );

    if (response.statusCode == 200) {
      return EntityResponse(
        isSuccess: true,
        message: response.body,
      );
    }

    throw Exception();
  }
}
