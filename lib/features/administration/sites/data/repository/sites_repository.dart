import 'dart:convert';

import 'package:http/http.dart';
import 'package:safety_eta/constants/uri.dart';

import '/data/model/model.dart';

class SitesRepository {
  static String url = '/api/Sites';
  List<Site> sites = const [];
  // List<Site> sites = <Site>[
  //   Site(
  //     id: Uuid().v1(),
  //     name: 'Raleigh',
  //     siteCode: 'RALCODE',
  //     referenceCode: '01-98334',
  //     region: const Region(name: 'North America'),
  //     timeZone: const TimeZone(name: 'EST'),
  //     users: 17,
  //     observations: 67,
  //     auditTemplates: [
  //       AuditTemplate(
  //         name: 'Electric Wiring Audit',
  //         createdBy: 'Adam Drobot',
  //         lastRevisedOn: '3rd Oct 2022',
  //       ),
  //       AuditTemplate(
  //         name: 'Kitchen floor inspection',
  //         createdBy: 'Kenny Cross',
  //         lastRevisedOn: '23rd Apr 2020',
  //       ),
  //       AuditTemplate(
  //         name: 'Parking lot frozen',
  //         createdBy: 'Carl Adams',
  //         lastRevisedOn: '13th Feb 2022',
  //       ),
  //       AuditTemplate(
  //         name: 'AC unit leakage',
  //         createdBy: 'Peter Gittleman',
  //         lastRevisedOn: '19th Sep 2021',
  //       ),
  //       AuditTemplate(
  //         name: 'Cafeteria Gas Check',
  //         createdBy: 'Prince Bogotey',
  //         lastRevisedOn: '4th Oct 2021',
  //       ),
  //     ],
  //   ),
  //   Site(
  //       id: Uuid().v1(),
  //       name: 'Durham',
  //       siteCode: 'DURSITE',
  //       referenceCode: '01-43552',
  //       region: Region(name: 'North America'),
  //       timeZone: TimeZone(name: 'EST'),
  //       users: 17,
  //       observations: 67,
  //       auditTemplates: [
  //         AuditTemplate(
  //           name: 'Electric Wiring Audit',
  //           createdBy: 'Adam Drobot',
  //           lastRevisedOn: '3rd Oct 2022',
  //         ),
  //         AuditTemplate(
  //           name: 'Kitchen floor inspection',
  //           createdBy: 'Kenny Cross',
  //           lastRevisedOn: '23rd Apr 2020',
  //         ),
  //         AuditTemplate(
  //           name: 'Parking lot frozen',
  //           createdBy: 'Carl Adams',
  //           lastRevisedOn: '13th Feb 2022',
  //         ),
  //         AuditTemplate(
  //           name: 'AC unit leakage',
  //           createdBy: 'Peter Gittleman',
  //           lastRevisedOn: '19th Sep 2021',
  //         ),
  //         AuditTemplate(
  //           name: 'Cafeteria Gas Check',
  //           createdBy: 'Prince Bogotey',
  //           lastRevisedOn: '4th Oct 2021',
  //         ),
  //       ]),
  //   Site(
  //     id: Uuid().v1(),
  //     name: 'Bronx',
  //     siteCode: 'BRONXNYC',
  //     referenceCode: '12-07556',
  //     region: Region(name: 'North America'),
  //     timeZone: TimeZone(name: 'EST'),
  //     users: 17,
  //     observations: 67,
  //     auditTemplates: [
  //       AuditTemplate(
  //         name: 'Electric Wiring Audit',
  //         createdBy: 'Adam Drobot',
  //         lastRevisedOn: '3rd Oct 2022',
  //       ),
  //       AuditTemplate(
  //         name: 'Kitchen floor inspection',
  //         createdBy: 'Kenny Cross',
  //         lastRevisedOn: '23rd Apr 2020',
  //       ),
  //       AuditTemplate(
  //         name: 'Parking lot frozen',
  //         createdBy: 'Carl Adams',
  //         lastRevisedOn: '13th Feb 2022',
  //       ),
  //       AuditTemplate(
  //         name: 'AC unit leakage',
  //         createdBy: 'Peter Gittleman',
  //         lastRevisedOn: '19th Sep 2021',
  //       ),
  //       AuditTemplate(
  //         name: 'Cafeteria Gas Check',
  //         createdBy: 'Prince Bogotey',
  //         lastRevisedOn: '4th Oct 2021',
  //       ),
  //     ],
  //   ),
  //   Site(
  //     id: Uuid().v1(),
  //     name: 'Chicago',
  //     siteCode: 'CHILAKE',
  //     referenceCode: '92-73664',
  //     region: Region(name: 'North America'),
  //     timeZone: TimeZone(name: 'CST'),
  //     users: 17,
  //     observations: 67,
  //     auditTemplates: [
  //       AuditTemplate(
  //         name: 'Electric Wiring Audit',
  //         createdBy: 'Adam Drobot',
  //         lastRevisedOn: '3rd Oct 2022',
  //       ),
  //       AuditTemplate(
  //         name: 'Kitchen floor inspection',
  //         createdBy: 'Kenny Cross',
  //         lastRevisedOn: '23rd Apr 2020',
  //       ),
  //       AuditTemplate(
  //         name: 'Parking lot frozen',
  //         createdBy: 'Carl Adams',
  //         lastRevisedOn: '13th Feb 2022',
  //       ),
  //       AuditTemplate(
  //         name: 'AC unit leakage',
  //         createdBy: 'Peter Gittleman',
  //         lastRevisedOn: '19th Sep 2021',
  //       ),
  //       AuditTemplate(
  //         name: 'Cafeteria Gas Check',
  //         createdBy: 'Prince Bogotey',
  //         lastRevisedOn: '4th Oct 2021',
  //       ),
  //     ],
  //   ),
  // ];
  Future<List<Site>> getSites() async {
    Response response = await get(Uri.https(ApiUri.host, url));
    if (response.statusCode == 200) {
      sites = List.from(jsonDecode(response.body))
          .map((siteJson) => Site.fromMap(siteJson))
          .toList();
      return sites;
    }
    return <Site>[];
  }

  Future<Site> getSiteById(String siteId) async {
    Response response = await get(Uri.https(ApiUri.host, url));
    if (response.statusCode == 200) {
      sites = List.from(jsonDecode(response.body))
          .map((siteJson) => Site.fromMap(siteJson))
          .toList();
      return sites.firstWhere((site) => site.id == siteId);
    }
    throw Exception();
  }
}
