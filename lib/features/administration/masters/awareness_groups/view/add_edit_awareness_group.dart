import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

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

  FocusNode awarenessGroupNameFocusNode = FocusNode();
  bool isFirstInit = true;

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
        AwarenessGroupSelected(
          awarenessGroup: AwarenessGroup(
            name: '',
            active: true,
          ),
        ),
      );
    }

    super.initState();
  }

  void _addAwarenessGroup(AwarenessGroupsState state) {
    awarenessGroupsBloc.add(
      AwarenessGroupAdded(
        awarenessGroup: state.selectedAwarenessGroup!.copyWith(
          name: awarenessGroupNameController.text,
        ),
      ),
    );
  }

  void _editAwarenessGroup(AwarenessGroupsState state) {
    awarenessGroupsBloc.add(
      AwarenessGroupEdited(
        awarenessGroup: state.selectedAwarenessGroup!.copyWith(
          name: awarenessGroupNameController.text,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AwarenessGroupsBloc, AwarenessGroupsState>(
      listener: (context, state) {
        if (state.selectedAwarenessGroup != null) {
          awarenessGroupDeactive = !state.selectedAwarenessGroup!.active;
          if (isFirstInit) {
            awarenessGroupNameController.text = widget.awarenessGroupId == null
                ? ''
                : state.selectedAwarenessGroup!.name ?? '';
            isFirstInit = false;
          }
        }
        if (state.awarenessGroupAddedStatus == EntityStatus.succuess ||
            state.awarenessGroupAddedStatus == EntityStatus.failure) {
          GoRouter.of(context).go('/awareness-groups');
        }

        if (state.awarenessGroupEditedStatus == EntityStatus.succuess ||
            state.awarenessGroupEditedStatus == EntityStatus.failure) {
          GoRouter.of(context).go('/awareness-groups');
        }
      },
      builder: (context, state) {
        return AddEditEntityTemplate(
          label: 'awareness group',
          id: widget.awarenessGroupId,
          selectedEntity: state.selectedAwarenessGroup,
          addEntity: () => _addAwarenessGroup(state),
          addedStatus: state.awarenessGroupAddedStatus,
          editEntity: () => _editAwarenessGroup(state),
          editedStatus: state.awarenessGroupEditedStatus,
          child: Column(
            children: [
              FormItem(
                label: 'Awareness Group Name (*)',
                content: CustomTextField(
                  focusNode: awarenessGroupNameFocusNode,
                  controller: awarenessGroupNameController,
                  hintText: 'Awareness Group Name',
                  onChanged: (awarenessGroupName) {
                    awarenessGroupsBloc.add(
                      AwarenessGroupSelected(
                        awarenessGroup: state.selectedAwarenessGroup!.copyWith(
                          name: awarenessGroupName,
                        ),
                      ),
                    );
                  },
                ),
                message: '',
              ),
            ],
          ),
        );
      },
    );
  }
}
