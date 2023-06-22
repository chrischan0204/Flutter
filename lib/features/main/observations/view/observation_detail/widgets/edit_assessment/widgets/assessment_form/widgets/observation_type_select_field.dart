import '/common_libraries.dart';
import 'form_item.dart';

class ObservationTypeSelectField extends StatelessWidget {
  const ObservationTypeSelectField({super.key});

  @override
  Widget build(BuildContext context) {
    return AssessmentFormItemView(
      label: 'Observation Type',
      content: BlocBuilder<ObservationDetailBloc, ObservationDetailState>(
        builder: (context, observationDetailState) {
          Map<String, ObservationType> items = {}..addEntries(
              observationDetailState.observationTypeList.map(
                  (observationType) =>
                      MapEntry(observationType.name ?? '', observationType)));
          return BlocBuilder<EditAssessmentBloc, EditAssessmentState>(
            builder: (context, editAssessmentState) {
              return CustomSingleSelect(
                items: items,
                hint: 'Select Observation Type',
                selectedValue:
                    observationDetailState.observationTypeList.isEmpty
                        ? null
                        : editAssessmentState.observationType?.name,
                onChanged: (observationType) {
                  context.read<EditAssessmentBloc>().add(
                      EditAssessmentObservationTypeChanged(
                          observationType: observationType.value));
                },
              );
            },
          );
        },
      ),
    );
  }
}
