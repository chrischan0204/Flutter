import '/data/model/model.dart';
import 'package:uuid/uuid.dart';

class SitesRepository {
  static String url = '';
  List<Site> sites = <Site>[
    Site(
      id: Uuid().v1(),
      name: 'Raleigh',
      siteCode: 'RALCODE',
      referenceCode: '01-98334',
      region: Region(name: 'North America'),
      timeZone: TimeZone(name: 'EST'),
      users: 17,
      observations: 67,
      auditTemplates: 6,
    ),
    Site(
      id: Uuid().v1(),
      name: 'Durham',
      siteCode: 'DURSITE',
      referenceCode: '01-43552',
      region: Region(name: 'North America'),
      timeZone: TimeZone(name: 'EST'),
      users: 17,
      observations: 67,
      auditTemplates: 6,
    ),
    Site(
      id: Uuid().v1(),
      name: 'Bronx',
      siteCode: 'BRONXNYC',
      referenceCode: '12-07556',
      region: Region(name: 'North America'),
      timeZone: TimeZone(name: 'EST'),
      users: 17,
      observations: 67,
      auditTemplates: 6,
    ),
    Site(
      id: Uuid().v1(),
      name: 'Chicago',
      siteCode: 'CHILAKE',
      referenceCode: '92-73664',
      region: Region(name: 'North America'),
      timeZone: TimeZone(name: 'CST'),
      users: 17,
      observations: 67,
      auditTemplates: 6,
    ),
  ];
  Future<List<Site>> getSites() async {
    return sites;
  }

  Future<Site> getSiteById(String siteId) async {
    return sites.firstWhere((site) => site.id == siteId);
  }
}
