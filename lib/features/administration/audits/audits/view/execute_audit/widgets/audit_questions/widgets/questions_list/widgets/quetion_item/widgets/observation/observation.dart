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
    return Column(
      children: [
        BlocBuilder<ExecuteAuditObservationBloc, ExecuteAuditObservationState>(
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
              ),
            );
          },
        ),
        spacery20,
        BlocBuilder<ExecuteAuditObservationBloc, ExecuteAuditObservationState>(
          builder: (context, state) {
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
    );
  }
}
