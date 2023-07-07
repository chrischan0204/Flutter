import '/common_libraries.dart';
import '../../../../form_item.dart';

class ReportedViaTextField extends StatelessWidget {
  const ReportedViaTextField({super.key});

  @override
  Widget build(BuildContext context) {
    return ObservationDetailFormItemView(
      label: 'Reported via',
      content: BlocBuilder<ObservationDetailBloc, ObservationDetailState>(
        builder: (context, state) {
          return Text(
            state.observation?.reportedVia ?? '',
            style: textNormal14,
          );
        },
      ),
    );
  }
}
