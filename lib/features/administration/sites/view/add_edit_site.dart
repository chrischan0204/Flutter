import '../bloc/add_edit_site/add_edit_site_bloc.dart';
import '/common_libraries.dart';

class AddEditSiteView extends StatelessWidget {
  final String? siteId;
  const AddEditSiteView({
    super.key,
    this.siteId,
  });

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => AddEditSiteBloc(
        formDirtyBloc: context.read(),
        regionsRepository: RepositoryProvider.of(context),
        timeZonesRepository: RepositoryProvider.of(context),
        sitesRepository: RepositoryProvider.of(context),
      ),
      child: AddEditSiteWidget(siteId: siteId),
    );
  }
}

class AddEditSiteWidget extends StatefulWidget {
  final String? siteId;
  const AddEditSiteWidget({
    super.key,
    this.siteId,
  });

  @override
  State<AddEditSiteWidget> createState() => _AddEditSiteWidgetState();
}

class _AddEditSiteWidgetState extends State<AddEditSiteWidget> {
  late AddEditSiteBloc addEditSiteBloc;

  static String pageLabel = 'site';

  bool isFirstInit = true;

  @override
  void initState() {
    addEditSiteBloc = context.read()..add(AddEditSiteRegionListLoaded());
    if (widget.siteId != null) {
      addEditSiteBloc.add(AddEditSiteLoaded(id: widget.siteId!));
    }

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AddEditSiteBloc, AddEditSiteState>(
      listener: (context, state) {
        if (state.status == EntityStatus.success) {
          CustomNotification(
            context: context,
            notifyType: NotifyType.success,
            content: state.message,
          ).showNotification();
          GoRouter.of(context)
              .go('/sites/assign-templates?siteId=${state.createdSiteId}');
        }
        if (state.status == EntityStatus.failure) {}
      },
      builder: (context, state) {
        return AddEditEntityTemplate(
          label: pageLabel,
          id: widget.siteId,
          selectedEntity: state.loadedSite,
          addEntity: () => addEditSiteBloc.add(AddEditSiteAdded()),
          editEntity: () =>
              addEditSiteBloc.add(AddEditSiteEdited(id: widget.siteId ?? '')),
          crudStatus: state.status,
          formDirty: state.formDirty,
          child: Column(
            children: [
              _buildSiteNameField(),
              _buildRegionSelectField(),
              _buildTimeZoneSelectField(),
              _buildSiteTypeField(),
              _buildSiteCodeField(),
              _buildReferenceCodeField(),
            ],
          ),
        );
      },
    );
  }

  Widget _buildSiteNameField() {
    return BlocBuilder<AddEditSiteBloc, AddEditSiteState>(
      builder: (context, state) {
        return FormItem(
          label: 'Site Name (*)',
          content: CustomTextField(
            key: ValueKey(state.loadedSite?.id),
            initialValue: state.siteName,
            hintText: 'Name e.g. Chicago, Lake shore',
            onChanged: (siteName) {
              addEditSiteBloc.add(AddEditSiteNameChanged(name: siteName));
            },
          ),
          message: state.siteNameValidationMessage,
        );
      },
    );
  }

  Widget _buildRegionSelectField() {
    return BlocBuilder<AddEditSiteBloc, AddEditSiteState>(
      builder: (context, state) {
        Map<String, Region> items = {}..addEntries(state.regionList
            .map((region) => MapEntry(region.name ?? '', region)));
        return FormItem(
          label: 'Region (*)',
          content: CustomSingleSelect(
            items: items,
            hint: 'Select Region',
            selectedValue: state.regionList.isEmpty ? null : state.region?.name,
            onChanged: (region) {
              addEditSiteBloc
                  .add(AddEditSiteRegionChanged(region: region.value));
            },
          ),
          message: state.regionValidationMessage,
        );
      },
    );
  }

  Widget _buildReferenceCodeField() {
    return BlocBuilder<AddEditSiteBloc, AddEditSiteState>(
      builder: (context, state) {
        return FormItem(
          label: 'Reference Code',
          content: CustomTextField(
            key: ValueKey(state.loadedSite?.id),
            initialValue: state.referenceCode,
            hintText: '',
            onChanged: (referenceCode) {
              addEditSiteBloc.add(AddEditSiteReferenceCodeChanged(
                  referenceCode: referenceCode));
            },
          ),
          message: state.referenceCodeValidationMessage,
        );
      },
    );
  }

  Widget _buildSiteCodeField() {
    return BlocBuilder<AddEditSiteBloc, AddEditSiteState>(
      builder: (context, state) {
        return FormItem(
          label: 'Site Code (*)',
          content: CustomTextField(
            key: ValueKey(state.loadedSite?.id),
            initialValue: state.siteCode,
            hintText: 'Site code e.g. CHILKSHDR',
            onChanged: (siteCode) {
              addEditSiteBloc.add(AddEditSiteCodeChanged(siteCode: siteCode));
            },
          ),
          message: state.siteCodeValidationMessage,
        );
      },
    );
  }

  Widget _buildSiteTypeField() {
    return BlocBuilder<AddEditSiteBloc, AddEditSiteState>(
      builder: (context, state) {
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
            selectedValue: state.siteType,
            onChanged: (siteType) {
              addEditSiteBloc
                  .add(AddEditSiteTypeChanged(siteType: siteType.value));
            },
          ),
          message: state.siteTypeValidationMessage,
        );
      },
    );
  }

  Widget _buildTimeZoneSelectField() {
    return BlocBuilder<AddEditSiteBloc, AddEditSiteState>(
      builder: (context, state) {
        return FormItem(
          label: 'Time Zone (*)',
          content: CustomSingleSelect(
            items: <String, TimeZone>{}..addEntries(state.timeZoneList
                .map((timeZone) => MapEntry(timeZone.name ?? '', timeZone))),
            hint: 'Select Time Zone',
            selectedValue:
                state.timeZoneList.isEmpty ? null : state.timeZone?.name,
            onChanged: (timeZone) {
              addEditSiteBloc
                  .add(AddEditSiteTimeZoneChanged(timeZone: timeZone.value));
            },
          ),
          message: state.timeZoneValidationMessage,
        );
      },
    );
  }
}
