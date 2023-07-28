import 'package:strings/strings.dart';

import '/common_libraries.dart';
import 'widgets/widgets.dart';

class AuditActionItemView extends StatefulWidget {
  const AuditActionItemView({super.key});

  @override
  State<AuditActionItemView> createState() => _AuditActionItemViewState();
}

class _AuditActionItemViewState extends State<AuditActionItemView> {
  @override
  void initState() {
    context
        .read<ExecuteAuditActionItemBloc>()
        .add(ExecuteAuditActionItemListLoaded());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        BlocConsumer<ExecuteAuditActionItemBloc, ExecuteAuditActionItemState>(
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
                    'Action Item ${capitalize(state.view.name)}',
                    style: textNormal14,
                  ),
                  CustomBadge(
                    label: state.view.toString(),
                    color: primaryColor,
                    radius: 10,
                    onClick: () {
                      switch (state.view) {
                        case CrudView.list:
                          context.read<ExecuteAuditActionItemBloc>().add(
                              const ExecuteAuditActionItemViewChanged(
                                  view: CrudView.create));
                          break;
                        case CrudView.detail:
                          context.read<ExecuteAuditActionItemBloc>().add(
                              const ExecuteAuditActionItemViewChanged(
                                  view: CrudView.list));
                          break;
                        case CrudView.create:
                          context
                              .read<ExecuteAuditActionItemBloc>()
                              .add(ExecuteAuditActionItemCreated());
                          break;
                        case CrudView.update:
                          context
                              .read<ExecuteAuditActionItemBloc>()
                              .add(ExecuteAuditActionItemUpdated());
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
        BlocBuilder<ExecuteAuditActionItemBloc, ExecuteAuditActionItemState>(
          builder: (context, state) {
            if (state.status.isLoading) {
              return const Center(child: Loader());
            }
            switch (state.view) {
              case CrudView.list:
                return const AuditActionItemListView();
              case CrudView.detail:
                return const AuditActionItemDetailView();
              case CrudView.create:
                return const ActionItemCreateUpdateView();
              case CrudView.update:
                return const ActionItemCreateUpdateView();
            }
          },
        ),
      ],
    );
  }
}
