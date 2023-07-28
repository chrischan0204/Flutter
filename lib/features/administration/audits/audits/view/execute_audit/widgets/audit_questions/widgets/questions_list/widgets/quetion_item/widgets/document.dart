import 'package:safety_eta/common_libraries.dart';

class ExecuteAuditDocumentView extends StatefulWidget {
  const ExecuteAuditDocumentView({super.key});

  @override
  State<ExecuteAuditDocumentView> createState() =>
      _ExecuteAuditDocumentViewState();
}

class _ExecuteAuditDocumentViewState extends State<ExecuteAuditDocumentView> {
  @override
  void initState() {
    context
        .read<ExecuteAuditDocumentBloc>()
        .add(ExecuteAuditDocumentListLoaded());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: insety10,
          child: Text(
            'Images/Documents uploaded with observations/action items on this question',
            style: textNormal14,
          ),
        ),
        BlocBuilder<ExecuteAuditDocumentBloc, ExecuteAuditDocumentState>(
          builder: (context, state) {
            if (state.documentListLoadStatus.isLoading) {
              return const Center(child: Loader());
            }

            return Column(
              children: [
                for (final document in state.documentList)
                  CustomBottomBorderContainer(
                    padding: insety8,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                            child: MouseRegion(
                              cursor: SystemMouseCursors.click,
                              child: GestureDetector(
                                  onTap: document.documentType!.isImage
                                      ? () {
                                          showImageDialog(
                                            fileName:
                                                document.originalFileName ?? '',
                                            url:
                                                'https://api.allorigins.win/raw?url=${document.uri ?? ''}',
                                          );
                                        }
                                      : null,
                                  child: Text(document.originalFileName ?? '')),
                            )),
                        IconButton(
                          onPressed: () async {
                            await downloadFile(document.uri ?? '',
                                filename: document.originalFileName ?? '',
                                ext: document.documentType!.split('.').last);
                          },
                          icon: Icon(
                            PhosphorIcons.regular.downloadSimple,
                            color: Colors.purple,
                          ),
                        )
                      ],
                    ),
                  )
              ],
            );
          },
        ),
      ],
    );
  }
}
