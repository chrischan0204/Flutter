import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '/utils/custom_notification.dart';
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
        const PriorityLevelSelected(
          priorityLevel: PriorityLevel(
            name: '',
            priorityType: '',
            colorCode: Color(0xffffffff),
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

        if (state.priorityLevelCrudStatus == EntityStatus.succuess) {
          priorityLevelsBloc.add(const PriorityLevelsStatusInited());
          CustomNotification(
            context: context,
            notifyType: NotifyType.success,
            content: state.message,
          ).showNotification();

          GoRouter.of(context).go('/priority-levels');
        }
        if (state.priorityLevelCrudStatus == EntityStatus.failure) {
          priorityLevelsBloc.add(const PriorityLevelsStatusInited());
          CustomNotification(
            context: context,
            notifyType: NotifyType.error,
            content: state.message,
          ).showNotification();
        }
      },
      builder: (context, state) {
        return AddEditEntityTemplate(
          label: 'priority level',
          id: widget.priorityLevelId,
          selectedEntity: state.selectedPriorityLevel,
          addEntity: () => _addPriorityLevel(state),
          editEntity: () => _editPriorityLevel(state),
          crudStatus: state.priorityLevelCrudStatus,
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
                  color: colorCode ?? const Color(0xff1233ff),
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
            ],
          ),
        );
      },
    );
  }
}
