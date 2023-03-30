import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '/utils/custom_notification.dart';
import '/data/model/model.dart';
import '/global_widgets/global_widget.dart';
import '/data/bloc/bloc.dart';

class AddEditObservationTypeView extends StatefulWidget {
  final String? observationTypeId;
  const AddEditObservationTypeView({
    super.key,
    this.observationTypeId,
  });

  @override
  State<AddEditObservationTypeView> createState() =>
      _AddEditObservationTypeViewState();
}

class _AddEditObservationTypeViewState
    extends State<AddEditObservationTypeView> {
  late ObservationTypesBloc observationTypesBloc;

  TextEditingController observationTypeNameController = TextEditingController(
    text: '',
  );
  String? observationTypeSeverity;
  String? observationTypeVisibility;
  bool observationTypeDeactive = false;

  FocusNode observationTypeNameFocusNode = FocusNode();
  bool isFirstInit = true;

  @override
  void initState() {
    observationTypesBloc = context.read<ObservationTypesBloc>();
    observationTypesBloc.add(const ObservationTypesStatusInited());
    if (widget.observationTypeId != null) {
      observationTypesBloc.add(
        ObservationTypeSelectedById(
            observationTypeId: widget.observationTypeId!),
      );
    } else {
      observationTypesBloc.add(
        const ObservationTypeSelected(
          observationType: ObservationType(
            name: '',
            severity: '',
            visibility: '',
            active: true,
          ),
        ),
      );
    }

    super.initState();
  }

  void _addObservationType(ObservationTypesState state) {
    if (!_validate()) return;
    observationTypesBloc.add(
      ObservationTypeAdded(
        observationType: state.selectedObservationType!.copyWith(
          name: observationTypeNameController.text,
        ),
      ),
    );
  }

  void _editObservationType(ObservationTypesState state) {
    if (!_validate()) return;
    observationTypesBloc.add(
      ObservationTypeEdited(
        observationType: state.selectedObservationType!.copyWith(
          name: observationTypeNameController.text,
        ),
      ),
    );
  }

  bool _validate() {
    if (observationTypeNameController.text.isEmpty ||
        observationTypeNameController.text.trim().isEmpty) {
      CustomNotification(
        context: context,
        notifyType: NotifyType.error,
        content: 'Awareness group name is a mandatory field.',
      ).showNotification();
      return false;
    }

    if (observationTypeSeverity == null ||
        (observationTypeSeverity != null &&
            (observationTypeSeverity!.isEmpty ||
                observationTypeSeverity!.trim().isEmpty))) {
      CustomNotification(
        context: context,
        notifyType: NotifyType.error,
        content: 'Severity is a mandatory field.',
      ).showNotification();
      return false;
    }

    if (observationTypeVisibility == null ||
        (observationTypeVisibility != null &&
            (observationTypeVisibility!.isEmpty ||
                observationTypeVisibility!.trim().isEmpty))) {
      CustomNotification(
        context: context,
        notifyType: NotifyType.error,
        content: 'Visibility is a mandatory field.',
      ).showNotification();
      return false;
    }

    return true;
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ObservationTypesBloc, ObservationTypesState>(
      listener: (context, state) {
        if (state.selectedObservationType != null) {
          observationTypeSeverity =
              state.selectedObservationType!.severity.isEmpty
                  ? null
                  : state.selectedObservationType!.severity;
          observationTypeVisibility =
              state.selectedObservationType!.visibility.isEmpty
                  ? null
                  : state.selectedObservationType!.visibility;
          observationTypeDeactive = !state.selectedObservationType!.active;
          if (isFirstInit) {
            observationTypeNameController.text =
                widget.observationTypeId == null
                    ? ''
                    : state.selectedObservationType!.name ?? '';
            isFirstInit = false;
          }
        }

        if (state.observationTypeCrudStatus == EntityStatus.succuess) {
          observationTypesBloc.add(const ObservationTypesStatusInited());
          CustomNotification(
            context: context,
            notifyType: NotifyType.success,
            content: state.message,
          ).showNotification();
        }
        if (state.observationTypeCrudStatus == EntityStatus.failure) {
          observationTypesBloc.add(const ObservationTypesStatusInited());
          CustomNotification(
            context: context,
            notifyType: NotifyType.error,
            content: state.message,
          ).showNotification();
        }
      },
      builder: (context, state) {
        return AddEditEntityTemplate(
          label: 'observation type',
          id: widget.observationTypeId,
          selectedEntity: state.selectedObservationType,
          addEntity: () => _addObservationType(state),
          crudStatus: state.observationTypeCrudStatus,
          editEntity: () => _editObservationType(state),
          child: Column(
            children: [
              FormItem(
                label: 'Observation Type Name (*)',
                content: CustomTextField(
                  focusNode: observationTypeNameFocusNode,
                  controller: observationTypeNameController,
                  hintText: 'Observation Type Name',
                  onChanged: (observationTypeName) {
                    observationTypesBloc.add(
                      ObservationTypeSelected(
                        observationType:
                            state.selectedObservationType!.copyWith(
                          name: observationTypeName,
                        ),
                      ),
                    );
                  },
                ),
                message: '',
              ),
              FormItem(
                label: 'Severity (*)',
                content: CustomSingleSelect(
                  items: const <String, String>{
                    'Good Catch': 'Good Catch',
                    'Near Miss': 'Near Miss',
                    'Unsafe': 'Unsafe',
                    'Positive': 'Positive',
                  },
                  hint: 'Select Severity',
                  selectedValue: observationTypeSeverity,
                  onChanged: (severity) {
                    observationTypesBloc.add(
                      ObservationTypeSelected(
                        observationType:
                            state.selectedObservationType!.copyWith(
                          severity: severity.key,
                        ),
                      ),
                    );
                  },
                ),
                message: '',
              ),
              FormItem(
                label: 'Visibility',
                content: CustomSingleSelect(
                  items: const <String, String>{
                    'Everywhere': 'Everywhere',
                    'Assessment Only': 'Assessment Only',
                  },
                  selectedValue: observationTypeVisibility,
                  hint: 'Select Visibility',
                  onChanged: (visibility) {
                    observationTypesBloc.add(
                      ObservationTypeSelected(
                        observationType:
                            state.selectedObservationType!.copyWith(
                          visibility: visibility.key,
                        ),
                      ),
                    );
                  },
                ),
                message: '',
              ),
              widget.observationTypeId != null
                  ? FormItem(
                      label: 'Deactivate?',
                      content: CustomSwitch(
                        label: 'This observation type is deactivated',
                        switchValue: observationTypeDeactive,
                        onChanged: (active) {
                          observationTypesBloc.add(
                            ObservationTypeSelected(
                              observationType:
                                  state.selectedObservationType!.copyWith(
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
