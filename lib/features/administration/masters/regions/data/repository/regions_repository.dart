import 'dart:convert';

import '/data/repository/repository.dart';

import '/data/model/model.dart';
import '/constants/uri.dart';
import 'package:http/http.dart';

class RegionsRepository extends BaseRepository {
  RegionsRepository({
    required super.token,
    required super.authBloc,
  }) : super(url: '/api/Regions');

  Future<List<Region>> getAssignedRegions() async {
    Response response = await super.get('$url/GetAssignedRegions');
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
    Response response = await super.get('$url/$regionId');

    if (response.statusCode == 200) {
      return Region.fromJson(response.body);
    }
    throw Exception('');
  }

  Future<List<Region>> getUnassignedRegions() async {
    Response response = await super.get('$url/GetUnassignedRegions');
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
    Response response =
        await super.get('/api/Timezones/GetTimeZonesForRegion/$regionId');

    if (response.statusCode == 200) {
      final List<TimeZone> timeZones = List.from(
        jsonDecode(response.body),
      ).map((e) => TimeZone.fromMap(e)).toList();
      return timeZones;
    }
    return [];
  }

  Future<EntityResponse> addRegion(Region region) async {
    Response response = await super.post(
      url,
      body: region.toJson(),
    );

    if (response.statusCode == 200) {
      return EntityResponse.fromJson(response.body);
    }
    throw Exception();
  }

  Future<EntityResponse> editRegion(Region region) async {
    Response response = await super.put(
      url,
      body: region.toJson(),
    );

    if (response.statusCode == 200) {
      return EntityResponse.fromJson(response.body);
    }
    throw Exception();
  }

  Future<EntityResponse> deleteRegion(String regionId) async {
    Response response = await super.delete('$url/$regionId');

    if (response.statusCode == 200) {
      return EntityResponse(
        statusCode: response.statusCode,
        isSuccess: true,
        message: 'Region deleted successfully',
      );
    }
    throw Exception();
  }
}
