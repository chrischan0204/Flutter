import 'package:intl/intl.dart';

import '/common_libraries.dart';

class AuditObservationListView extends StatelessWidget {
  const AuditObservationListView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ExecuteAuditObservationBloc,
        ExecuteAuditObservationState>(
      builder: (context, state) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (state.auditObservationListLoadStatus.isLoading)
              const Center(child: Loader()),
            if (state.auditObservationListLoadStatus.isSuccess)
              for (final observation in state.auditObservationList)
                AuditObservationListItemView(observation: observation)
          ],
        );
      },
    );
  }
}

class AuditObservationListItemView extends StatelessWidget {
  final ObservationDetail observation;
  const AuditObservationListItemView({
    super.key,
    required this.observation,
  });

  @override
  Widget build(BuildContext context) {
    return CustomBottomBorderContainer(
      padding: inset8,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            observation.description ?? '',
            style: textNormal14,
          ),
          spacery10,
          Row(
            children: [
              Expanded(
                  child: Text(
                observation.reportedBy ?? '',
                style: textNormal12,
              )),
              Expanded(
                  child: Text(
                observation.reportedAt != null
                    ? DateFormat('MM/d/yyyy').format(observation.reportedAt!)
                    : '',
                style: textNormal12,
              )),
              Expanded(
                  child: Text(
                observation.imageCount < 2
                    ? '${observation.imageCount} Image'
                    : '${observation.imageCount} Images',
                style: textNormal12.copyWith(color: primaryColor),
              )),
              SizedBox(
                width: 50,
                child: IconButton(
                  onPressed: () {
                    context.read<ExecuteAuditObservationBloc>()
                      ..add(const ExecuteAuditObservationViewChanged(
                          view: CrudView.update))
                      ..add(ExecuteAuditObservationLoaded(
                          observationId: observation.id));
                  },
                  icon: Icon(
                    PhosphorIcons.regular.wrench,
                    size: 14,
                    color: Colors.orange,
                  ),
                ),
              ),
              SizedBox(
                width: 50,
                child: IconButton(
                  onPressed: () {
                    context.read<ExecuteAuditObservationBloc>()
                      ..add(const ExecuteAuditObservationViewChanged(
                          view: CrudView.detail))
                      ..add(ExecuteAuditObservationLoaded(
                          observationId: observation.id));
                  },
                  icon: Icon(
                    PhosphorIcons.regular.appWindow,
                    size: 14,
                    color: Colors.purple,
                  ),
                ),
              ),
              SizedBox(
                width: 50,
                child: IconButton(
                  onPressed: () {
                    CustomAlert(
                      context: context,
                      width: MediaQuery.of(context).size.width / 4,
                      title: 'Notification',
                      description: 'Deleting observation. Are you sure?',
                      btnOkText: 'OK',
                      btnOkOnPress: () => context
                          .read<ExecuteAuditObservationBloc>()
                          .add(ExecuteAuditObservationDeleted(
                              observationId: observation.id)),
                      btnCancelOnPress: () {},
                      dialogType: DialogType.info,
                    ).show();
                  },
                  icon: Icon(
                    PhosphorIcons.regular.trash,
                    size: 14,
                    color: Colors.red,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
