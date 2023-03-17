import '../model/region.dart';

class RegionsRepository {
  Future<List<Region>> getRegions() async {
    return <Region>[
      // Region(
      //   regionName: 'North America',
      //   timezonesAssociated: ['EST. CST and PST'],
      //   isActive: true,
      // ),
      // Region(
      //   regionName: 'Asia',
      //   timezonesAssociated: [
      //     'Japan Standard Time',
      //     'India Standard Time & Arabian Standard'
      //   ],
      //   isActive: true,
      // ),
      // Region(
      //   regionName: 'Eastern Europe',
      //   timezonesAssociated: [
      //     'Moscow Standard',
      //     'Central Europen Standard',
      //     'GMT'
      //   ],
      //   isActive: false,
      // ),
      // Region(
      //   regionName: 'Africa',
      //   timezonesAssociated: [
      //     'Japan Standard Time',
      //     'India Standard Time & Arabian Standard'
      //   ],
      //   isActive: true,
      // ),
    ];
  }

  Future<List<String>> getRegionNames() async {
    return [
      'Africa',
      'Central America',
      'Middle East',
      'North America - South East',
      'Oceania',
      'South America',
      'The Carribean',
    ];
  }

  Future<List<String>> getTimezonesByRegion(String region) async {
    return [
      'Eastern Standard Time | EST | UTC -5',
      'Central Standard Time | CST | UTC -6',
      'Mountain Standard Time | MST | UTC -7',
      'Pacific Standard Time | PST | UTC -8',
      'Alaska Standard Time | AST | UTC -9',
      'Hawaii Standard Time | HST | UTC -10',
    ];
  }

  Future<Region> addRegion(Region region) async {
    return region;
  }

  Future<Region> editRegion(Region region) async {
    return region;
  }

  Future<void> deleteRegion(Region region) async {}
}
