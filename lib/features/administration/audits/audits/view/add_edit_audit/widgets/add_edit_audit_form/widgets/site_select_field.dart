import '/common_libraries.dart';

class SiteSelectField extends StatelessWidget {
  const SiteSelectField({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AddEditAuditBloc, AddEditAuditState>(
      builder: (context, state) {
        Map<String, Site> items = {}..addEntries(
            state.siteList.map((site) => MapEntry(site.name ?? '', site)));
        return FormItem(
          label: 'Site (*)',
          content: CustomSingleSelect(
            items: items,
            hint: 'Select Site',
            selectedValue: state.siteList.isEmpty ? null : state.site?.name,
            onChanged: (site) {
              context
                  .read<AddEditAuditBloc>()
                  .add(AddEditAuditSiteChanged(site: site.value));
            },
          ),
          message: state.siteValidationMessage,
        );
      },
    );
  }
}
