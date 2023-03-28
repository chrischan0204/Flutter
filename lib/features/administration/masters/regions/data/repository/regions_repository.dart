import 'dart:convert';

import '/data/model/model.dart';
import '/constants/uri.dart';
import 'package:http/http.dart';

class RegionsRepository {
  static String url = '/api/Regions';
  Future<List<Region>> getAssignedRegions() async {
    Response response =
        await get(Uri.https(ApiUri.host, '$url/GetAssignedRegions'));
    if (response.statusCode == 200) {
      final regions = List<Region>.from(
        jsonDecode(response.body).map(
          (e) => Region.fromMap(e),
        ),
      );

      return regions;
    }
    return [];
  }

  Future<Region> getRegionById(String regionId) async {
    Response response = await get(Uri.https(ApiUri.host, '$url/$regionId'));

    if (response.statusCode == 200) {
      return Region.fromJson(response.body);
    }
    throw Exception('');
  }

  Future<List<Region>> getUnassignedRegions() async {
    Response response =
        await get(Uri.https(ApiUri.host, '$url/GetUnassignedRegions'));
    if (response.statusCode == 200) {
      final List<Region> unassignedRegions = List.from(
        jsonDecode(response.body).map(
          (e) => Region.fromMap(e),
        ),
      );
      return unassignedRegions;
    }
    return [];
  }

  Future<List<TimeZone>> getTimeZonesForRegion(String regionId) async {
    Response response = await get(Uri.https(
      ApiUri.host,
      '/api/Timezones/GetTimeZonesForRegion/$regionId',
    ));

    if (response.statusCode == 200) {
      final List<TimeZone> timeZones = List.from(
        jsonDecode(response.body),
      ).map((e) => TimeZone.fromMap(e)).toList();
      return timeZones;
    }
    return [];
  }

  Future<EntityResponse> addRegion(Region region) async {
    Response response = await post(Uri.https(ApiUri.host, url),
        headers: {
          'content-type': 'application/json',
          'accept': 'application/json',
        },
        body: region.toJson());

    if (response.statusCode == 200) {
      return EntityResponse.fromJson(response.body);
    }
    throw Exception();
  }

  Future<EntityResponse> editRegion(Region region) async {
    Response response = await put(Uri.https(ApiUri.host, url),
        headers: {
          'content-type': 'application/json',
          'accept': 'application/json',
        },
        body: region.toJson());

    if (response.statusCode == 200) {
      return EntityResponse.fromJson(response.body);
    }
    throw Exception();
  }

  Future<EntityResponse> deleteRegion(String regionId) async {
    Response response = await delete(
      Uri.https(ApiUri.host, '$url/$regionId'),
    );

    if (response.statusCode == 200) {
      return EntityResponse.fromJson(response.body);
    }
    throw Exception();
  }
}
