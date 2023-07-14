import '/common_libraries.dart';

class AuditObservationDetailView extends StatelessWidget {
  const AuditObservationDetailView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ExecuteAuditObservationBloc,
        ExecuteAuditObservationState>(
      builder: (context, state) {
        if (state.auditObservationLoadStatus.isLoading) {
          return const Center(child: Loader());
        }

        if (state.auditObservation != null) {
          final observation = state.auditObservation!;
          return Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              CustomBottomBorderContainer(
                padding: inset10,
                child: Text(
                  observation.description ?? '',
                  style: textNormal14,
                ),
              ),
              CustomBottomBorderContainer(
                padding: inset10,
                child: RichText(
                  text: TextSpan(
                    text: 'Created by: ',
                    style: textSemiBold14,
                    children: [
                      TextSpan(
                        text: observation.createdByUserName,
                        style: textNormal14,
                      )
                    ],
                  ),
                ),
              ),
              CustomBottomBorderContainer(
                padding: inset10,
                child: RichText(
                  text: TextSpan(
                    text: 'Area: ',
                    style: textSemiBold14,
                    children: [
                      TextSpan(
                        text: observation.area,
                        style: textNormal14,
                      )
                    ],
                  ),
                ),
              ),
              CustomBottomBorderContainer(
                padding: inset10,
                child: RichText(
                  text: TextSpan(
                    text: 'Action: ',
                    style: textSemiBold14,
                    children: [
                      TextSpan(
                        text: observation.response,
                        style: textNormal14,
                      )
                    ],
                  ),
                ),
              ),
            ],
          );
        }

        return Container();
      },
    );
  }
}
