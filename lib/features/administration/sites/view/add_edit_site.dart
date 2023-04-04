import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '/global_widgets/global_widget.dart';
import '/utils/custom_notification.dart';
import '/data/model/model.dart';
import '/data/bloc/bloc.dart';

class AddEditSiteView extends StatefulWidget {
  final String? siteId;
  const AddEditSiteView({
    super.key,
    this.siteId,
  });

  @override
  State<AddEditSiteView> createState() => _AddEditSiteViewState();
}

class _AddEditSiteViewState extends State<AddEditSiteView> {
  late SitesBloc sitesBloc;
  late RegionsBloc regionsBloc;
  List<Region> assignedRegions = [];
  TextEditingController siteNameController = TextEditingController(
    text: '',
  );
  TextEditingController siteCodeController = TextEditingController(
    text: '',
  );
  TextEditingController referenceCodeController = TextEditingController(
    text: '',
  );
  TextEditingController filterController = TextEditingController(
    text: '',
  );
  String? siteName;
  String? siteCode;
  String? region;
  String? timeZone;
  String? referenceCode;
  String? siteType;

  String siteNameValidationMessage = '';
  String regionValidationMessage = '';
  String timeZoneValidationMessage = '';
  String siteTypeValidationMessage = '';
  String siteCodeValidationMessage = '';

  bool isFirstInit = true;

  @override
  void initState() {
    sitesBloc = context.read<SitesBloc>();
    regionsBloc = context.read<RegionsBloc>()..add(AssignedRegionsRetrieved());
    if (widget.siteId != null) {
      sitesBloc.add(
        SiteSelectedById(siteId: widget.siteId!),
      );
    } else {
      sitesBloc.add(
        const SiteSelected(
          selectedSite: Site(
            referenceCode: '',
            region: '',
            siteType: '',
            siteCode: '',
            timeZone: '',
          ),
        ),
      );
    }

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SitesBloc, SitesState>(
      listener: (context, state) {
        _changeFormData(state);
        _checkCrudResult(state, context);
      },
      builder: (context, state) {
        return AddEditEntityTemplate(
          label: 'site',
          id: widget.siteId,
          selectedEntity: state.selectedSite,
          addEntity: () => _addSite(),
          editEntity: () => _editSite(),
          addButtonName: 'Attach Templates',
          crudStatus: state.siteCrudStatus,
          child: Column(
            children: [
              _buildSiteNameField(state),
              widget.siteId == null
                  ? _buildRegionField(state)
                  : _buildRegionFieldForTimeZonesForEdit(state),
              _buildTimeZoneSelector(state),
              _buildSiteTypeField(state),
              _buildSiteCodeField(state),
              _buildReferenceCodeField(state),
            ],
          ),
        );
      },
    );
  }

  BlocListener<SitesBloc, SitesState> _buildRegionFieldForTimeZonesForEdit(
      SitesState state) {
    return BlocListener<SitesBloc, SitesState>(
      listener: (context, sitesState) {
        if (assignedRegions.isNotEmpty) {
          String regionId = assignedRegions
              .firstWhere((assignedRegion) =>
                  assignedRegion.name == sitesState.selectedSite!.region)
              .id!;
          regionsBloc.add(TimeZonesRetrievedForRegion(
            regionId: regionId,
          ));
        }
      },
      listenWhen: (previous, current) => previous.selectedSite == null
          ? true
          : (current.selectedSite != null &&
              previous.selectedSite!.region != current.selectedSite!.region),
      child: _buildRegionField(state),
    );
  }

  void _changeFormData(SitesState state) {
    if (state.selectedSite != null) {
      siteName = (state.selectedSite!.name ?? '').isEmpty
          ? null
          : state.selectedSite!.name ?? '';
      siteCode = state.selectedSite!.siteCode;
      siteType = state.selectedSite!.siteType.isEmpty
          ? null
          : state.selectedSite!.siteType;
      referenceCode = state.selectedSite!.referenceCode;
      timeZone = state.selectedSite!.timeZone.isEmpty
          ? null
          : state.selectedSite!.timeZone;
      region = state.selectedSite!.region.isEmpty
          ? null
          : state.selectedSite!.region;

      if (isFirstInit) {
        siteNameController.text =
            widget.siteId == null ? '' : state.selectedSite!.name ?? '';
        siteCodeController.text =
            widget.siteId == null ? '' : state.selectedSite!.siteCode;
        referenceCodeController.text =
            widget.siteId == null ? '' : state.selectedSite!.referenceCode;
        isFirstInit = false;
      }
      setState(() {});
    }
  }

  void _checkCrudResult(SitesState state, BuildContext context) {
    if (state.siteCrudStatus == EntityStatus.success) {
      sitesBloc.add(SitesStatusInited());
      CustomNotification(
        context: context,
        notifyType: NotifyType.success,
        content: state.message,
      ).showNotification();
    }
    if (state.siteCrudStatus == EntityStatus.failure) {
      sitesBloc.add(SitesStatusInited());
      setState(() {
        siteName = state.message;
      });
    }
  }

  FormItem _buildSiteNameField(SitesState state) {
    return FormItem(
      label: 'Site Name (*)',
      content: CustomTextField(
        controller: siteNameController,
        hintText: 'Name e.g. Chicago, Lake shore',
        onChanged: (siteName) {
          setState(() {
            siteNameValidationMessage = '';
          });
          sitesBloc.add(
            SiteSelected(
              selectedSite: state.selectedSite!.copyWith(
                name: siteName,
              ),
            ),
          );
        },
      ),
      message: siteNameValidationMessage,
    );
  }

  BlocConsumer<RegionsBloc, RegionsState> _buildRegionField(SitesState state) {
    return BlocConsumer<RegionsBloc, RegionsState>(
      listener: (context, state) {
        assignedRegions = state.assignedRegions;
      },
      listenWhen: (previous, current) => current.assignedRegions.isNotEmpty,
      builder: (context, regionsState) {
        Map<String, String> items = <String, String>{}..addEntries(
            regionsState.assignedRegions.map((assignedRegion) =>
                MapEntry(assignedRegion.name ?? '', assignedRegion.id!)));
        return FormItem(
          label: 'Region (*)',
          content: CustomSingleSelect(
            items: items,
            hint: 'Select Region',
            selectedValue: regionsState.assignedRegions.isEmpty ? null : region,
            onChanged: (region) {
              setState(() {
                regionValidationMessage = '';
              });
              regionsBloc
                  .add(TimeZonesRetrievedForRegion(regionId: region.value));
              sitesBloc.add(
                SiteSelected(
                  selectedSite: state.selectedSite!.copyWith(
                    region: region.value,
                  ),
                ),
              );
            },
          ),
          message: regionValidationMessage,
        );
      },
    );
  }

  FormItem _buildReferenceCodeField(SitesState state) {
    return FormItem(
      label: 'Reference Code',
      content: CustomTextField(
        controller: referenceCodeController,
        hintText: '',
        onChanged: (referenceCode) {
          sitesBloc.add(
            SiteSelected(
              selectedSite: state.selectedSite!.copyWith(
                referenceCode: referenceCode,
              ),
            ),
          );
        },
      ),
      message: '',
    );
  }

  FormItem _buildSiteCodeField(SitesState state) {
    return FormItem(
      label: 'Site Code (*)',
      content: CustomTextField(
        controller: siteCodeController,
        hintText: 'Site code e.g. CHILKSHDR',
        onChanged: (siteCode) {
          setState(() {
            siteCodeValidationMessage = '';
          });
          sitesBloc.add(
            SiteSelected(
              selectedSite: state.selectedSite!.copyWith(
                siteCode: siteCode,
              ),
            ),
          );
        },
      ),
      message: siteCodeValidationMessage,
    );
  }

  FormItem _buildSiteTypeField(SitesState state) {
    return FormItem(
      label: 'Site Type (*)',
      content: CustomSingleSelect(
        items: const <String, String>{
          'Office': 'Office',
          'Manufacturing': 'Manufacturing',
          'Chemicals Plant': 'Chemicals Plant',
          'Other': 'Other',
          'site type': 'site type',
        },
        hint: 'Select Type',
        selectedValue: siteType,
        onChanged: (siteType) {
          setState(() {
            siteTypeValidationMessage = '';
          });
          sitesBloc.add(
            SiteSelected(
              selectedSite: state.selectedSite!.copyWith(
                siteType: siteType.key,
              ),
            ),
          );
        },
      ),
      message: siteTypeValidationMessage,
    );
  }

  BlocBuilder<RegionsBloc, RegionsState> _buildTimeZoneSelector(
      SitesState state) {
    return BlocBuilder<RegionsBloc, RegionsState>(
      builder: (context, regionsState) {
        return FormItem(
          label: 'Time Zone (*)',
          content: CustomSingleSelect(
            items: <String, dynamic>{}..addEntries(regionsState.timeZones
                .map((timeZone) => MapEntry(timeZone.name ?? '', timeZone))),
            hint: 'Select Time Zone',
            selectedValue: regionsState.timeZones.isEmpty ? null : timeZone,
            onChanged: (timeZone) {
              setState(() {
                timeZoneValidationMessage = '';
              });
              sitesBloc.add(
                SiteSelected(
                  selectedSite: state.selectedSite!.copyWith(
                    timeZone: timeZone.key,
                  ),
                ),
              );
            },
          ),
          message: timeZoneValidationMessage,
        );
      },
    );
  }

  bool _validate() {
    bool validated = true;
    if (siteName == null ||
        (siteName != null && (siteName!.isEmpty || siteName!.trim().isEmpty))) {
      setState(() {
        siteNameValidationMessage =
            'Site name is required and cannot be blank.';
      });

      validated = false;
    }

    if (region == null ||
        (region != null && (region!.isEmpty || region!.trim().isEmpty))) {
      setState(() {
        regionValidationMessage = 'Region is required.';
      });

      validated = false;
    }

    if (timeZone == null ||
        (timeZone != null && (timeZone!.isEmpty || timeZone!.trim().isEmpty))) {
      setState(() {
        timeZoneValidationMessage = 'Time zone is required.';
      });

      validated = false;
    }

    if (siteType == null ||
        (siteType != null && (siteType!.isEmpty || siteType!.trim().isEmpty))) {
      setState(() {
        siteTypeValidationMessage = 'Site type is required.';
      });

      validated = false;
    }

    if (siteCode == null ||
        (siteCode != null && (siteCode!.isEmpty || siteCode!.trim().isEmpty))) {
      setState(() {
        siteCodeValidationMessage = 'Site code is required.';
      });

      validated = false;
    }

    return validated;
  }

  void _addSite() {
    if (!_validate()) return;
    GoRouter.of(context).go('/sites/abc/assign-templates');
  }

  void _editSite() {
    if (!_validate()) return;
    GoRouter.of(context).go('/sites/abc/assign-templates');
  }
}
