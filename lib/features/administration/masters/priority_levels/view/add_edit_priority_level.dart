import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '/data/bloc/bloc.dart';
import '/global_widgets/global_widget.dart';
import '/data/model/model.dart';

class AddEditPriorityLevelView extends StatefulWidget {
  final String? priorityLevelId;
  const AddEditPriorityLevelView({
    super.key,
    this.priorityLevelId,
  });

  @override
  State<AddEditPriorityLevelView> createState() =>
      _AddEditPriorityLevelViewState();
}

class _AddEditPriorityLevelViewState extends State<AddEditPriorityLevelView> {
  late PriorityLevelsBloc priorityLevelsBloc;

  TextEditingController priorityLevelNameController = TextEditingController(
    text: '',
  );
  String? priorityType;
  Color? colorCode;
  bool priorityLevelDeactive = false;

  FocusNode priorityLevelNameFocusNode = FocusNode();
  bool isFirstInit = true;

  @override
  void initState() {
    priorityLevelsBloc = context.read<PriorityLevelsBloc>();
    priorityLevelsBloc.add(const PriorityLevelsStatusInited());
    if (widget.priorityLevelId != null) {
      priorityLevelsBloc.add(
        PriorityLevelSelectedById(priorityLevelId: widget.priorityLevelId!),
      );
    } else {
      priorityLevelsBloc.add(
        PriorityLevelSelected(
          priorityLevel: PriorityLevel(
            name: '',
            priorityType: '',
            colorCode: const Color(0xffffffff),
            active: true,
          ),
        ),
      );
    }

    super.initState();
  }

  void _addPriorityLevel(PriorityLevelsState state) {
    priorityLevelsBloc.add(
      PriorityLevelAdded(
        priorityLevel: state.selectedPriorityLevel!.copyWith(
          name: priorityLevelNameController.text,
        ),
      ),
    );
  }

  void _editPriorityLevel(PriorityLevelsState state) {
    priorityLevelsBloc.add(
      PriorityLevelEdited(
        priorityLevel: state.selectedPriorityLevel!.copyWith(
          name: priorityLevelNameController.text,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<PriorityLevelsBloc, PriorityLevelsState>(
      listener: (context, state) {
        if (state.selectedPriorityLevel != null) {
          priorityType = state.selectedPriorityLevel!.priorityType.isEmpty
              ? null
              : state.selectedPriorityLevel!.priorityType;

          colorCode = state.selectedPriorityLevel!.colorCode;
          priorityLevelDeactive = !state.selectedPriorityLevel!.active;

          if (isFirstInit) {
            priorityLevelNameController.text = widget.priorityLevelId == null
                ? ''
                : state.selectedPriorityLevel!.name ?? '';
            isFirstInit = false;
          }
        }
        if (state.priorityLevelAddedStatus == EntityStatus.succuess ||
            state.priorityLevelAddedStatus == EntityStatus.failure) {
          GoRouter.of(context).go('/priority-levels');
        }

        if (state.priorityLevelEditedStatus == EntityStatus.succuess ||
            state.priorityLevelEditedStatus == EntityStatus.failure) {
          GoRouter.of(context).go('/priority-levels');
        }
      },
      builder: (context, state) {
        return AddEditEntityTemplate(
          label: 'priority level',
          id: widget.priorityLevelId,
          selectedEntity: state.selectedPriorityLevel,
          addEntity: () => _addPriorityLevel(state),
          editEntity: () => _editPriorityLevel(state),
          child: Column(
            children: [
              FormItem(
                label: 'Priority Level (*)',
                content: CustomTextField(
                  focusNode: priorityLevelNameFocusNode,
                  controller: priorityLevelNameController,
                  hintText: 'Priority Level Name',
                  onChanged: (priorityLevelName) {
                    priorityLevelsBloc.add(
                      PriorityLevelSelected(
                        priorityLevel: state.selectedPriorityLevel!.copyWith(
                          name: priorityLevelName,
                        ),
                      ),
                    );
                  },
                ),
                message: '',
              ),
              FormItem(
                label: 'Priority Type (*)',
                content: CustomSingleSelect(
                  items: const <String, String>{
                    'Corrective': 'Corrective',
                    'Positive': 'Positive',
                  },
                  hint: 'Select Priority Type',
                  selectedValue: priorityType,
                  onChanged: (priorityType) {
                    priorityLevelsBloc.add(
                      PriorityLevelSelected(
                        priorityLevel: state.selectedPriorityLevel!.copyWith(
                          priorityType: priorityType.key,
                        ),
                      ),
                    );
                  },
                ),
                message: '',
              ),
              FormItem(
                label: 'Color (*)',
                content: CustomColorPicker(
                  color: colorCode ?? const Color(0xffffffff),
                  onChanged: (colorCode) => priorityLevelsBloc.add(
                    PriorityLevelSelected(
                      priorityLevel: state.selectedPriorityLevel!.copyWith(
                        colorCode: colorCode,
                      ),
                    ),
                  ),
                ),
                message: '',
              ),
              widget.priorityLevelId != null
                  ? FormItem(
                      label: 'Deactivate?',
                      content: CustomSwitch(
                        label: 'This observation type is deactivated',
                        switchValue: priorityLevelDeactive,
                        onChanged: (active) {
                          priorityLevelsBloc.add(
                            PriorityLevelSelected(
                              priorityLevel:
                                  state.selectedPriorityLevel!.copyWith(
                                active: !active,
                              ),
                            ),
                          );
                        },
                      ),
                      message: '',
                    )
                  : Container(),
              // FormItem(
              //   label: 'Deactivated:',
              //   content: Text('By: Andrew Sully on 12th Jan 2023'),
              //   message: '',
              // ),
            ],
          ),
        );
      },
    );
  }
}
