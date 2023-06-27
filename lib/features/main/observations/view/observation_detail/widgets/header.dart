import '/common_libraries.dart';

class ObservationDetailHeaderView extends StatelessWidget {
  const ObservationDetailHeaderView({super.key});

  @override
  Widget build(BuildContext context) {
    return CustomBottomBorderContainer(
      padding: inset20,
      child: BlocBuilder<ObservationDetailBloc, ObservationDetailState>(
        builder: (context, state) {
          if (state.observation == null) {
            return Container();
          }

          return Text(
            state.observation!.name ?? '',
            style: textNormal20,
          );
        },
      ),
    );
  }
}
