import 'package:flutter/material.dart';

import '../bloc/add_edit_awareness_group/add_edit_awareness_group_bloc.dart';
import '/utils/custom_notification.dart';
import '/global_widgets/global_widget.dart';
import '/data/bloc/bloc.dart';

class AddEditAwarenessGroupView extends StatelessWidget {
  final String? awarenessGroupId;
  const AddEditAwarenessGroupView({
    super.key,
    this.awarenessGroupId,
  });

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => AddEditAwarenessGroupBloc(
        awarenessGroupsRepository: RepositoryProvider.of(context),
        formDirtyBloc: context.read(),
      ),
      child: AddEditAwarenessGroupWidget(awarenessGroupId: awarenessGroupId),
    );
  }
}

class AddEditAwarenessGroupWidget extends StatefulWidget {
  final String? awarenessGroupId;
  const AddEditAwarenessGroupWidget({
    super.key,
    this.awarenessGroupId,
  });

  @override
  State<AddEditAwarenessGroupWidget> createState() =>
      _AddEditAwarenessGroupWidgetState();
}

class _AddEditAwarenessGroupWidgetState
    extends State<AddEditAwarenessGroupWidget> {
  late AddEditAwarenessGroupBloc _addEditAwarenessGroupBloc;

  @override
  void initState() {
    _addEditAwarenessGroupBloc = context.read();
    if (widget.awarenessGroupId != null) {
      _addEditAwarenessGroupBloc
          .add(AddEditAwarenessGroupLoaded(id: widget.awarenessGroupId!));
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AddEditAwarenessGroupBloc, AddEditAwarenessGroupState>(
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
            notifyType: NotifyType.success,
            content: state.message,
          ).showNotification();
        }
      },
      listenWhen: (previous, current) => previous.status != current.status,
      builder: (context, state) {
        return AddEditEntityTemplate(
          label: 'awareness group',
          id: widget.awarenessGroupId,
          selectedEntity: state.loadedAwarenessGroup,
          addEntity: () =>
              _addEditAwarenessGroupBloc.add(AddEditAwarenessGroupAdded()),
          editEntity: () => _addEditAwarenessGroupBloc.add(
              AddEditAwarenessGroupEdited(id: widget.awarenessGroupId ?? '')),
          crudStatus: state.status,
          child: Column(
            children: [
              _buildAwarenessGroupNameTextField(),
            ],
          ),
        );
      },
    );
  }

  // return the textfield for awareness group name
  Widget _buildAwarenessGroupNameTextField() {
    return BlocBuilder<AddEditAwarenessGroupBloc, AddEditAwarenessGroupState>(
      builder: (context, state) {
        return FormItem(
          label: 'Awareness Group Name (*)',
          content: CustomTextField(
            key: ValueKey(state.loadedAwarenessGroup?.id),
            initialValue: state.name,
            hintText: 'Awareness Group Name',
            onChanged: (awarenessGroupName) {
              _addEditAwarenessGroupBloc.add(
                  AddEditAwarenessGroupNameChanged(name: awarenessGroupName));
            },
          ),
          message: state.nameValidationMessage,
        );
      },
    );
  }
}
