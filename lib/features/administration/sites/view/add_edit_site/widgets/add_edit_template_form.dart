import '/common_libraries.dart';

class AddEditTemplateFormView extends StatefulWidget {
  const AddEditTemplateFormView({super.key});

  @override
  State<AddEditTemplateFormView> createState() =>
      _AddEditTemplateFormViewState();
}

class _AddEditTemplateFormViewState extends State<AddEditTemplateFormView> {
  late AddEditSiteBloc addEditSiteBloc;

  @override
  void initState() {
    addEditSiteBloc = context.read();

    super.initState();
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

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        _buildSiteNameField(),
        _buildRegionSelectField(),
        _buildTimeZoneSelectField(),
        _buildSiteTypeField(),
        _buildSiteCodeField(),
        _buildReferenceCodeField(),
      ],
    );
  }
}
