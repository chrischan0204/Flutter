import 'package:flutter/material.dart';
import '../../masters_widgets/widgets.dart';
import '/data/model/model.dart';
import '/data/bloc/bloc.dart';

class RegionsListView extends StatefulWidget {
  const RegionsListView({super.key});

  @override
  State<RegionsListView> createState() => _RegionsState();
}

class _RegionsState extends State<RegionsListView> {
  late RegionsBloc regionsBloc;
  String notifyContent = '';

  @override
  void initState() {
    super.initState();
    regionsBloc = context.read<RegionsBloc>();
    regionsBloc.add(AssignedRegionsRetrieved());
    regionsBloc.add(UnassignedRegionsRetrieved());
  }

  // CrudItem _buildRegionSingleSelectDropDown(RegionsState state) {
  //   Map<String, String> regionNameAndIdMap = <String, String>{};

  //   for (var unassignedRegion in state.unassignedRegions) {
  //     regionNameAndIdMap.putIfAbsent(
  //         unassignedRegion.name!, () => unassignedRegion.id);
  //   }
  //   return CrudItem(
  //     label: 'Region(*)',
  //     content: CustomSingleSelect(
  //       items: regionNameAndIdMap,
  //       selectedValue:
  //           state.selectedRegion != null ? null : state.selectedRegion?.name,
  //       hint: 'Select Region',
  //       onChanged: (regionId) {
  //         regionsBloc.add(
  //           TimeZonesRetrievedForRegion(regionId: regionId),
  //         );
  //         // regionsBloc.add(
  //         //   SelectedRegionChanged(
  //         //     selectedRegion: state.selectedRegion!.copyWith(name: regionName),
  //         //   ),
  //         // );
  //       },
  //       // isDisabled: state.selectedAssociatedSitesCount != 0,
  //     ),
  //   );
  // }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<RegionsBloc, RegionsState>(
      listener: (context, state) {
        // if (state.regionAddedStatus == EntityStatus.succuess) {
        //   setState(() {
        //     notifyType = NotifyType.success;
        //     notifyContent = 'Region has been successfully added....';
        //   });
        // } else if (state.regionAddedStatus == EntityStatus.failure) {
        //   setState(() {
        //     notifyType = NotifyType.failture;
        //     notifyContent =
        //         'There was an error while adding. Our team has been notified. Please wait a few minutes and try again....';
        //   });
        // }

        // if (state.regionEditedStatus == EntityStatus.succuess) {
        //   setState(() {
        //     notifyType = NotifyType.good;
        //     notifyContent = 'Region has been successfully edited....';
        //   });
        // } else if (state.regionEditedStatus == EntityStatus.failure) {
        //   setState(() {
        //     notifyType = NotifyType.failture;
        //     notifyContent =
        //         'There was an error while editing. Our team has been notified. Please wait a few minutes and try again....';
        //   });
        // }
      },
      builder: (context, state) {
        return MastersListTemplate(
          description: 'The following regions are available to create sites in',
          entities: state.assignedRegions,
          title: 'RegionsListView',
          label: 'region',
          note:
              'This region has 2 sites associated & cannot be deleted. Only time zone can be changed or this region can be deactivated. After deactivation it wont be available for any further site allocations. The current sites will be maintained as is.',
          onRowClick: (region) {
            Region selectedRegion = region as Region;
            regionsBloc.add(
              SelectedRegionChanged(
                selectedRegion: selectedRegion,
              ),
            );
          },
        );
      },
    );
  }
}
