import 'package:strings/strings.dart';

import '/common_libraries.dart';

class AuditCommentView extends StatefulWidget {
  const AuditCommentView({super.key});

  @override
  State<AuditCommentView> createState() => _AuditCommentViewState();
}

class _AuditCommentViewState extends State<AuditCommentView> {
  @override
  void initState() {
    context
        .read<ExecuteAuditCommentBloc>()
        .add(ExecuteAuditCommentListLoaded());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        BlocBuilder<ExecuteAuditCommentBloc, ExecuteAuditCommentState>(
          builder: (context, state) {
            return CustomBottomBorderContainer(
              padding: inset8,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Comments ${capitalize(state.view.name)}',
                    style: textNormal14,
                  ),
                  CustomBadge(
                    label: state.view.toString(),
                    color: primaryColor,
                    radius: 10,
                    onClick: () {
                      if (state.view.isCreate) {
                        context.read<ExecuteAuditCommentBloc>()
                          ..add(const ExecuteAuditCommentViewChanged(
                              view: CrudView.list))
                          ..add(ExecuteAuditCommentCreated());
                        ;
                      } else if (state.view.isList) {
                        context.read<ExecuteAuditCommentBloc>().add(
                            const ExecuteAuditCommentViewChanged(
                                view: CrudView.create));
                      } else if (state.view.isUpdate) {
                        context.read<ExecuteAuditCommentBloc>()
                          ..add(const ExecuteAuditCommentViewChanged(
                              view: CrudView.list))
                          ..add(ExecuteAuditCommentUpdated());
                        ;
                      }
                    },
                  )
                ],
              ),
            );
          },
        ),
        spacery20,
        BlocBuilder<ExecuteAuditCommentBloc, ExecuteAuditCommentState>(
          builder: (context, state) {
            switch (state.view) {
              case CrudView.list:
                return const AuditCommentListView();
              case CrudView.detail:
                return Container();
              case CrudView.create:
                return const AuditCommentCreateView();
              case CrudView.update:
                return const AuditCommentUpdateView();
            }
          },
        ),
      ],
    );
  }
}

class AuditCommentListView extends StatelessWidget {
  const AuditCommentListView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ExecuteAuditCommentBloc, ExecuteAuditCommentState>(
      builder: (context, state) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (state.auditCommentListLoadStatus.isLoading)
              const Center(child: Loader()),
            if (state.auditCommentListLoadStatus.isSuccess)
              for (final comment in state.auditCommentList)
                AuditCommentListItemView(comment: comment)
          ],
        );
      },
    );
  }
}

class AuditCommentListItemView extends StatelessWidget {
  final AuditComment comment;
  const AuditCommentListItemView({
    super.key,
    required this.comment,
  });

  @override
  Widget build(BuildContext context) {
    return CustomBottomBorderContainer(
      padding: inset8,
      child: Row(
        children: [
          Expanded(
              child: Text(
            comment.commentText ?? '',
            style: textNormal14,
          )),
          SizedBox(
            width: 50,
            child: IconButton(
              onPressed: () {
                context.read<ExecuteAuditCommentBloc>()
                  ..add(const ExecuteAuditCommentViewChanged(
                      view: CrudView.update))
                  ..add(ExecuteAuditCommentLoaded(commentId: comment.id));
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
                  description: 'Deleting comment. Are you sure?',
                  btnOkText: 'OK',
                  btnOkOnPress: () => context
                      .read<ExecuteAuditCommentBloc>()
                      .add(ExecuteAuditCommentDeleted(commentId: comment.id)),
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
    );
  }
}

class AuditCommentCreateView extends StatelessWidget {
  const AuditCommentCreateView({super.key});

  @override
  Widget build(BuildContext context) {
    return CustomBottomBorderContainer(
      padding: inset10,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Comment:',
            style: textSemiBold12,
          ),
          spacery20,
          CustomTextField(
            hintText: 'please type in comment here...',
            minLines: 3,
            height: null,
            maxLines: 100,
            contentPadding: const EdgeInsets.symmetric(
              vertical: 12,
              horizontal: 10,
            ),
            onChanged: (value) => context
                .read<ExecuteAuditCommentBloc>()
                .add(ExecuteAuditCommentTextChanged(commentText: value)),
          ),
        ],
      ),
    );
  }
}

class AuditCommentUpdateView extends StatelessWidget {
  const AuditCommentUpdateView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ExecuteAuditCommentBloc, ExecuteAuditCommentState>(
      builder: (context, state) {
        return CustomBottomBorderContainer(
          padding: inset10,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Comment:',
                style: textSemiBold12,
              ),
              spacery20,
              CustomTextField(
                key: ValueKey(state.auditComment?.id),
                initialValue: state.auditComment?.commentText,
                hintText: 'please type in comment here...',
                minLines: 3,
                height: null,
                maxLines: 100,
                contentPadding: const EdgeInsets.symmetric(
                  vertical: 12,
                  horizontal: 10,
                ),
                onChanged: (value) => context
                    .read<ExecuteAuditCommentBloc>()
                    .add(ExecuteAuditCommentTextChanged(commentText: value)),
              ),
            ],
          ),
        );
      },
    );
  }
}
