import 'package:flutter/material.dart';

import '../bloc/add_edit_priority_level/add_edit_priority_level_bloc.dart';
import '/utils/custom_notification.dart';
import '/data/bloc/bloc.dart';
import '/global_widgets/global_widget.dart';

class AddEditPriorityLevelView extends StatelessWidget {
  final String? priorityLevelId;
  const AddEditPriorityLevelView({
    super.key,
    this.priorityLevelId,
  });

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => AddEditPriorityLevelBloc(
        priorityLevelsRepository: RepositoryProvider.of(context),
        formDirtyBloc: context.read(),
      ),
      child: AddEditPriorityLevelWidget(priorityLevelId: priorityLevelId),
    );
  }
}

class AddEditPriorityLevelWidget extends StatefulWidget {
  final String? priorityLevelId;
  const AddEditPriorityLevelWidget({
    super.key,
    this.priorityLevelId,
  });

  @override
  State<AddEditPriorityLevelWidget> createState() =>
      _AddEditPriorityLevelWidgetState();
}

class _AddEditPriorityLevelWidgetState
    extends State<AddEditPriorityLevelWidget> {
  late AddEditPriorityLevelBloc addEditPriorityLevelBloc;

  @override
  void initState() {
    addEditPriorityLevelBloc = context.read();
    if (widget.priorityLevelId != null) {
      addEditPriorityLevelBloc
          .add(AddEditPriorityLevelLoaded(id: widget.priorityLevelId!));
    }

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AddEditPriorityLevelBloc, AddEditPriorityLevelState>(
      listener: (context, state) {
        if (state.status.isSuccess) {
          CustomNotification(
            context: context,
            notifyType: NotifyType.success,
            content: state.message,
          ).showNotification();
        }
        if (state.status .isFailure) {
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
          label: 'priority level',
          id: widget.priorityLevelId,
          selectedEntity: state.loadedPriorityLevel,
          addEntity: () =>
              addEditPriorityLevelBloc.add(AddEditPriorityLevelAdded()),
          editEntity: () => addEditPriorityLevelBloc.add(
              AddEditPriorityLevelEdited(id: widget.priorityLevelId ?? '')),
          crudStatus: state.status,
          child: Column(
            children: [
              BlocBuilder<AddEditPriorityLevelBloc, AddEditPriorityLevelState>(
                builder: (context, state) {
                  return FormItem(
                    label: 'Priority Level (*)',
                    content: CustomTextField(
                      key: ValueKey(state.loadedPriorityLevel?.id),
                      initialValue: state.priorityLevelName,
                      hintText: 'Priority Level Name',
                      onChanged: (priorityLevelName) {
                        addEditPriorityLevelBloc.add(
                            AddEditPriorityLevelChanged(
                                priorityLevel: priorityLevelName));
                      },
                    ),
                    message: state.priorityLevelNameValidationMessage,
                  );
                },
              ),
              BlocBuilder<AddEditPriorityLevelBloc, AddEditPriorityLevelState>(
                builder: (context, state) {
                  return FormItem(
                    label: 'Priority Type (*)',
                    content: CustomSingleSelect(
                      items: const <String, String>{
                        'Corrective': 'Corrective',
                        'Positive': 'Positive',
                      },
                      hint: 'Select Priority Type',
                      selectedValue: state.priorityType,
                      onChanged: (priorityType) {
                        addEditPriorityLevelBloc.add(
                            AddEditPriorityLevelTypeChanged(
                                priorityType: priorityType.value));
                      },
                    ),
                    message: state.priorityTypeValidationMessage,
                  );
                },
              ),
              BlocBuilder<AddEditPriorityLevelBloc, AddEditPriorityLevelState>(
                builder: (context, state) {
                  return FormItem(
                    label: 'Color (*)',
                    content: CustomColorPicker(
                      color: state.colorCode,
                      onChanged: (colorCode) => addEditPriorityLevelBloc.add(
                          AddEditPriorityLevelColorCodeChanged(
                              colorCode: colorCode)),
                    ),
                  );
                },
              ),
              if (widget.priorityLevelId != null)
                BlocBuilder<AddEditPriorityLevelBloc,
                    AddEditPriorityLevelState>(
                  builder: (context, state) {
                    return FormItem(
                      label: 'Deactivate?',
                      content: CustomSwitch(
                        label: 'This observation type is deactivated',
                        switchValue: state.deactivated,
                        onChanged: (deactivated) {
                          addEditPriorityLevelBloc.add(
                              AddEditPriorityLevelDeactivatedChanged(
                                  deactivated: deactivated));
                        },
                      ),
                    );
                  },
                )
            ],
          ),
        );
      },
    );
  }
}
