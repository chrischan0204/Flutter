import 'package:flutter/material.dart';

import '/global_widgets/global_widget.dart';
import '/data/model/model.dart';
import '/data/bloc/bloc.dart';

class RegionsListView extends StatefulWidget {
  const RegionsListView({super.key});

  @override
  State<RegionsListView> createState() => _RegionsState();
}

class _RegionsState extends State<RegionsListView> {
  late RegionsBloc regionsBloc;

  static String pageTitle = 'Regions';
  static String pageLabel = 'region';
  static String emptyMessage =
      'There are no regions assigned. Please click on New Region to assign new region.';
  static String pageDescription =
      'The following regions are available to create sites in';

  @override
  void initState() {
    super.initState();
    regionsBloc = context.read<RegionsBloc>()..add(AssignedRegionsRetrieved());
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<RegionsBloc, RegionsState>(
      builder: (context, state) {
        return EntityListTemplate(
          description: pageDescription,
          entities: state.assignedRegions,
          title: pageTitle,
          label: pageLabel,
          emptyMessage: emptyMessage,
          onRowClick: (region) => _selectRegion(region),
          entityListLoadStatusLoading:
              state.assignedRegionsRetrievedStatus.isLoading,
          selectedEntity: state.selectedRegion,
        );
      },
    );
  }

  void _selectRegion(Entity region) {
    regionsBloc.add(RegionSelected(
      region: region as Region,
    ));
  }
}
