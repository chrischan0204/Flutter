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
          description: 'The following regions are available to create sites in',
          entities: state.assignedRegions,
          title: 'Regions',
          label: 'region',
          emptyMessage:
              'There are no regions assigned. Please click on New Region to assign new region.',
          onRowClick: (region) {
            regionsBloc.add(RegionSelected(
              region: region as Region,
            ));
          },
          entityRetrievedStatus: state.assignedRegionsRetrievedStatus,
          selectedEntity: state.selectedRegion,
        );
      },
    );
  }
}
