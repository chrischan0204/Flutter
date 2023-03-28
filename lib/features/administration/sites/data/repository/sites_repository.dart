import '/data/model/model.dart';

class SitesRepository {
  static String url = '';

  Future<List> getSites() async {
    return const <Site>[
      Site(
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
  }
}
