import '/common_libraries.dart';

class ResponseScalesRepository extends BaseRepository {
  ResponseScalesRepository({
    required super.token,
    required super.authBloc,
  }) : super(url: '/api/audits');

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

  Future<EntityResponse> addResponseScale(String responseScaleName) async {
    Response response =
        await super.post(url, body: {'name': responseScaleName});

    if (response.statusCode == 200) {
      return EntityResponse(isSuccess: true, message: '');
    }

    throw Exception();
  }

  Future<EntityResponse> editResponseScale(
      String responseScaleId, String responseScaleName) async {
    Response response = await super
        .put('$url/$responseScaleId', body: {'name': responseScaleName});

    if (response.statusCode == 200) {
      return EntityResponse(isSuccess: true, message: '');
    }

    throw Exception();
  }

  Future<EntityResponse> deleteResponseScale(String responseScaleId) async {
    Response response = await super.delete('$url/$responseScaleId');

    if (response.statusCode == 200) {
      return EntityResponse(isSuccess: true, message: '');
    }

    throw Exception();
  }
}
