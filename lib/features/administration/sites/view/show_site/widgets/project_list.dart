import '/common_libraries.dart';

class ProjectListView extends StatefulWidget {
  final String siteId;
  const ProjectListView({
    super.key,
    required this.siteId,
  });

  static const List<String> columns = [
    'Name',
    'Region',
    'Reference Code',
    'Reference Name',
  ];

  @override
  State<ProjectListView> createState() => _ProjectListViewState();
}

class _ProjectListViewState extends State<ProjectListView> {
  @override
  void initState() {
    context
        .read<ShowSiteBloc>()
        .add(ShowSiteAssignedAutitProjectListLoaded(id: widget.siteId));
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
            'The following projects are associated with this site.',
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
            if (state.listLoadStatus.isLoading) {
              return const Center(
                child: Loader(),
              );
            }
            return TableView(
              height: MediaQuery.of(context).size.height - 260,
              columns: ProjectListView.columns,
              rows: state.projectList
                  .map((project) => [
                        CustomDataCell(data: project.name),
                        CustomDataCell(data: project.regionName),
                        CustomDataCell(data: project.referenceNumber),
                        CustomDataCell(data: project.referneceName),
                      ])
                  .toList(),
            );
          },
        ),
      ],
    );
  }
}
