import 'package:flutter/material.dart';

import '/data/model/model.dart';
import '/global_widgets/global_widget.dart';
import '/data/bloc/bloc.dart';

class AwarenessCategoriesListView extends StatefulWidget {
  const AwarenessCategoriesListView({super.key});

  @override
  State<AwarenessCategoriesListView> createState() =>
      _AwarenessCategoriesListViewState();
}

class _AwarenessCategoriesListViewState
    extends State<AwarenessCategoriesListView> {
  late AwarenessCategoriesBloc awarenessCategoriesBloc;

  static String pageDescription =
      'List of defined awareness categories. These will show only while assessing an observation. Types can be added or current ones edited from this screen.';
  static String pageTitle = 'Awareness Categories';
  static String pageLabel = 'awareness category';
  static String emtptyMessage =
      'There are no awareness categories. Please click on New Awareness Category to add new awareness category.';

  @override
  void initState() {
    super.initState();
    awarenessCategoriesBloc = context.read<AwarenessCategoriesBloc>()
      ..add(AwarenessCategoriesRetrieved());
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AwarenessCategoriesBloc, AwarenessCategoriesState>(
      builder: (context, state) {
        return EntityListTemplate(
          description: pageDescription,
          entities: state.awarenessCategories,
          title: pageTitle,
          label: pageLabel,
          emptyMessage: emtptyMessage,
          onRowClick: (awarenessCategory) =>
              _selectAwarenessCategory(awarenessCategory as AwarenessCategory),
          entityRetrievedStatus: state.awarenessCategoriesRetrievedStatus,
          selectedEntity: state.selectedAwarenessCategory,
        );
      },
    );
  }

  _selectAwarenessCategory(AwarenessCategory awarenessCategory) {
    awarenessCategoriesBloc.add(AwarenessCategorySelected(
      awarenessCategory: awarenessCategory,
    ));
  }
}
