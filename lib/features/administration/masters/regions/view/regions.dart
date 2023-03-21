import 'package:flutter/material.dart';
import '../../masters_widgets/masters_template/masters_template.dart';
import '../../masters_widgets/masters_template/widgets/crud_view/widgets/widgets.dart';
import '../../masters_widgets/masters_template/widgets/notify.dart';
import '/data/model/model.dart';
import '/data/bloc/bloc.dart';

class Regions extends StatefulWidget {
  const Regions({super.key});

  @override
  State<Regions> createState() => _RegionsState();
}

class _RegionsState extends State<Regions> {
  late RegionsBloc regionsBloc;
  NotifyType notifyType = NotifyType.initial;
  String notifyContent = '';

  @override
  void initState() {
    super.initState();
    regionsBloc = context.read<RegionsBloc>();
    regionsBloc.add(AssignedRegionsRetrieved());
    regionsBloc.add(UnassignedRegionsRetrieved());
  }

  CrudItem _buildRegionSingleSelectDropDown(RegionsState state) {
    Map<String, String> regionNameAndIdMap = <String, String>{};

    for (var unassignedRegion in state.unassignedRegions) {
      regionNameAndIdMap.putIfAbsent(
          unassignedRegion.name!, () => unassignedRegion.id);
    }
    return CrudItem(
      label: 'Region(*)',
      content: CustomSingleSelect(
        items: regionNameAndIdMap,
        selectedValue:
            state.selectedRegion != null ? null : state.selectedRegion?.name,
        hint: 'Select Region',
        onChanged: (regionId) {
          regionsBloc.add(
            TimeZonesRetrievedForRegion(regionId: regionId),
          );
          // regionsBloc.add(
          //   SelectedRegionChanged(
          //     selectedRegion: state.selectedRegion!.copyWith(name: regionName),
          //   ),
          // );
        },
        // isDisabled: state.selectedAssociatedSitesCount != 0,
      ),
    );
  }

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
        return MastersTemplate(
          description: 'The following regions are available to create sites in',
          entities: state.assignedRegions,
          title: 'Regions',
          label: 'region',
          note:
              'This region has 2 sites associated & cannot be deleted. Only time zone can be changed or this region can be deactivated. After deactivation it wont be available for any further site allocations. The current sites will be maintained as is.',
          deletable: true,
          notifyType: notifyType,
          notifyContent: notifyContent,
          addEntity: () {
            // if (state.selectedRegionName.isNotEmpty &&
            //     state.selectedTimezones.isNotEmpty) {
            //   regionsBloc.add(
            //     RegionAdded(
            //       region: Region(
            //         id: const Uuid().v1(),
            //         regionName: state.selectedRegionName,
            //         timezonesAssociated: state.selectedTimezones,
            //         isActive: true,
            //         associatedSitesCount: Random().nextInt(2),
            //       ),
            //     ),
            //   );
            // }
          },
          editEntity: () {
            // if (state.selectedRegionName.isNotEmpty &&
            //     state.selectedTimezones.isNotEmpty) {
            //   regionsBloc.add(
            //     RegionEdited(
            //       region: Region(
            //         id: state.selectedRegionId,
            //         regionName: state.selectedRegionName,
            //         timezonesAssociated: state.selectedTimezones,
            //         isActive: state.selectedIsActive,
            //         associatedSitesCount: state.selectedAssociatedSitesCount,
            //       ),
            //     ),
            //   );
            // }
          },
          deleteEntity: () {
            // regionsBloc.add(
            //   RegionDeleted(
            //     region: Region(
            //       id: state.selectedRegionId,
            //       regionName: state.selectedRegionName,
            //       timezonesAssociated: state.selectedTimezones,
            //       isActive: state.selectedIsActive,
            //       associatedSitesCount: state.selectedAssociatedSitesCount,
            //     ),
            //   ),
            // );
          },
          // isDeactive: !state.selectedRegion!.active,
          onActiveChanged: (value) {
            // regionsBloc.add(
            //   SelectedActiveChanged(
            //     selectedActive: !value,
            //   ),
            // );
          },
          onRowClick: (region) {
            Region selectedRegion = region as Region;
            regionsBloc.add(
              SelectedRegionChanged(
                selectedRegion: selectedRegion,
              ),
            );

            // regionsBloc.add(
            //   SelectedTimezonesChanged(
            //     selectedTimezones: selectedRegion.timeZones,
            //   ),
            // );

            // // regionsBloc.add(
            // //   SelectedAssociatedSitesCountChanged(
            // //     selectedAssociatedSitesCount:
            // //         map['associatedSitesCount'] as int,
            // //   ),
            // // );

            // regionsBloc.add(
            //   SelectedActiveChanged(
            //     selectedActive: selectedRegion.active,
            //   ),
            // );

            // regionsBloc.add(
            //   SelectedRegionIdChanged(
            //     selectedRegionId: selectedRegion.id,
            //   ),
            // );
          },
          crudItems: [
            _buildRegionSingleSelectDropDown(state),
            CrudItem(
              label: 'Timezone(*)',
              content: CustomMultiSelect(
                items: state.timeZones.map((e) => e.name!).toList(),
                // selectedItems: state.,
                hint: 'Select Time Zone',
                onChanged: (value) {
                  // regionsBloc.add(
                  //   SelectedTimezonesChanged(
                  //     selectedTimezones: value,
                  //   ),
                  // );
                },
              ),
            ),
          ],
        );
      },
    );
  }
}
