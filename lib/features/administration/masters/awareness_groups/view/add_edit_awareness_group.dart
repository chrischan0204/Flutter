import 'package:flutter/material.dart';

import '/utils/custom_notification.dart';
import '/global_widgets/global_widget.dart';
import '/data/model/model.dart';
import '/data/bloc/bloc.dart';

class AddEditAwarenessGroupView extends StatefulWidget {
  final String? awarenessGroupId;
  const AddEditAwarenessGroupView({
    super.key,
    this.awarenessGroupId,
  });

  @override
  State<AddEditAwarenessGroupView> createState() =>
      _AddEditAwarenessGroupViewState();
}

class _AddEditAwarenessGroupViewState extends State<AddEditAwarenessGroupView> {
  late AwarenessGroupsBloc awarenessGroupsBloc;

  TextEditingController awarenessGroupNameController = TextEditingController(
    text: '',
  );
  String? awarenessGroupSeverity;
  String? awarenessGroupVisibility;
  bool awarenessGroupDeactive = false;

  bool isFirstInit = true;
  String awarenessGroupNameValidationMessage = '';

  @override
  void initState() {
    awarenessGroupsBloc = context.read<AwarenessGroupsBloc>();
    awarenessGroupsBloc.add(const AwarenessGroupsStatusInited());
    if (widget.awarenessGroupId != null) {
      awarenessGroupsBloc.add(
        AwarenessGroupSelectedById(awarenessGroupId: widget.awarenessGroupId!),
      );
    } else {
      awarenessGroupsBloc.add(
        const AwarenessGroupSelected(
          awarenessGroup: AwarenessGroup(),
        ),
      );
    }

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AwarenessGroupsBloc, AwarenessGroupsState>(
      listener: (context, state) {
        _changeFormData(state);
        _checkCrudStatus(state, context);
      },
      builder: (context, state) {
        return AddEditEntityTemplate(
          label: 'awareness group',
          id: widget.awarenessGroupId,
          selectedEntity: state.selectedAwarenessGroup,
          addEntity: () => _addAwarenessGroup(state),
          editEntity: () => _editAwarenessGroup(state),
          crudStatus: state.awarenessGroupCrudStatus,
          child: Column(
            children: [
              _buildAwarenessGroupNameTextField(state),
            ],
          ),
        );
      },
    );
  }

  // change the form data whenever the state changes
  void _changeFormData(AwarenessGroupsState state) {
    if (state.selectedAwarenessGroup != null) {
      awarenessGroupDeactive = !state.selectedAwarenessGroup!.active;
      if (isFirstInit) {
        awarenessGroupNameController.text = widget.awarenessGroupId == null
            ? ''
            : state.selectedAwarenessGroup!.name ?? '';
        isFirstInit = false;
      }
    }
  }

  void _clearForm() {
    if (widget.awarenessGroupId == null) {
      awarenessGroupNameController.clear();
    }
  }

  // check if the crud status is success or failure
  void _checkCrudStatus(AwarenessGroupsState state, BuildContext context) {
    if (state.awarenessGroupCrudStatus == EntityStatus.success) {
      awarenessGroupsBloc.add(const AwarenessGroupsStatusInited());
      _clearForm();
      CustomNotification(
        context: context,
        notifyType: NotifyType.success,
        content: state.message,
      ).showNotification();
    }
    if (state.awarenessGroupCrudStatus == EntityStatus.failure) {
      awarenessGroupsBloc.add(const AwarenessGroupsStatusInited());
      setState(() {
        awarenessGroupNameValidationMessage = state.message;
      });
    }
  }

  // return the textfield for awareness group name
  FormItem _buildAwarenessGroupNameTextField(AwarenessGroupsState state) {
    return FormItem(
      label: 'Awareness Group Name (*)',
      content: CustomTextField(
        controller: awarenessGroupNameController,
        hintText: 'Awareness Group Name',
        onChanged: (awarenessGroupName) {
          initMessages();
          awarenessGroupsBloc.add(
            AwarenessGroupSelected(
              awarenessGroup: state.selectedAwarenessGroup!.copyWith(
                name: awarenessGroupName,
              ),
            ),
          );
        },
      ),
      message: awarenessGroupNameValidationMessage,
    );
  }

  // add awareness group
  void _addAwarenessGroup(AwarenessGroupsState state) {
    if (!_validate()) return;
    // call the event to add awareness group
    awarenessGroupsBloc.add(
      AwarenessGroupAdded(
        awarenessGroup: state.selectedAwarenessGroup!.copyWith(
          name: awarenessGroupNameController.text,
        ),
      ),
    );
  }

  void _editAwarenessGroup(AwarenessGroupsState state) {
    if (!_validate()) return;
    // call the event to edit awareness group
    awarenessGroupsBloc.add(
      AwarenessGroupEdited(
        awarenessGroup: state.selectedAwarenessGroup!.copyWith(
          name: awarenessGroupNameController.text,
        ),
      ),
    );
  }

  // check if form field are empty
  bool _validate() {
    if (awarenessGroupNameController.text.isEmpty ||
        awarenessGroupNameController.text.trim().isEmpty) {
      setState(() {
        awarenessGroupNameValidationMessage =
            'Awareness group name is required.';
      });

      return false;
    }
    return true;
  }

  void initMessages() {
    setState(() {
      awarenessGroupNameValidationMessage = '';
    });
  }
}
