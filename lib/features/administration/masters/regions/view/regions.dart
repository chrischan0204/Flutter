import 'dart:math';

import 'package:flutter/material.dart';
import 'package:safety_eta/data/model/entity.dart';
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
    // regionsBloc.add(RegionsRetrieved());
    regionsBloc.add(RegionNamesRetrieved());
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<RegionsBloc, RegionsState>(
      listener: (context, state) {
        // print(state.selectedIsActive);
        if (state.regionAddedStatus == EntityStatus.succuess) {
          setState(() {
            notifyType = NotifyType.success;
            notifyContent = 'Region been successfully added....';
          });
        } else if (state.regionAddedStatus == EntityStatus.failure) {
          setState(() {
            notifyType = NotifyType.failture;
            notifyContent =
                'There was an error while adding. Our team has been notified. Please wait a few minutes and try again....';
          });
        }

        if (state.regionEditedStatus == EntityStatus.succuess) {
          setState(() {
            notifyType = NotifyType.good;
            notifyContent = 'Region has been successfully edited....';
          });
        } else if (state.regionEditedStatus == EntityStatus.failure) {
          setState(() {
            notifyType = NotifyType.failture;
            notifyContent =
                'There was an error while editing. Our team has been notified. Please wait a few minutes and try again....';
          });
        }
      },
      builder: (context, state) {
        return MastersTemplate(
          description: 'The following regions are available to create sites in',
          entities: state.regions,
          title: 'Regions',
          label: 'region',
          note:
              'This region has ${state.selectedAssociatedSitesCount} sites associated & cannot be deleted. Only time zone can be changed or this region can be deactivated. After deactivation it wont be available for any further site allocations. The current sites will be maintained as is.',
          deletable: state.selectedAssociatedSitesCount == 0,
          notifyType: notifyType,
          notifyContent: notifyContent,
          addEntity: () {
            if (state.selectedRegionName.isNotEmpty &&
                state.selectedTimezones.isNotEmpty) {
              regionsBloc.add(
                RegionAdded(
                  region: Region(
                    regionName: state.selectedRegionName,
                    timezonesAssociated: state.selectedTimezones,
                    isActive: true,
                    associatedSitesCount: Random().nextInt(2),
                  ),
                ),
              );
            }
          },
          editEntity: () {
            if (state.selectedRegionName.isNotEmpty &&
                state.selectedTimezones.isNotEmpty) {
              regionsBloc.add(
                RegionEdited(
                  region: Region(
                    regionName: state.selectedRegionName,
                    timezonesAssociated: state.selectedTimezones,
                    isActive: state.selectedIsActive,
                    associatedSitesCount: state.selectedAssociatedSitesCount,
                  ),
                ),
              );
            }
          },
          deleteEntity: () {
            regionsBloc.add(
              RegionDeleted(
                region: Region(
                  regionName: state.selectedRegionName,
                  timezonesAssociated: state.selectedTimezones,
                  isActive: state.selectedIsActive,
                  associatedSitesCount: state.selectedAssociatedSitesCount,
                ),
              ),
            );
          },
          isDeactive: !state.selectedIsActive,
          onActiveChanged: (value) {
            regionsBloc.add(
              SelectedIsActiveChanged(
                selectedIsActive: !value,
              ),
            );
          },
          onRowClick: (map) {
            regionsBloc.add(
              SelectedRegionNameChanged(
                selectedRegionName: map['regionName'] as String,
              ),
            );

            regionsBloc.add(
              SelectedTimezonesChanged(
                selectedTimezones: map['timezonesAssociated'] as List<String>,
              ),
            );

            regionsBloc.add(
              SelectedAssociatedSitesCountChanged(
                selectedAssociatedSitesCount:
                    map['associatedSitesCount'] as int,
              ),
            );
            regionsBloc.add(
              SelectedIsActiveChanged(
                selectedIsActive: map['isActive'] as bool,
              ),
            );
          },
          crudItems: [
            CrudItem(
              label: 'Region(*)',
              content: CustomSingleSelect(
                items: state.regionNames,
                selectedValue: state.selectedRegionName.isEmpty
                    ? null
                    : state.selectedRegionName,
                hint: 'Select Region',
                onChanged: (value) {
                  regionsBloc.add(
                    SelectedRegionNameChanged(
                      selectedRegionName: value,
                    ),
                  );
                },
                isDisabled: state.selectedAssociatedSitesCount != 0,
              ),
            ),
            CrudItem(
              label: 'Timezone(*)',
              content: CustomMultiSelect(
                items: state.timeZones,
                selectedItems: state.selectedTimezones,
                hint: 'Select Time Zone',
                onChanged: (value) {
                  // print(value);
                  regionsBloc.add(
                    SelectedTimezonesChanged(
                      selectedTimezones: value,
                    ),
                  );
                },
              ),
            ),
          ],
        );
      },
    );
  }
}
