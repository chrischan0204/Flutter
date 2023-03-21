import 'dart:convert';

import '/data/model/model.dart';
import '/constants/uri.dart';
import 'package:http/http.dart';

class RegionsRepository {
  Future<List<Region>> getAssignedRegions() async {
    Response response = await get(ApiUri.getAssignedRegionsUri);
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

  Future<List<Region>> getUnassignedRegions() async {
    Response response = await get(ApiUri.getUnAssignedRegionsUri);
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
    Response response = await get(
      ApiUri.getTimeZonesForRegionUri.replace(
        path: '${ApiUri.getTimeZonesForRegionUri.path}/$regionId',
      ),
    );

    if (response.statusCode == 200) {
      final List<TimeZone> timeZones = List.from(
        jsonDecode(response.body),
      ).map((e) => TimeZone.fromMap(e)).toList();
      return timeZones;
    }
    return [];
    // return [
    //   'Eastern Standard Time | EST | UTC -5',
    //   'Central Standard Time | CST | UTC -6',
    //   'Mountain Standard Time | MST | UTC -7',
    //   'Pacific Standard Time | PST | UTC -8',
    //   'Alaska Standard Time | AST | UTC -9',
    //   'Hawaii Standard Time | HST | UTC -10',
    // ];
  }

  Future<Region> addRegion(Region region) async {
    return region;
  }

  Future<Region> editRegion(Region region) async {
    return region;
  }

  Future<Region> deleteRegion(Region region) async {
    return region;
  }
}
