import '/common_libraries.dart';
import '../../../../form_item.dart';

class ObserverTextField extends StatelessWidget {
  const ObserverTextField({super.key});

  @override
  Widget build(BuildContext context) {
    return ObservationDetailFormItemView(
      label: 'Observer',
      content: BlocBuilder<ObservationDetailBloc, ObservationDetailState>(
        builder: (context, state) {
          return Text(
            state.observation?.reportedBy ?? '--',
            style: textNormal14,
          );
        },
      ),
    );
  }
}
