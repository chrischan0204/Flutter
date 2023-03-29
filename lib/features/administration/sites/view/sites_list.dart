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
          title: 'Sites List',
          label: 'site',
          entities: state.sites,
          showTableHeaderButtons: true,
          onRowClick: (selectedSite) {
            sitesBloc.add(SiteSelected(selectedSite: selectedSite as Site));
          },
          selectedEntity: state.selectedSite,
        );
      },
    );
  }
}
