import 'package:flutter/material.dart';

import '/data/model/model.dart';
import '../bloc/add_edit_awareness_category/add_edit_awareness_category_bloc.dart';
import '/utils/custom_notification.dart';
import '/global_widgets/global_widget.dart';
import '/data/bloc/bloc.dart';

class AddEditAwarenessCategoryView extends StatelessWidget {
  final String? awarenessCategoryId;
  const AddEditAwarenessCategoryView({
    super.key,
    this.awarenessCategoryId,
  });

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => AddEditAwarenessCategoryBloc(
        awarenessCategoriesRepository: RepositoryProvider.of(context),
        awarenessGroupsRepository: RepositoryProvider.of(context),
        formDirtyBloc: context.read(),
      ),
      child: AddEditAwarenessCategoryWidget(
          awarenessCategoryId: awarenessCategoryId),
    );
  }
}

class AddEditAwarenessCategoryWidget extends StatefulWidget {
  final String? awarenessCategoryId;
  const AddEditAwarenessCategoryWidget({
    super.key,
    this.awarenessCategoryId,
  });

  @override
  State<AddEditAwarenessCategoryWidget> createState() =>
      _AddEditAwarenessCategoryViewState();
}

class _AddEditAwarenessCategoryViewState
    extends State<AddEditAwarenessCategoryWidget> {
  late AddEditAwarenessCategoryBloc _addEditAwarenessCategoryBloc;

  static String pageLabel = 'awareness category';

  @override
  void initState() {
    _addEditAwarenessCategoryBloc = context.read()
      ..add(AddEditAwarenessCategoryGroupListLoaded());

    if (widget.awarenessCategoryId != null) {
      _addEditAwarenessCategoryBloc
          .add(AddEditAwarenessCategoryLoaded(id: widget.awarenessCategoryId!));
    }

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AddEditAwarenessCategoryBloc,
        AddEditAwarenessCategoryState>(
      listener: (context, state) {
        if (state.status.isSuccess) {
          CustomNotification(
            context: context,
            notifyType: NotifyType.success,
            content: state.message,
          ).showNotification();
        }
        if (state.status.isFailure) {
          CustomNotification(
            context: context,
            notifyType: NotifyType.error,
            content: state.message,
          ).showNotification();
        }
      },
      listenWhen: (previous, current) => previous.status != current.status,
      builder: (context, state) {
        return AddEditEntityTemplate(
          label: pageLabel,
          id: widget.awarenessCategoryId,
          selectedEntity: state.loadedAwarenessCategory,
          addEntity: () => _addEditAwarenessCategoryBloc
              .add(AddEditAwarenessCategoryAdded()),
          crudStatus: state.status,
          editEntity: () => _addEditAwarenessCategoryBloc.add(
              AddEditAwarenessCategoryEdited(
                  id: widget.awarenessCategoryId ?? '')),
          child: Column(
            children: [
              _buildAwarenessGroupSelectField(),
              _buildAwarenessCategoryNameTextField(),
              if (widget.awarenessCategoryId != null)
                _buildDeactivateAwarenessCategorySwitch(),
            ],
          ),
        );
      },
    );
  }

  // return switch input to activate or deactivate awareness category
  Widget _buildDeactivateAwarenessCategorySwitch() {
    return BlocBuilder<AddEditAwarenessCategoryBloc,
        AddEditAwarenessCategoryState>(
      builder: (context, state) {
        return FormItem(
          label: 'Deactivate?',
          content: CustomSwitch(
            label: 'This awareness group is deactivated',
            switchValue: state.deactivated,
            onChanged: (deactivated) {
              _addEditAwarenessCategoryBloc.add(
                  AddEditAwarenessCategoryDeactivatedChanged(
                      deactivated: deactivated));
            },
          ),
        );
      },
    );
  }

  // return text field for awareness category name
  Widget _buildAwarenessCategoryNameTextField() {
    return BlocBuilder<AddEditAwarenessCategoryBloc,
        AddEditAwarenessCategoryState>(
      builder: (context, state) {
        return FormItem(
          label: 'Awareness Category (*)',
          content: CustomTextField(
            key: ValueKey(state.loadedAwarenessCategory?.id),
            hintText: 'Awareness Category',
            initialValue: state.name,
            onChanged: (awarenessCategoryName) {
              _addEditAwarenessCategoryBloc.add(
                  AddEditAwarenessCategoryNameChanged(
                      name: awarenessCategoryName));
            },
          ),
          message: state.nameValidationMessage,
        );
      },
    );
  }

  // return select field for awareness group
  Widget _buildAwarenessGroupSelectField() {
    return BlocBuilder<AddEditAwarenessCategoryBloc,
        AddEditAwarenessCategoryState>(
      builder: (context, state) {
        Map<String, AwarenessGroup> awarenessGroupItems = {};
        awarenessGroupItems.addEntries(
          state.awarenessGroupList.map(
            (awarenessGroup) => MapEntry(awarenessGroup.name!, awarenessGroup),
          ),
        );
        return FormItem(
          label: 'Awareness Group (*)',
          content: CustomSingleSelect(
            items: awarenessGroupItems,
            hint: 'Select Awareness Group',
            selectedValue: state.awarenessGroup?.name,
            onChanged: (awarenessGroup) {
              _addEditAwarenessCategoryBloc.add(
                  AddEditAwarenessCategoryGroupChanged(
                      awarenessGroup: awarenessGroup.value));
            },
          ),
          message: state.awarenessGroupValidationMessage,
        );
      },
    );
  }
}
