import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:uuid/uuid.dart';

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
  TextEditingController siteNameController = TextEditingController(text: '');
  TextEditingController siteCodeController = TextEditingController(text: '');
  TextEditingController referenceCodeController =
      TextEditingController(text: '');

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

  static String pageLabel = 'site';

  bool isFirstInit = true;

  @override
  void initState() {
    sitesBloc = context.read<SitesBloc>()..add(SitesStatusInited());
    regionsBloc = context.read<RegionsBloc>()
      ..add(RegionsTimeZonesInited())
      ..add(AssignedRegionsRetrieved());
    sitesBloc.add(const SiteSelected(selectedSite: null));
    if (widget.siteId != null) {
      sitesBloc.add(SiteSelectedById(siteId: widget.siteId!));
    } else {
      sitesBloc.add(
        SiteSelected(selectedSite: Site(id: const Uuid().v1())),
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
          label: pageLabel,
          id: widget.siteId,
          selectedEntity: state.selectedSite,
          addEntity: () => _addSite(state),
          editEntity: () => _editSite(state),
          crudStatus: state.siteCrudStatus,
          isCrudDataFill: _checkFormDataFill(),
          child: Column(
            children: [
              _buildSiteNameField(state),
              _buildRegionSelectField(state),
              _buildTimeZoneSelectField(state),
              _buildSiteTypeField(state),
              _buildSiteCodeField(state),
              _buildReferenceCodeField(state),
            ],
          ),
        );
      },
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
        if (state.selectedSite!.regionId.isNotEmpty) {
          regionsBloc.add(TimeZonesRetrievedForRegion(
            regionId: state.selectedSite!.regionId,
          ));
        }
        isFirstInit = false;
        _checkFormDirty();
      }
      setState(() {});
    }
  }

  void _checkFormDirty() {
    context
        .read<FormDirtyBloc>()
        .add(FormDirtyChanged(isDirty: _checkFormDataFill()));
  }

  bool _checkFormDataFill() {
    return siteNameController.text.trim().isNotEmpty ||
        (region != null && region!.isNotEmpty) ||
        (timeZone != null && timeZone!.isNotEmpty) ||
        (siteType != null && siteType!.isNotEmpty) ||
        siteCodeController.text.trim().isNotEmpty ||
        referenceCodeController.text.trim().isNotEmpty;
  }

  void _checkCrudResult(SitesState state, BuildContext context) {
    if (state.siteCrudStatus == EntityStatus.success) {
      sitesBloc.add(SitesStatusInited());
      CustomNotification(
        context: context,
        notifyType: NotifyType.success,
        content: state.message,
      ).showNotification();
      GoRouter.of(context).go(
          '/sites/assign-templates?siteId=${state.selectedSite!.id}&siteName=${state.selectedSite!.name}');
    }
    if (state.siteCrudStatus == EntityStatus.failure) {
      sitesBloc.add(SitesStatusInited());
      setState(() {
        if (state.message.contains('code')) {
          siteCodeValidationMessage = state.message;
        } else {
          siteNameValidationMessage = state.message;
        }
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
          _checkFormDirty();
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

  BlocBuilder<RegionsBloc, RegionsState> _buildRegionSelectField(
      SitesState state) {
    return BlocBuilder<RegionsBloc, RegionsState>(
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
              _checkFormDirty();
              regionsBloc
                  .add(TimeZonesRetrievedForRegion(regionId: region.value));
              sitesBloc.add(
                SiteSelected(
                  selectedSite: state.selectedSite!.copyWith(
                    region: region.key,
                    regionId: region.value,
                    timeZone: '',
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
          _checkFormDirty();
          sitesBloc.add(
            SiteSelected(
              selectedSite: state.selectedSite!.copyWith(
                referenceCode: referenceCode,
              ),
            ),
          );
        },
      ),
    );
  }

  FormItem _buildSiteCodeField(SitesState state) {
    return FormItem(
      label: 'Site Code (*)',
      content: CustomTextField(
        controller: siteCodeController,
        hintText: 'Site code e.g. CHILKSHDR',
        onChanged: (siteCode) {
          _checkFormDirty();
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
        },
        hint: 'Select Type',
        selectedValue: siteType,
        onChanged: (siteType) {
          _checkFormDirty();
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

  BlocListener<SitesBloc, SitesState> _buildTimeZoneSelectField(
      SitesState state) {
    return BlocListener<SitesBloc, SitesState>(
      listener: (context, state) {
        if (state.selectedSite != null) {
          timeZone = state.selectedSite!.timeZone.isEmpty
              ? null
              : state.selectedSite!.timeZone;
        }
      },
      child: BlocBuilder<RegionsBloc, RegionsState>(
        builder: (context, regionsState) {
          return FormItem(
            label: 'Time Zone (*)',
            content: CustomSingleSelect(
              items: <String, String>{}..addEntries(regionsState.timeZones.map(
                  (timeZone) =>
                      MapEntry(timeZone.name ?? '', timeZone.id ?? ''))),
              hint: 'Select Time Zone',
              selectedValue: regionsState.timeZones.isEmpty ? null : timeZone,
              onChanged: (timeZone) {
                _checkFormDirty();
                setState(() {
                  timeZoneValidationMessage = '';
                });
                sitesBloc.add(
                  SiteSelected(
                    selectedSite: state.selectedSite!.copyWith(
                      timeZone: timeZone.key,
                      timeZoneId: timeZone.value,
                    ),
                  ),
                );
              },
            ),
            message: timeZoneValidationMessage,
          );
        },
      ),
    );
  }

  bool _checkAlphanumeric(String str) {
    final alphpanumeric = RegExp(r'^[0-9a-zA-Z ]+$');
    return alphpanumeric.hasMatch(str);
  }

  String _removeSpecialCharacters(String str) {
    return str.replaceAll(RegExp('[^A-Za-z0-9]'), '');
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
    } else {
      if (!(_checkAlphanumeric(siteName!))) {
        setState(() {
          siteNameValidationMessage = 'Site name should be only alphanumeric.';
        });

        validated = false;
      }
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
    } else {
      if (!(_checkAlphanumeric(siteCode!))) {
        setState(() {
          siteCodeValidationMessage = 'Site code should be only alphanumeric.';
        });

        validated = false;
      }
    }

    return validated;
  }

  void _addSite(SitesState state) {
    if (!_validate()) return;
    sitesBloc.add(SiteAdded(site: state.selectedSite!));
  }

  void _editSite(SitesState state) {
    if (!_validate()) return;
    sitesBloc.add(SiteEdited(site: state.selectedSite!));
  }
}
