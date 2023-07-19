import '/common_libraries.dart';
import '../../../../form_item.dart';

class SiteSelectField extends StatelessWidget {
  const SiteSelectField({super.key});

  @override
  Widget build(BuildContext context) {
    return ObservationDetailFormItemView(
      label: 'Site (*)',
      content: BlocBuilder<ObservationDetailBloc, ObservationDetailState>(
        builder: (context, observationDetailState) {
          return BlocBuilder<AddActionItemBloc, AddActionItemState>(
            builder: (context, state) {
              Map<String, Site> items = {}..addEntries(observationDetailState
                  .siteList
                  .map((site) => MapEntry(site.name ?? '', site)));
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CustomSingleSelect(
                    items: items,
                    hint: 'Select Site',
                    selectedValue: observationDetailState.siteList.isEmpty
                        ? null
                        : state.site?.name,
                    onChanged: (site) {
                      context
                          .read<AddActionItemBloc>()
                          .add(AddActionItemSiteChanged(site: site.value));
                    },
                  ),
                  if (state.siteValidationMessage.isNotEmpty)
                    Padding(
                      padding: inset4,
                      child: Text(
                        state.siteValidationMessage,
                        style: const TextStyle(fontSize: 12, color: Colors.red),
                      ),
                    )
                ],
              );
            },
          );
        },
      ),
    );
  }
}
