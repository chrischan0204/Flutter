import '/common_libraries.dart';

class AuditsRepository extends BaseRepository {
  AuditsRepository({
    required super.token,
    required super.authBloc,
  }) : super(url: '/api/audits');

  // get audits list
  Future<List<Audit>> getAudits() async {
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
}
