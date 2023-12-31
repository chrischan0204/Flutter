import 'package:strings/strings.dart';

import '/common_libraries.dart';
import 'widgets/widgets.dart';

class AuditObservationView extends StatefulWidget {
  const AuditObservationView({super.key});

  @override
  State<AuditObservationView> createState() => _AuditObservationViewState();
}

class _AuditObservationViewState extends State<AuditObservationView> {
  @override
  void initState() {
    context
        .read<ExecuteAuditObservationBloc>()
        .add(ExecuteAuditObservationListLoaded());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AuditDetailBloc, AuditDetailState>(
      listener: (context, auditDetailState) {
        context.read<ExecuteAuditObservationBloc>().add(
              ExecuteAuditObservationSiteChanged(
                site: Site(
                  id: auditDetailState.auditSummary?.siteId,
                  name: auditDetailState.auditSummary?.siteName,
                ),
                isInit: true,
              ),
            );
      },
      listenWhen: (previous, current) =>
          previous.auditLoadStatus != current.auditLoadStatus &&
          current.auditLoadStatus.isSuccess,
      builder: (context, auditDetailState) => Column(
        children: [
          BlocConsumer<ExecuteAuditObservationBloc,
              ExecuteAuditObservationState>(
            listener: (context, state) {
              CustomNotification(
                context: context,
                notifyType: NotifyType.success,
                content: state.message,
              ).showNotification();
            },
            listenWhen: (previous, current) =>
                previous.crudStatus != current.crudStatus &&
                current.message.isNotEmpty &&
                current.crudStatus.isSuccess,
            builder: (context, state) {
              return CustomBottomBorderContainer(
                padding: inset8,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Observation ${capitalize(state.view.name)}',
                      style: textNormal14,
                    ),
                    Row(
                      children: [
                        if (state.view.isCreate || state.view.isUpdate)
                          CustomBadge(
                            label: 'Cancel',
                            color: Colors.grey,
                            radius: 10,
                            onClick: () {
                              context.read<ExecuteAuditObservationBloc>()
                                ..add(ExecuteAuditObservationInited())
                                ..add(ExecuteAuditObservationListLoaded());
                            },
                          ),
                        spacerx20,
                        CustomBadge(
                          label: state.view.toString(),
                          color: primaryColor,
                          radius: 10,
                          onClick: () {
                            switch (state.view) {
                              case CrudView.list:
                                context.read<ExecuteAuditObservationBloc>().add(
                                    const ExecuteAuditObservationViewChanged(
                                        view: CrudView.create));
                                context.read<ExecuteAuditObservationBloc>().add(
                                      ExecuteAuditObservationSiteChanged(
                                        site: Site(
                                          id: auditDetailState
                                              .auditSummary?.siteId,
                                          name: auditDetailState
                                              .auditSummary?.siteName,
                                        ),
                                        isInit: true,
                                      ),
                                    );
                                break;
                              case CrudView.detail:
                                context.read<ExecuteAuditObservationBloc>().add(
                                    const ExecuteAuditObservationViewChanged(
                                        view: CrudView.list));
                                break;
                              case CrudView.create:
                                context
                                    .read<ExecuteAuditObservationBloc>()
                                    .add(ExecuteAuditObservationCreated());
                                break;
                              case CrudView.update:
                                context
                                    .read<ExecuteAuditObservationBloc>()
                                    .add(ExecuteAuditObservationUpdated());
                                break;
                            }
                          },
                        )
                      ],
                    )
                  ],
                ),
              );
            },
          ),
          spacery20,
          BlocBuilder<ExecuteAuditObservationBloc,
              ExecuteAuditObservationState>(
            builder: (context, state) {
              if (state.status.isLoading) {
                return const Center(child: Loader());
              }
              switch (state.view) {
                case CrudView.list:
                  return const AuditObservationListView();
                case CrudView.detail:
                  return const AuditObservationDetailView();
                case CrudView.create:
                  return const ObservationCreateUpdateView();
                case CrudView.update:
                  return const ObservationCreateUpdateView();
              }
            },
          ),
        ],
      ),
    );
  }
}
