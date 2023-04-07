import 'package:flutter/material.dart';

import '/data/model/model.dart';
import '/global_widgets/global_widget.dart';
import '/data/bloc/bloc.dart';

class SitesListView extends StatefulWidget {
  const SitesListView({super.key});

  @override
  State<SitesListView> createState() => _SitesListViewState();
}

class _SitesListViewState extends State<SitesListView> {
  late SitesBloc sitesBloc;

  static String pageTitle = 'Sites';
  static String pageLabel = 'site';
  static String emptyMessage =
      'There are no sites. Please click New Site to add new site.';

  @override
  void initState() {
    sitesBloc = context.read<SitesBloc>()..add(SitesRetrieved());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SitesBloc, SitesState>(
      builder: (context, state) {
        return EntityListTemplate(
          title: pageTitle,
          label: pageLabel,
          entities: state.sites,
          showTableHeaderButtons: true,
          onRowClick: (selectedSite) =>
              sitesBloc.add(SiteSelected(selectedSite: selectedSite as Site)),
          emptyMessage: emptyMessage,
          entityRetrievedStatus: state.sitesRetrievedStatus,
          selectedEntity: state.selectedSite,
        );
      },
    );
  }
}
