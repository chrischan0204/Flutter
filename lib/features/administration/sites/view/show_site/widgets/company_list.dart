import '/common_libraries.dart';

class CompanyListView extends StatefulWidget {
  final String siteId;
  const CompanyListView({
    super.key,
    required this.siteId,
  });

  static const List<String> columns = [
    'Name',
    'Added By',
    'Created By',
  ];

  @override
  State<CompanyListView> createState() => _CompanyListViewState();
}

class _CompanyListViewState extends State<CompanyListView> {
  @override
  void initState() {
    context
        .read<ShowSiteBloc>()
        .add(ShowSiteAssignedAutitCompanyListLoaded(id: widget.siteId));
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
            'The following companies are associated with this site.',
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
              columns: CompanyListView.columns,
              rows: state.companyList
                  .map((company) => [
                        CustomDataCell(data: company.name),
                        CustomDataCell(data: company.createdByUserName),
                        CustomDataCell(data: company.createdOn),
                      ])
                  .toList(),
            );
          },
        ),
      ],
    );
  }
}
