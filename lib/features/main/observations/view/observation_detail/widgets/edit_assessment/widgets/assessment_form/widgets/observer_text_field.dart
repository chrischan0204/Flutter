import '/common_libraries.dart';
import '../../../../form_item.dart';

class ObserverTextField extends StatelessWidget {
  const ObserverTextField({super.key});

  @override
  Widget build(BuildContext context) {
    return ObservationDetailFormItemView(
      label: 'Observer',
      content: BlocBuilder<EditAssessmentBloc, EditAssessmentState>(
        builder: (context, state) {
          return CustomTextField(
            // key: ValueKey(state.loadedAudit?.id),
            initialValue: state.observer,
            onChanged: (observer) {
              context
                  .read<EditAssessmentBloc>()
                  .add(EditAssessmentObserverChanged(observer: observer));
            },
          );
        },
      ),
    );
  }
}
