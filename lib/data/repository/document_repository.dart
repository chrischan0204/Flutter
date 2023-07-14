// ignore: avoid_web_libraries_in_flutter
import 'dart:html';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/foundation.dart';

import '/common_libraries.dart';

class DocumentsRepository extends BaseRepository {
  DocumentsRepository({
    required super.token,
    required super.authBloc,
  }) : super(url: '/api/documents');

  /// get documents list by owner
  Future<List<Document>> getDocumentList({
    required String ownerId,
    required String ownerType,
  }) async {
    Response response =
        await super.get('$url/$ownerId', {'ownertype': ownerType});
    if (response.statusCode == 200) {
      return List.from(jsonDecode(response.body))
          .map((map) => Document.fromMap(map))
          .toList();
    }
    throw Exception();
  }

  Future<EntityResponse> uploadDocuments({
    required String ownerId,
    required String ownerType,
    required List<PlatformFile> documentList,
  }) async {
    try {
      await super.uploadMultipartFile(
        encodedPath: '$url/$ownerId',
        queryParams: {'ownertype': ownerType},
        fileList: documentList,
      );

      return EntityResponse(
        isSuccess: true,
        message: '',
      );
    } catch (e) {
      throw Exception();
    }
  }

  /// delete document by id
  Future<EntityResponse> deleteDocument(String documentId) async {
    Response response = await super.delete('$url/$documentId');

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
}
