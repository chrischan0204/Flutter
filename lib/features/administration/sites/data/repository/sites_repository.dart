import 'package:safety_eta/features/administration/sites/data/model/audit_template.dart';

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
      region: const Region(name: 'North America'),
      timeZone: const TimeZone(name: 'EST'),
      users: 17,
      observations: 67,
      auditTemplates: [
        AuditTemplate(
          name: 'Electric Wiring Audit',
          createdBy: 'Adam Drobot',
          lastRevisedOn: '3rd Oct 2022',
        ),
        AuditTemplate(
          name: 'Kitchen floor inspection',
          createdBy: 'Kenny Cross',
          lastRevisedOn: '23rd Apr 2020',
        ),
        AuditTemplate(
          name: 'Parking lot frozen',
          createdBy: 'Carl Adams',
          lastRevisedOn: '13th Feb 2022',
        ),
        AuditTemplate(
          name: 'AC unit leakage',
          createdBy: 'Peter Gittleman',
          lastRevisedOn: '19th Sep 2021',
        ),
        AuditTemplate(
          name: 'Cafeteria Gas Check',
          createdBy: 'Prince Bogotey',
          lastRevisedOn: '4th Oct 2021',
        ),
      ],
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
        auditTemplates: [
          AuditTemplate(
            name: 'Electric Wiring Audit',
            createdBy: 'Adam Drobot',
            lastRevisedOn: '3rd Oct 2022',
          ),
          AuditTemplate(
            name: 'Kitchen floor inspection',
            createdBy: 'Kenny Cross',
            lastRevisedOn: '23rd Apr 2020',
          ),
          AuditTemplate(
            name: 'Parking lot frozen',
            createdBy: 'Carl Adams',
            lastRevisedOn: '13th Feb 2022',
          ),
          AuditTemplate(
            name: 'AC unit leakage',
            createdBy: 'Peter Gittleman',
            lastRevisedOn: '19th Sep 2021',
          ),
          AuditTemplate(
            name: 'Cafeteria Gas Check',
            createdBy: 'Prince Bogotey',
            lastRevisedOn: '4th Oct 2021',
          ),
        ]),
    Site(
      id: Uuid().v1(),
      name: 'Bronx',
      siteCode: 'BRONXNYC',
      referenceCode: '12-07556',
      region: Region(name: 'North America'),
      timeZone: TimeZone(name: 'EST'),
      users: 17,
      observations: 67,
      auditTemplates: [
        AuditTemplate(
          name: 'Electric Wiring Audit',
          createdBy: 'Adam Drobot',
          lastRevisedOn: '3rd Oct 2022',
        ),
        AuditTemplate(
          name: 'Kitchen floor inspection',
          createdBy: 'Kenny Cross',
          lastRevisedOn: '23rd Apr 2020',
        ),
        AuditTemplate(
          name: 'Parking lot frozen',
          createdBy: 'Carl Adams',
          lastRevisedOn: '13th Feb 2022',
        ),
        AuditTemplate(
          name: 'AC unit leakage',
          createdBy: 'Peter Gittleman',
          lastRevisedOn: '19th Sep 2021',
        ),
        AuditTemplate(
          name: 'Cafeteria Gas Check',
          createdBy: 'Prince Bogotey',
          lastRevisedOn: '4th Oct 2021',
        ),
      ],
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
      auditTemplates: [
        AuditTemplate(
          name: 'Electric Wiring Audit',
          createdBy: 'Adam Drobot',
          lastRevisedOn: '3rd Oct 2022',
        ),
        AuditTemplate(
          name: 'Kitchen floor inspection',
          createdBy: 'Kenny Cross',
          lastRevisedOn: '23rd Apr 2020',
        ),
        AuditTemplate(
          name: 'Parking lot frozen',
          createdBy: 'Carl Adams',
          lastRevisedOn: '13th Feb 2022',
        ),
        AuditTemplate(
          name: 'AC unit leakage',
          createdBy: 'Peter Gittleman',
          lastRevisedOn: '19th Sep 2021',
        ),
        AuditTemplate(
          name: 'Cafeteria Gas Check',
          createdBy: 'Prince Bogotey',
          lastRevisedOn: '4th Oct 2021',
        ),
      ],
    ),
  ];
  Future<List<Site>> getSites() async {
    return sites;
  }

  Future<Site> getSiteById(String siteId) async {
    return sites.firstWhere((site) => site.id == siteId);
  }
}
