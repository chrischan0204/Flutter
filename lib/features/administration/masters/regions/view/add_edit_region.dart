import 'package:flutter/material.dart';

import '/utils/custom_notification.dart';
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

  String regionNameValidationMessage = '';
  String timeZonesValidationMessage = '';

  static String pageLabel = 'region';

  @override
  void initState() {
    regionsBloc = context.read<RegionsBloc>();
    regionsBloc.add(UnassignedRegionsRetrieved());
    regionsBloc.add(const RegionsStatusInited());
    if (widget.regionId != null) {
      regionsBloc.add(TimeZonesRetrievedForRegion(regionId: widget.regionId!));
      regionsBloc.add(RegionSelectedById(regionId: widget.regionId!));
    } else {
      regionsBloc.add(const RegionSelected(region: Region()));
    }

    super.initState();
  }

  void _addRegion(RegionsState state) {
    if (!_validate()) return;
    regionsBloc.add(RegionAdded(region: state.selectedRegion!));
  }

  void _editRegion(RegionsState state) {
    if (!_validate()) return;
    regionsBloc.add(RegionEdited(region: state.selectedRegion!));
  }

  bool _validate() {
    bool validated = true;
    if (regionName == null ||
        (regionName != null &&
            (regionName!.isEmpty || regionName!.trim().isEmpty))) {
      setState(() {
        regionNameValidationMessage = 'Region name is required.';
      });

      validated = false;
    }
    if (selectedTimeZones.isEmpty) {
      setState(() {
        timeZonesValidationMessage = 'Time zone is required.';
      });

      validated = false;
    }
    return validated;
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<RegionsBloc, RegionsState>(
      listener: (context, state) {
        _changeFormData(state);
        _checkCrudStatus(state, context);
      },
      builder: (context, state) {
        Map<String, dynamic> regionItems = <String, dynamic>{}..addEntries(
            state.unassignedRegions.map(
              (unassignedRegion) =>
                  MapEntry(unassignedRegion.name!, unassignedRegion),
            ),
          );
        if (widget.regionId != null &&
            firstSelectedRegion != null &&
            firstSelectedRegion!.name!.isNotEmpty) {
          regionItems.addEntries(
              [MapEntry(firstSelectedRegion!.name!, firstSelectedRegion!)]);
        }

        return AddEditEntityTemplate(
          label: pageLabel,
          id: widget.regionId,
          selectedEntity: state.selectedRegion,
          addEntity: () => _addRegion(state),
          editEntity: () => _editRegion(state),
          crudStatus: state.regionCrudStatus,
          child: Column(
            children: [
              _buildRegionSelectField(regionItems, state),
              _buildTimeZoneSelectField(state),
              _buildDeactiveSwitch(state),
            ],
          ),
        );
      },
    );
  }

  Widget _buildDeactiveSwitch(RegionsState state) {
    return widget.regionId != null
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
          )
        : Container();
  }

  FormItem _buildTimeZoneSelectField(RegionsState state) {
    return FormItem(
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
          setState(() {
            timeZonesValidationMessage = '';
          });
          regionsBloc.add(
            RegionSelected(
              region: state.selectedRegion!.copyWith(
                timeZones: timeZones
                    .map((timeZone) =>
                        (timeZone as TimeZone).copyWith(assigned: true))
                    .toList(),
              ),
            ),
          );
        },
      ),
      message: timeZonesValidationMessage,
    );
  }

  FormItem _buildRegionSelectField(
      Map<String, dynamic> regionItems, RegionsState state) {
    return FormItem(
      label: 'Region (*)',
      content: CustomSingleSelect(
        items: regionItems,
        hint: 'Select Region',
        disabled: state.selectedRegion != null
            ? !state.selectedRegion!.deletable
            : true,
        selectedValue: regionName,
        onChanged: (region) {
          setState(() {
            regionNameValidationMessage = '';
          });
          regionsBloc.add(
            RegionSelected(
              region: (region.value as Region).copyWith(
                active: widget.regionId != null ? null : true,
              ),
            ),
          );
        },
      ),
      message: regionNameValidationMessage,
    );
  }

  void _checkCrudStatus(RegionsState state, BuildContext context) {
    if (state.regionCrudStatus == EntityStatus.success) {
      regionsBloc.add(const RegionsStatusInited());
      CustomNotification(
        context: context,
        notifyType: NotifyType.success,
        content: state.message,
      ).showNotification();
    }
    if (state.regionCrudStatus == EntityStatus.failure) {
      regionsBloc.add(const RegionsStatusInited());
      setState(() {
        regionName = state.message;
      });
    }
  }

  // change the form data whenever the state changes
  void _changeFormData(RegionsState state) {
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
  }
}
