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
  String successType = 'none';

  @override
  void initState() {
    super.initState();
    regionsBloc = context.read<RegionsBloc>()
      ..add(AssignedRegionsRetrieved());
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<RegionsBloc, RegionsState>(
      listener: (context, state) => _displayNofitication(state),
      builder: (context, state) {
        return EntityListTemplate(
          description: 'The following regions are available to create sites in',
          entities: state.assignedRegions,
          title: 'RegionsListView',
          label: 'region',
          note:
              'This region has 2 sites associated & cannot be deleted. Only time zone can be changed or this region can be deactivated. After deactivation it wont be available for any further site allocations. The current sites will be maintained as is.',
          onRowClick: (region) {
            regionsBloc.add(RegionSelected(
              region: region as Region,
            ));
          },
          selectedEntity: state.selectedRegion,
          successType: successType,
        );
      },
    );
  }

  void _displayNofitication(RegionsState state) {
    bool success = false, failed = false;
    if (state.regionAddedStatus == EntityStatus.succuess) {
      setState(() {
        successType = 'add';
      });
      success = true;
    }
    if (state.regionEditedStatus == EntityStatus.succuess) {
      setState(() {
        successType = 'edit';
      });
      success = true;
    }
    if (state.regionDeletedStatus == EntityStatus.succuess) {
      setState(() {
        successType = 'delete';
      });
      success = true;
    }
    if (state.regionAddedStatus == EntityStatus.failure) {
      setState(() {
        successType = 'add-fail';
      });
      failed = true;
    }
    if (state.regionEditedStatus == EntityStatus.failure) {
      setState(() {
        successType = 'edit-fail';
      });
      failed = true;
    }
    if (state.regionDeletedStatus == EntityStatus.failure) {
      setState(() {
        successType = 'delete-fail';
      });
      failed = true;
    }
    if (success || failed) {
      regionsBloc.add(const RegionsStatusInited());
    }
  }
}
