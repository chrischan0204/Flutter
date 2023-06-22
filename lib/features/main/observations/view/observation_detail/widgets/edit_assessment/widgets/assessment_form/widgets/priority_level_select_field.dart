import '/common_libraries.dart';
import 'form_item.dart';

class PriorityLevelSelectField extends StatelessWidget {
  const PriorityLevelSelectField({super.key});

  @override
  Widget build(BuildContext context) {
    return AssessmentFormItemView(
      label: 'Priority Level',
      content: BlocBuilder<ObservationDetailBloc, ObservationDetailState>(
        builder: (context, observationDetailState) {
          Map<String, PriorityLevel> items = {}..addEntries(
              observationDetailState.priorityLevelList.map((priorityLevel) =>
                  MapEntry(priorityLevel.name ?? '', priorityLevel)));
          return BlocBuilder<EditAssessmentBloc, EditAssessmentState>(
            builder: (context, editAssessmentState) {
              return CustomSingleSelect(
                items: items,
                hint: 'Select Priority Level',
                selectedValue: observationDetailState.priorityLevelList.isEmpty
                    ? null
                    : editAssessmentState.priorityLevel?.name,
                onChanged: (priorityLevel) {
                  context.read<EditAssessmentBloc>().add(
                      EditAssessmentPriorityLevelChanged(
                          priorityLevel: priorityLevel.value));
                },
              );
            },
          );
        },
      ),
    );
  }
}
