import '../model/response_scale_item.dart';
import '/common_libraries.dart';

class ResponseScalesRepository extends BaseRepository {
  ResponseScalesRepository({
    required super.token,
    required super.authBloc,
  }) : super(url: '/api/responsescales');

  Future<List<ResponseScale>> getResponseScaleList() async {
    Response response = await super.get(url);

    if (response.statusCode == 200) {
      return List.from(json.decode(response.body))
          .map((e) => ResponseScale.fromMap(e))
          .toList();
    }

    throw Exception();
  }

  Future<List<ResponseScaleItem>> getResponseScaleItemList(
      String responseScaleId) async {
    Response response = await super.get('$url/$responseScaleId');

    if (response.statusCode == 200) {
      return List.from(json.decode(response.body))
          .map((e) => ResponseScaleItem.fromMap(e))
          .toList();
    }

    throw Exception();
  }

  Future<EntityResponse> updateResponseScaleItemList(String responseScaleId,
      List<ResponseScaleItem> responseScaleItemList) async {
    Response response = await super.put(
        '$url/$responseScaleId/responsescaleitems',
        body: jsonEncode(responseScaleItemList));

    if (response.statusCode == 200) {
      return EntityResponse(
        isSuccess: true,
        message: response.body,
      );
    }

    if (response.statusCode == 409) {
      return EntityResponse.fromJson(response.body);
    }
    throw Exception();
  }

  Future<EntityResponse> addResponseScale(String responseScaleName) async {
    Response response =
        await super.post(url, body: jsonEncode({'name': responseScaleName}));

    if (response.statusCode == 200) {
      return EntityResponse.fromJson(response.body);
    }

    if (response.statusCode == 409) {
      return EntityResponse.fromJson(response.body);
    }

    throw Exception();
  }

  Future<EntityResponse> editResponseScale(
      String responseScaleId, String responseScaleName) async {
    Response response = await super.put(url,
        body: jsonEncode({
          'id': responseScaleId,
          'name': responseScaleName,
        }));

    if (response.statusCode == 200) {
      return EntityResponse(
        isSuccess: true,
        message: response.body,
      );
    }

    if (response.statusCode == 409) {
      return EntityResponse.fromJson(response.body);
    }

    throw Exception();
  }

  Future<EntityResponse> deleteResponseScale(String responseScaleId) async {
    Response response = await super.delete('$url/$responseScaleId');

    if (response.statusCode == 200) {
      return EntityResponse(
        isSuccess: true,
        message: response.body,
      );
    }

    throw Exception();
  }

  Future<EntityResponse> validateResponseScaleDeletion(
      String responseScaleId) async {
    Response response =
        await super.post('$url/$responseScaleId/validateresponsescaledeletion');

    if (response.statusCode == 200) {
      return EntityResponse(
        isSuccess: true,
        message: response.body,
      );
    }

    if (response.statusCode == 409) {
      return EntityResponse.fromJson(response.body);
    }

    throw Exception();
  }

  Future<EntityResponse> deleteResponseScaleItem(
      String responseScaleItemId) async {
    Response response =
        await super.delete('$url/$responseScaleItemId/responsescaleitems');

    if (response.statusCode == 200) {
      return EntityResponse(
        isSuccess: true,
        message: response.body,
      );
    }

    if (response.statusCode == 409) {
      return EntityResponse.fromJson(response.body);
    }

    throw Exception();
  }
}
