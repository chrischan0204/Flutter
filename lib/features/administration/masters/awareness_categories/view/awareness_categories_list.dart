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
  late String successType = 'none';
  @override
  void initState() {
    super.initState();
    awarenessCategoriesBloc = context.read<AwarenessCategoriesBloc>()
      ..add(
        AwarenessCategoriesRetrieved(),
      );
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AwarenessCategoriesBloc, AwarenessCategoriesState>(
      listener: (context, state) => _displayNofitication(state),
      builder: (context, state) {
        return EntityListTemplate(
          description:
              'List of defined awareness categories. These will show only while assessing an observation. Types can be added or current ones edited from this screen.',
          entities: state.awarenessCategories,
          title: 'Awareness Categories List',
          label: 'awareness category',
          note:
              'This awareness category is in use on 41 assessments. An awareness category can be removed from future use by deactivating. It will preserve all past data as is.',
          onRowClick: (awarenessCategory) {
            awarenessCategoriesBloc.add(AwarenessCategorySelected(
              awarenessCategory: awarenessCategory as AwarenessCategory,
            ));
          },
          selectedEntity: state.selectedAwarenessCategory,
          successType: successType,
        );
      },
    );
  }

  void _displayNofitication(AwarenessCategoriesState state) {
    bool success = false, failed = false;
    if (state.awarenessCategoryAddedStatus == EntityStatus.succuess) {
      setState(() {
        successType = 'add';
      });
      success = true;
    }
    if (state.awarenessCategoryEditedStatus == EntityStatus.succuess) {
      setState(() {
        successType = 'edit';
      });
      success = true;
    }
    if (state.awarenessCategoryDeletedStatus == EntityStatus.succuess) {
      setState(() {
        successType = 'delete';
      });
      success = true;
    }
    if (state.awarenessCategoryAddedStatus == EntityStatus.failure) {
      setState(() {
        successType = 'add-fail';
      });
      failed = true;
    }
    if (state.awarenessCategoryEditedStatus == EntityStatus.failure) {
      setState(() {
        successType = 'edit-fail';
      });
      failed = true;
    }
    if (state.awarenessCategoryDeletedStatus == EntityStatus.failure) {
      setState(() {
        successType = 'delete-fail';
      });
      failed = true;
    }
    if (success || failed) {
      awarenessCategoriesBloc.add(const AwarenessCategoriesStatusInited());
    }
  }
}
