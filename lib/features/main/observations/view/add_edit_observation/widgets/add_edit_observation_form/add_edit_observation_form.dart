import '/common_libraries.dart';
import 'widgets/widgets.dart';

class AddEditObservationFormView extends StatelessWidget {
  const AddEditObservationFormView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AddEditObservationBloc, AddEditObservationState>(
      builder: (context, state) {
        return Column(
          children: [
            FormItemVertical(
              leftChild: const ObservationNameTextField(),
              rightChild: const LocationTextField(),
              leftLabel: 'Observation (*)',
              rightLabel: 'Location (*)',
              leftValidationMessage: state.observationNameValidationMessage,
              rightValidationMessage: state.locationValidationMessage,
            ),
            FormItemVertical(
              leftChild: const SiteSelectField(),
              rightChild: const ResponseTextField(),
              leftLabel: 'Site (*)',
              rightLabel: 'Response',
              leftValidationMessage: state.siteValidationMessage,
            ),
            FormItemVertical(
              leftChild: const PriorityLevelSelectField(),
              rightChild: const ObservationTypeSelectField(),
              leftLabel: 'Priority Level (*)',
              rightLabel: 'Observation Type (*)',
              leftValidationMessage: state.priorityLevelValidationMessage,
              rightValidationMessage: state.observationNameValidationMessage,
            ),
            FormItemVertical(
              leftChild: const ObservationImagePicker(),
              leftLabel: 'Images',
              secondaryRightChild: Text(
                '(You can upload multiple images)',
                style: textNormal12.copyWith(color: darkGrey),
              ),
            ),
          ],
        );
      },
    );
  }
}
