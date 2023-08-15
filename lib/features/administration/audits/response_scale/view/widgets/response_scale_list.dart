import 'package:flutter_reorderable_list/flutter_reorderable_list.dart';
import 'package:safety_eta/common_libraries.dart';

import '../../blocs/bloc/response_scale_bloc.dart';
import 'response_scale_list_item.dart';
import 'response_scale_text_field.dart';

class ResponseScaleListView extends StatefulWidget {
  const ResponseScaleListView({super.key});

  @override
  State<ResponseScaleListView> createState() => _ResponseScaleListViewState();
}

class _ResponseScaleListViewState extends State<ResponseScaleListView> {
  @override
  void initState() {
    context.read<ResponseScaleBloc>().add(ResponseScaleListLoaded());
    super.initState();
  }

  bool _reorderCallback(Key item, Key newPosition) {
    context.read<ResponseScaleBloc>().add(ResponseScaleListSorted(
          currentId: item,
          newId: newPosition,
        ));

    return true;
  }

  void _reorderDone(Key item) {}

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ResponseScaleBloc, ResponseScaleState>(
      builder: (context, state) {
        return Card(
          elevation: 3,
          child: Padding(
            padding: inset10,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                CustomBottomBorderContainer(
                  child: Padding(
                    padding: inset20,
                    child: Text(
                      'Response Scales',
                      style: textBold18,
                    ),
                  ),
                ),
                CustomBottomBorderContainer(
                  padding: inset10,
                  child: const AddNewResponseScaleField(),
                ),
                SizedBox(
                  height: 50.0 * state.responseScaleList.length,
                  child: ReorderableList(
                    onReorder: _reorderCallback,
                    onReorderDone: _reorderDone,
                    child: CustomScrollView(
                      slivers: <Widget>[
                        SliverPadding(
                          padding: EdgeInsets.only(
                              bottom: MediaQuery.of(context).padding.bottom),
                          sliver: SliverList(
                            delegate: SliverChildBuilderDelegate(
                              (BuildContext context, int index) {
                                return ResponseScaleListItemView(
                                  responseScale: state.responseScaleList[index],
                                  first: index == 0,
                                  last:
                                      index == state.responseScaleList.length - 1,
                                  active: state.responseScaleList[index].id ==
                                      state.selectedResponseScaleId,
                                );
                              },
                              childCount: state.responseScaleList.length,
                            ),
                          ),
                        ),
                      ],
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
}
