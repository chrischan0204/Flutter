import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '/global_widgets/global_widget.dart';
import '/data/model/model.dart';
import '/data/bloc/bloc.dart';

class AddEditRegionView extends StatefulWidget {
  final String? regionId;
  const AddEditRegionView({
    super.key,
    this.regionId,
  });

  @override
  State<AddEditRegionView> createState() => _AddEditRegionViewState();
}

class _AddEditRegionViewState extends State<AddEditRegionView> {
  late RegionsBloc regionsBloc;

  String? regionName;
  List<TimeZone> selectedTimeZones = [];
  bool regionDeactive = false;
  bool isFirst = true;
  Region? firstSelectedRegion;

  @override
  void initState() {
    regionsBloc = context.read<RegionsBloc>();
    regionsBloc.add(UnassignedRegionsRetrieved());
    regionsBloc.add(const RegionsStatusInited());
    if (widget.regionId != null) {
      regionsBloc.add(TimeZonesRetrievedForRegion(regionId: widget.regionId!));
      regionsBloc.add(
        RegionSelectedById(regionId: widget.regionId!),
      );
    } else {
      regionsBloc.add(
        const RegionSelected(
          region: Region(
            name: '',
            active: true,
          ),
        ),
      );
    }

    super.initState();
  }

  void _addRegion(RegionsState state) {
    regionsBloc.add(
      RegionAdded(
        region: state.selectedRegion!,
      ),
    );
  }

  void _editRegion(RegionsState state) {
    regionsBloc.add(
      RegionEdited(
        region: state.selectedRegion!,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<RegionsBloc, RegionsState>(
      listener: (context, state) {
        if (state.selectedRegion != null) {
          regionName = (state.selectedRegion!.name ?? '').isEmpty
              ? null
              : state.selectedRegion!.name ?? '';

          selectedTimeZones = state.selectedRegion!.associatedTimeZones;
          regionDeactive = !state.selectedRegion!.active;
          if (isFirst) {
            firstSelectedRegion = state.selectedRegion!;
            isFirst = false;
          }
        }
        if (state.regionAddedStatus == EntityStatus.succuess ||
            state.regionAddedStatus == EntityStatus.failure) {
          GoRouter.of(context).go('/regions');
        }

        if (state.regionEditedStatus == EntityStatus.succuess ||
            state.regionEditedStatus == EntityStatus.failure) {
          GoRouter.of(context).go('/regions');
        }
      },
      builder: (context, state) {
        Map<String, dynamic> regionItems = <String, dynamic>{}..addEntries(
            state.unassignedRegions.map(
              (unassignedRegion) =>
                  MapEntry(unassignedRegion.name!, unassignedRegion),
            ),
          );
        if (firstSelectedRegion != null &&
            firstSelectedRegion!.name!.isNotEmpty) {
          regionItems.addEntries(
              [MapEntry(firstSelectedRegion!.name!, firstSelectedRegion!)]);
        }

        return AddEditEntityTemplate(
          label: 'region',
          id: widget.regionId,
          selectedEntity: state.selectedRegion,
          addEntity: () => _addRegion(state),
          addedStatus: state.regionAddedStatus,
          editEntity: () => _editRegion(state),
          editedStatus: state.regionEditedStatus,
          child: Column(
            children: [
              FormItem(
                label: 'Region (*)',
                content: CustomSingleSelect(
                  items: regionItems,
                  hint: 'Select Region',
                  disabled: state.selectedRegion != null
                      ? !state.selectedRegion!.deletable
                      : true,
                  selectedValue: regionName,
                  onChanged: (region) {
                    regionsBloc.add(
                      RegionSelected(
                        region: (region.value as Region).copyWith(
                          active: widget.regionId != null ? null : true,
                        ),
                      ),
                    );
                  },
                ),
                message: '',
              ),
              FormItem(
                label: 'Time Zone (*)',
                content: CustomMultiSelect(
                  items: <String, TimeZone>{}..addEntries(
                      state.timeZones.map(
                        (timeZone) => MapEntry(timeZone.name!, timeZone),
                      ),
                    ),
                  hint: 'Select Time Zone',
                  selectedItems: selectedTimeZones,
                  onChanged: (timeZones) {
                    regionsBloc.add(
                      RegionSelected(
                        region: state.selectedRegion!.copyWith(
                          timeZones: timeZones
                              .map((timeZone) => (timeZone as TimeZone)
                                  .copyWith(assigned: true))
                              .toList(),
                        ),
                      ),
                    );
                  },
                ),
                message: '',
              ),
              widget.regionId != null
                  ? FormItem(
                      label: 'Deactivate?',
                      content: CustomSwitch(
                        label: 'This region is deactivated',
                        switchValue: regionDeactive,
                        onChanged: (active) {
                          regionsBloc.add(
                            RegionSelected(
                              region: state.selectedRegion!.copyWith(
                                active: !active,
                              ),
                            ),
                          );
                        },
                      ),
                      message: '',
                    )
                  : Container(),
            ],
          ),
        );
      },
    );
  }
}
