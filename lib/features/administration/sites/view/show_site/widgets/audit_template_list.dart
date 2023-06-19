import '/common_libraries.dart';

class AuditTemplateListView extends StatefulWidget {
  final String siteId;
  const AuditTemplateListView({
    super.key,
    required this.siteId,
  });

  static const List<String> columns = [
    'Template Name',
    'Created By',
    'Last Revised On'
  ];

  @override
  State<AuditTemplateListView> createState() => _AuditTemplateListViewState();
}

class _AuditTemplateListViewState extends State<AuditTemplateListView> {
  @override
  void initState() {
    context
        .read<ShowSiteBloc>()
        .add(ShowSiteAssignedAutitTemplateListLoaded(id: widget.siteId));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Padding(
          padding: insetx20,
          child: const Text(
            'The following templates are associated with this site. Edit site to associate/ remove templates from this site',
            style: TextStyle(
              fontSize: 14,
              fontFamily: 'OpenSans',
              fontWeight: FontWeight.w400,
            ),
          ),
        ),
        const CustomDivider(),
        BlocBuilder<ShowSiteBloc, ShowSiteState>(
          builder: (context, state) {
            return TableView(
              height: MediaQuery.of(context).size.height - 460,
              columns: AuditTemplateListView.columns,
              rows: state.auditTemplateList
                  .map((auditTemplate) => [
                        CustomDataCell(data: auditTemplate.name),
                        CustomDataCell(data: auditTemplate.createdByUserName),
                        CustomDataCell(data: auditTemplate.revisionDate),
                      ])
                  .toList(),
            );
          },
        ),
      ],
    );
  }
}
