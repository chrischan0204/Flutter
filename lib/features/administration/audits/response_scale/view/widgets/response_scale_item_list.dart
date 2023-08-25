import 'package:flutter_reorderable_list/flutter_reorderable_list.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
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
                          Expanded(
                            child: RichText(
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
                          ),
                          spacerx20,
                          Row(
                            children: [
                              BlocConsumer<ResponseScaleBloc,
                                  ResponseScaleState>(
                                listener: (context, state) =>
                                    CustomNotification(
                                  context: context,
                                  notifyType: NotifyType.success,
                                  content: state.message,
                                ).showNotification(),
                                listenWhen: (previous, current) =>
                                    previous.responseScaleItemListCrudStatus !=
                                        current
                                            .responseScaleItemListCrudStatus &&
                                    current.responseScaleItemListCrudStatus
                                        .isSuccess,
                                builder: (context, state) => ElevatedButton(
                                    onPressed: !state.isSaveButtonEnable
                                        ? null
                                        : () {
                                            if (state.isDirty) {
                                              CustomNotification(
                                                      context: context,
                                                      notifyType:
                                                          NotifyType.info,
                                                      content:
                                                          'Please fill the form.')
                                                  .showNotification();
                                            } else {
                                              context.read<ResponseScaleBloc>().add(
                                                  ResponseScaleItemListSaved());
                                            }
                                          },
                                    child: state.responseScaleItemListCrudStatus
                                            .isLoading
                                        ? LoadingAnimationWidget
                                            .prograssiveDots(
                                            color: Colors.white,
                                            size: 22,
                                          )
                                        : Text(
                                            'Save',
                                            style: textNormal14.copyWith(
                                              color: Colors.white,
                                            ),
                                          )),
                              ),
                              spacerx10,
                              ElevatedButton(
                                onPressed: () => context
                                    .read<ResponseScaleBloc>()
                                    .add(ResponseScaleItemAdded()),
                                style: ElevatedButton.styleFrom(
                                    backgroundColor: successColor),
                                child: Text(
                                  'Add More Item',
                                  style: textNormal14.copyWith(
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                            ],
                          )
                        ],
                      ),
                    ),
                  ),
                if (state.selectedResponseScaleId != null)
                  Expanded(
                    child: Builder(
                      builder: (context) {
                        if (state.responseScaleItemListLoadStatus.isLoading) {
                          return const Center(child: Loader(topPadding: 100));
                        }
                        return Column(
                          children: [
                            if (state.selectedResponseScaleId != null)
                              CustomBottomBorderContainer(
                                padding: insety10.copyWith(right: 40, left: 65),
                                child: Row(
                                  children: [
                                    Expanded(
                                      child: Text(
                                        'Response Scale Item',
                                        style: textSemiBold16,
                                      ),
                                    ),
                                    SizedBox(
                                      width: 160,
                                      child: Text(
                                        'Mandatory Items',
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
                            Expanded(
                              child: SingleChildScrollView(
                                child: SizedBox(
                                  height:
                                      50.0 * state.responseScaleItemList.length,
                                  child: ReorderableList(
                                    onReorder: _reorderCallback,
                                    onReorderDone: _reorderDone,
                                    child: CustomScrollView(
                                      slivers: <Widget>[
                                        SliverPadding(
                                          padding: EdgeInsets.only(
                                              bottom: MediaQuery.of(context)
                                                  .padding
                                                  .bottom),
                                          sliver: SliverList(
                                            delegate:
                                                SliverChildBuilderDelegate(
                                              (BuildContext context,
                                                  int index) {
                                                return ResponseScaleItemListItemView(
                                                  responseScaleItem: state
                                                          .responseScaleItemList[
                                                      index],
                                                  isFirst: index == 0,
                                                  isLast: index ==
                                                      state.responseScaleItemList
                                                              .length -
                                                          1,
                                                  index: index,
                                                );
                                              },
                                              childCount: state
                                                  .responseScaleItemList.length,
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        );
                      },
                    ),
                  ),
              ],
            ),
          ),
        );
      },
    );
  }
}
