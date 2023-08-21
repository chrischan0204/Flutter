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
          message: 'Audit deleted successfully.',
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

  Future<AuditQuestion> getAuditQuestionByIdForExecute(
      String questionId) async {
    Response response = await super.get('$url/questions/$questionId');

    if (response.statusCode == 200) {
      return AuditQuestion.fromJson(response.body);
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

  Future<AuditComment> addCommentForAudit(
      AuditCommentCreate auditCommentCreate) async {
    Response response = await super.post(
        '$url/sectionitems/${auditCommentCreate.auditId}/comments',
        body: auditCommentCreate.toJson());

    if (response.statusCode == 200) {
      return AuditComment.fromJson(response.body);
    }

    throw Exception();
  }

  Future<AuditComment> editCommentForAudit(
      AuditCommentUpdate auditCommentUpdate) async {
    Response response = await super.put(
        '$url/sectionitems/${auditCommentUpdate.auditId}/comments',
        body: auditCommentUpdate.toJson());

    if (response.statusCode == 200) {
      return AuditComment.fromJson(response.body);
    }

    throw Exception();
  }

  Future<List<AuditComment>> getAuditCommentList(String questionId) async {
    Response response =
        await super.get('$url/sectionitems/$questionId/comments');

    if (response.statusCode == 200) {
      return List.from(json.decode(response.body))
          .map((e) => AuditComment.fromMap(e))
          .toList();
    }

    throw Exception();
  }

  Future<AuditComment> getAuditCommentById({
    required String questionId,
    required String commentId,
  }) async {
    Response response =
        await super.get('$url/sectionitems/$questionId/comments/$commentId');

    if (response.statusCode == 200) {
      return AuditComment.fromJson(response.body);
    }

    throw Exception();
  }

  Future<EntityResponse> deleteAuditComment({
    required String auditId,
    required String commentId,
  }) async {
    Response response =
        await super.delete('$url/sectionitems/$auditId/comments/$commentId');

    if (response.statusCode == 200) {
      return EntityResponse(
        isSuccess: true,
        message: 'message',
      );
    }

    throw Exception();
  }

  Future<List<Document>> getAuditDocumentList({
    required String auditId,
    required String questionId,
  }) async {
    Response response =
        await super.get('$url/$auditId/questions/$questionId/documents');

    if (response.statusCode == 200) {
      return List.from(json.decode(response.body))
          .map((e) => Document.fromMap(e))
          .toList();
    }

    throw Exception();
  }

  Future<List<AuditActionItem>> getAuditActionItemList(
      String questionId) async {
    Response response =
        await super.get('$url/sectionitems/$questionId/actionitems');

    if (response.statusCode == 200) {
      return List.from(json.decode(response.body))
          .map((e) => AuditActionItem.fromMap(e))
          .toList();
    }

    throw Exception();
  }

  Future<ActionItemDetail> getAuditActionItemById({
    required String questionId,
    required String actionItemId,
  }) async {
    Response response = await super
        .get('$url/sectionitems/$questionId/actionitems/$actionItemId');

    if (response.statusCode == 200) {
      return ActionItemDetail.fromJson(response.body);
    }

    throw Exception();
  }

  Future<EntityResponse> addActionItemForAudit(
      ActionItemCreate actionItemCreate) async {
    Response response = await super.post(
        '$url/sectionitems/${actionItemCreate.auditSectionItemId}/actionitems',
        body: actionItemCreate.toJson());

    if (response.statusCode == 200) {
      return EntityResponse(
        isSuccess: true,
        message: '',
        data: Entity(id: json.decode(response.body)['id']),
      );
    }

    throw Exception();
  }

  Future<EntityResponse> editActionItemForAudit({
    required ActionItemCreate actionItemCreate,
    required String actionItemId,
  }) async {
    Response response = await super.put(
        '$url/sectionitems/$actionItemId/actionitems',
        body: actionItemCreate.toJson());

    if (response.statusCode == 200) {
      return EntityResponse(
        isSuccess: true,
        message: '',
      );
    }

    throw Exception();
  }

  Future<EntityResponse> deleteAuditActionItem({
    required String questionId,
    required String actionItemId,
  }) async {
    Response response = await super
        .delete('$url/sectionitems/$questionId/actionitems/$actionItemId');

    if (response.statusCode == 200) {
      return EntityResponse(
        isSuccess: true,
        message: 'message',
      );
    }

    throw Exception();
  }

  Future<List<ObservationDetail>> getAuditObservationList(
      String questionId) async {
    Response response =
        await super.get('$url/sectionitems/$questionId/observations');

    if (response.statusCode == 200) {
      return List.from(json.decode(response.body))
          .map((e) => ObservationDetail.fromMap(e))
          .toList();
    }

    throw Exception();
  }

  Future<ObservationDetail> getAuditObservationById({
    required String questionId,
    required String observationId,
  }) async {
    Response response = await super.get(
        '$url/sectionitems/$questionId/observations/observationid',
        {'observationId': observationId});

    if (response.statusCode == 200) {
      return ObservationDetail.fromJson(response.body);
    }

    throw Exception();
  }

  Future<EntityResponse> addObservationForAudit(
      ObservationCreate observationCreate) async {
    Response response = await super.post(
        '$url/sectionitems/${observationCreate.auditSectionItemId}/observations',
        body: observationCreate.toJson());

    if (response.statusCode == 200) {
      return EntityResponse(
        isSuccess: true,
        message: '',
        data: Entity.fromMap(
          json.decode(response.body),
        ),
      );
    }

    throw Exception();
  }

  Future<EntityResponse> editObservationForAudit({
    required ObservationCreate observationUpdate,
    required String observationId,
  }) async {
    Response response = await super.put(
        '$url/sectionitems/$observationId/observations',
        body: observationUpdate.toJson());

    if (response.statusCode == 200) {
      return EntityResponse(
        isSuccess: true,
        message: '',
      );
    }

    throw Exception();
  }

  Future<EntityResponse> deleteAuditObservation({
    required String questionId,
    required String observationId,
  }) async {
    Response response = await super
        .delete('$url/sectionitems/$questionId/observations/$observationId');

    if (response.statusCode == 200) {
      return EntityResponse(
        isSuccess: true,
        message: 'message',
      );
    }

    throw Exception();
  }

  Future<List<Document>> getDocumentList(String questionId) async {
    Response response =
        await super.get('$url/sectionitems/$questionId/documents');

    if (response.statusCode == 200) {
      return List.from(json.decode(response.body))
          .map((e) => Document.fromMap(e))
          .toList();
    }

    throw Exception();
  }

  Future<List<Document>> getDocumentListForDetail(String auditId) async {
    Response response = await super.get('$url/$auditId/documents');

    if (response.statusCode == 200) {
      return List.from(json.decode(response.body))
          .map((e) => Document.fromMap(e))
          .toList();
    }

    throw Exception();
  }

  Future<List<ObservationDetail>> getAuditObservationListForDetail(
      String auditId) async {
    Response response = await super.get('$url/$auditId/observations');

    if (response.statusCode == 200) {
      return List.from(json.decode(response.body))
          .map((e) => ObservationDetail.fromMap(e))
          .toList();
    }

    throw Exception();
  }

  Future<List<AuditActionItem>> getAuditActionItemListForDetail(
      String auditId) async {
    Response response = await super.get('$url/$auditId/actionitems');

    if (response.statusCode == 200) {
      return List.from(json.decode(response.body))
          .map((e) => AuditActionItem.fromMap(e))
          .toList();
    }

    throw Exception();
  }

  Future<List<ResponseScale>> getResponseScaleList() async {
    Response response = await super.get('$url/responsescales');

    if (response.statusCode == 200) {
      return List.from(json.decode(response.body))
          .map((e) => ResponseScale.fromMap(e))
          .toList();
    }

    throw Exception();
  }

  Future<List<TemplateResponseScaleItem>> getResponseScaleItemList(
      String responseScaleId) async {
    Response response =
        await super.get('$url/responsescaleitems/$responseScaleId');

    if (response.statusCode == 200) {
      return TemplateResponseScaleItem.fromListJson(response.body);
    }

    throw Exception();
  }

  Future<void> setAuditStatus(String auditId, String status) async {
    Response response = await super
        .post('$url/$auditId/status', queryParams: {'status': status});

    if (response.statusCode == 200) {
      return;
    }

    throw Exception();
  }

  Future<void> saveAuditReviewers(
      AuditReviewersCreate auditReviewersCreate) async {
    Response response = await super.post(
        '$url/${auditReviewersCreate.auditId}/reviewers',
        body: auditReviewersCreate.toJson());

    if (response.statusCode == 200) {
      return;
    }

    throw Exception();
  }

  Future<List<AuditReview>> getAuditReviewList(String auditId) async {
    Response response = await super.get('$url/$auditId/reviews');

    if (response.statusCode == 200) {
      return List.from(jsonDecode(response.body))
          .map((e) => AuditReview.fromMap(e))
          .toList();
    }

    throw Exception();
  }

  Future<AuditReview> updateAuditReview(
      AuditReviewUpdate auditReviewUpdate) async {
    Response response = await super.put(
      '$url/${auditReviewUpdate.id}/reviews',
      body: auditReviewUpdate.toJson(),
    );

    if (response.statusCode == 200) {
      return AuditReview.fromJson(response.body);
    }

    throw Exception();
  }
}
