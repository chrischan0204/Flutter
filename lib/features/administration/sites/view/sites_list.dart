import 'package:flutter/material.dart';

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
    sitesBloc = context.read<SitesBloc>();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SitesBloc, SitesState>(
      builder: (context, state) {
        return EntityListTemplate(
          title: pageTitle,
          label: pageLabel,
          viewName: pageLabel,
          entities: state.sites,
          showTableHeaderButtons: true,
          onRowClick: (selectedSite) =>
              sitesBloc.add(SiteSelectedById(siteId: selectedSite.id!)),
          emptyMessage: emptyMessage,
          entityRetrievedStatus: state.sitesRetrievedStatus,
          selectedEntity: state.selectedSite,
          onViewSettingApplied: () => _filterSites(),
          onIncludeDeletedChanged: (value) => _filterSites(null, value),
          onFilterSaved: _filterSites,
          onFilterApplied: _filterSites,
        );
      },
    );
  }

  void _filterSites([
    String? filterId,
    bool? includeDeleted,
  ]) {
    final FilterSettingBloc filterSettingBloc = context.read();
    sitesBloc.add(SiteListFiltered(
      filterId: filterId ??
          filterSettingBloc.state.selectedUserFilterSetting?.id ??
          '00000000-0000-0000-0000-000000000000',
      includeDeleted: includeDeleted ?? filterSettingBloc.state.includeDeleted,
    ));
  }
}
