import '/common_libraries.dart';

class AssestsView extends StatelessWidget {
  const AssestsView({super.key});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 3,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          CustomBottomBorderContainer(
            padding: inset20,
            child: Text(
              'Assets',
              style: textSemiBold16,
            ),
          ),
          BlocConsumer<ActionItemDetailBloc, ActionItemDetailState>(
            listener: (context, state) {
              CustomNotification(
                context: context,
                notifyType: NotifyType.success,
                content: state.message,
              ).showNotification();
            },
            listenWhen: (previous, current) =>
                previous.documentDeleteStatus != current.documentDeleteStatus &&
                current.documentDeleteStatus.isSuccess,
            builder: (context, state) {
              if (state.documentListLoadStatus.isLoading ||
                  state.documentDeleteStatus.isLoading) {
                return const Center(child: Loader());
              }

              if (state.documentList.isEmpty) {
                return Center(
                    child: Padding(
                  padding: insety20,
                  child: Text(
                    'There is no asset.',
                    style: textNormal14,
                  ),
                ));
              }

              return Column(
                children: [
                  CustomBottomBorderContainer(
                    padding: inset12,
                    child: Row(
                      children: [
                        Expanded(
                          child: Text(
                            'Document',
                            style: textNormal12,
                          ),
                        ),
                        SizedBox(
                          width: 100,
                          child: Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 20),
                            child: Text(
                              'Download',
                              style: textNormal12,
                            ),
                          ),
                        ),
                        SizedBox(
                          width: 50,
                          child: Text(
                            'Delete',
                            style: textNormal12,
                          ),
                        ),
                      ],
                    ),
                  ),
                  for (final document in state.documentList)
                    AssetsListItemView(document: document)
                ],
              );
            },
          ),
        ],
      ),
    );
  }
}

class AssetsListItemView extends StatelessWidget {
  final Document document;
  const AssetsListItemView({
    super.key,
    required this.document,
  });

  @override
  Widget build(BuildContext context) {
    final bool active = document.documentType!.isImage;
    return CustomBottomBorderContainer(
      padding: inset12,
      child: Row(
        children: [
          Expanded(
            child: MouseRegion(
              cursor: SystemMouseCursors.click,
              child: GestureDetector(
                onTap: () => showImageDialog(
                  fileName: document.originalFileName ?? '',
                  url: document.uri ?? '',
                ),
                child: Text(
                  '${document.originalFileName ?? ''} (${active ? 'image' : document.documentType!.contains('pdf') ? 'pdf' : 'word'})',
                  style: textNormal12.copyWith(
                      color: active ? primaryColor : null),
                ),
              ),
            ),
          ),
          Container(
            width: 100,
            alignment: Alignment.center,
            child: IconButton(
              onPressed: () async {
                await downloadFileUsingDocument(document);
              },
              icon: Icon(
                PhosphorIcons.regular.downloadSimple,
                color: purpleColor,
                size: 16,
              ),
            ),
          ),
          Container(
            width: 50,
            alignment: Alignment.center,
            child: IconButton(
              onPressed: () => CustomAlert(
                context: context,
                width: MediaQuery.of(context).size.width / 4,
                title: 'Confirm',
                description:
                    'Are you going to delete this asset from action item?',
                btnOkText: 'OK',
                btnCancelOnPress: () {},
                btnOkOnPress: () => context.read<ActionItemDetailBloc>().add(
                    ActionItemDetailDocumentDeleted(documentId: document.id)),
                dialogType: DialogType.question,
              ).show(),
              icon: Icon(
                PhosphorIcons.regular.trashSimple,
                color: Colors.red,
                size: 16,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
