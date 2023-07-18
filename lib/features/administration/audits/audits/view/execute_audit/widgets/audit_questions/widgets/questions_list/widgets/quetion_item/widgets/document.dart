import 'package:flutter_smart_dialog/flutter_smart_dialog.dart';
import 'package:safety_eta/common_libraries.dart';

class ExecuteAuditDocumentView extends StatefulWidget {
  const ExecuteAuditDocumentView({super.key});

  @override
  State<ExecuteAuditDocumentView> createState() =>
      _ExecuteAuditDocumentViewState();
}

class _ExecuteAuditDocumentViewState extends State<ExecuteAuditDocumentView> {
  late SmartDialogController dialogController;

  @override
  void initState() {
    dialogController = SmartDialogController();
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
            'Images/ Documents uploaded with observations/ action items on this question',
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
                    child: InkWell(
                      onTap: document.documentType!.isImage
                          ? () {
                              SmartDialog.show(
                                controller: dialogController,
                                builder: (context) {
                                  return Card(
                                    elevation: 3,
                                    child: Container(
                                      decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(10)),
                                      width:
                                          MediaQuery.of(context).size.width / 2,
                                      height:
                                          MediaQuery.of(context).size.height /
                                              2,
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Padding(
                                            padding: inset30,
                                            child: Text(
                                              document.originalFileName ?? '',
                                              style: textNormal14,
                                            ),
                                          ),
                                          Expanded(
                                            child: Container(
                                              decoration: BoxDecoration(
                                                border: Border(
                                                  bottom:
                                                      BorderSide(color: grey),
                                                  top: BorderSide(color: grey),
                                                ),
                                              ),
                                              padding: inset20,
                                              alignment: Alignment.center,
                                              child: Image.network(
                                                'https://api.allorigins.win/raw?url=${document.uri ?? ''}',
                                                height: MediaQuery.of(context)
                                                        .size
                                                        .height /
                                                    2,
                                                fit: BoxFit.fitHeight,
                                              ),
                                            ),
                                          ),
                                          Container(
                                            alignment: Alignment.centerRight,
                                            padding: inset30,
                                            child: ElevatedButton(
                                              onPressed: () {
                                                SmartDialog.dismiss();
                                              },
                                              child: Text(
                                                'Close',
                                                style: textNormal14.copyWith(
                                                  color: Colors.white,
                                                ),
                                              ),
                                            ),
                                          )
                                        ],
                                      ),
                                    ),
                                  );
                                },
                              );
                            }
                          : null,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(document.originalFileName ?? ''),
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
