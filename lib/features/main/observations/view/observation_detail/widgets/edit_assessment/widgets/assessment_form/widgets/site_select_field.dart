import '/common_libraries.dart';
import '../../../../form_item.dart';

class SiteSelectField extends StatelessWidget {
  const SiteSelectField({super.key});

  @override
  Widget build(BuildContext context) {
    return ObservationDetailFormItemView(
      label: 'Site',
      content: BlocBuilder<ObservationDetailBloc, ObservationDetailState>(
        builder: (context, observationDetailState) {
          Map<String, Site> items = {}..addEntries(observationDetailState
              .siteList
              .map((site) => MapEntry(site.name ?? '', site)));
          return BlocBuilder<EditAssessmentBloc, EditAssessmentState>(
            builder: (context, editAssessmentState) {
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CustomSingleSelect(
                    items: items,
                    hint: 'Select Site',
                    selectedValue: observationDetailState.siteList.isEmpty
                        ? null
                        : editAssessmentState.site?.name,
                    onChanged: (site) {
                      context.read<EditAssessmentBloc>()
                        .add(EditAssessmentSiteChanged(site: site.value));
                    },
                  ),
                  if (editAssessmentState.siteValidationMessage.isNotEmpty)
                    Padding(
                      padding: inset4,
                      child: Text(
                        editAssessmentState.siteValidationMessage,
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
