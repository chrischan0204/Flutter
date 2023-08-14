import 'package:flutter_reorderable_list/flutter_reorderable_list.dart';
import '/common_libraries.dart';

import '../../blocs/bloc/response_scale_bloc.dart';
import 'response_scale_item_list_item.dart';

class ResponseScaleItemListView extends StatefulWidget {
  const ResponseScaleItemListView({super.key});

  @override
  State<ResponseScaleItemListView> createState() =>
      _ResponseScaleItemListViewState();
}

class _ResponseScaleItemListViewState extends State<ResponseScaleItemListView> {
  bool _reorderCallback(Key item, Key newPosition) {
    context.read<ResponseScaleBloc>().add(ResponseScaleItemListSorted(
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
                if (state.selectedResponseScaleId != null)
                  CustomBottomBorderContainer(
                    child: Padding(
                      padding: inset20,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          RichText(
                            text: TextSpan(
                              text: 'Response Scale Items for ',
                              style: textSemiBold18,
                              children: [
                                TextSpan(
                                  text: state.selectedResponseScale?.name,
                                  style: TextStyle(
                                    color: primaryColor,
                                  ),
                                )
                              ],
                            ),
                          ),
                          CustomButton(
                            onClick: () => context
                                .read<ResponseScaleBloc>()
                                .add(ResponseScaleItemAdded()),
                            backgroundColor: successColor,
                            hoverBackgroundColor: successHoverColor,
                            body: Text(
                              'Add Item',
                              style: textNormal14.copyWith(
                                color: Colors.white,
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                Builder(builder: (context) {
                  if (state.responseScaleItemListLoadStatus.isLoading) {
                    return const Center(child: Loader(topPadding: 100));
                  }
                  return Column(
                    children: [
                      if (state.selectedResponseScaleId != null)
                        CustomBottomBorderContainer(
                          padding: insety10.copyWith(right: 50, left: 50),
                          child: Row(
                            children: [
                              Expanded(
                                child: Text(
                                  'Response Scale Item',
                                  style: textSemiBold16,
                                ),
                              ),
                              SizedBox(
                                width: 100,
                                child: Text(
                                  'Required',
                                  style: textSemiBold16,
                                ),
                              ),
                              SizedBox(
                                width: 100,
                                child: Text(
                                  'Score',
                                  style: textSemiBold16,
                                ),
                              )
                            ],
                          ),
                        ),
                      SizedBox(
                        height: 50.0 * state.responseScaleItemList.length,
                        child: ReorderableList(
                          onReorder: _reorderCallback,
                          onReorderDone: _reorderDone,
                          child: CustomScrollView(
                            slivers: <Widget>[
                              SliverPadding(
                                padding: EdgeInsets.only(
                                    bottom:
                                        MediaQuery.of(context).padding.bottom),
                                sliver: SliverList(
                                  delegate: SliverChildBuilderDelegate(
                                    (BuildContext context, int index) {
                                      return ResponseScaleItemListItemView(
                                        responseScaleItem:
                                            state.responseScaleItemList[index],
                                        isFirst: index == 0,
                                        isLast: index ==
                                            state.responseScaleItemList.length -
                                                1,
                                        index: index,
                                      );
                                    },
                                    childCount:
                                        state.responseScaleItemList.length,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  );
                })
              ],
            ),
          ),
        );
      },
    );
  }
}
