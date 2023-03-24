import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:safety_eta/data/model/model.dart';
import 'package:safety_eta/features/administration/masters/masters_widgets/masters_list_template/widgets/widgets.dart';
import '../../masters_widgets/add_edit_master_template/add_edit_master_template.dart';
import '../../masters_widgets/add_edit_master_template/widgets/form_item.dart';
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
        ObservationTypeSelected(
          observationType: ObservationType(
            name: '',
            security: '',
            visibility: '',
            active: true,
          ),
        ),
      );
    }

    super.initState();
  }

  void _addObservationType(ObservationTypesState state) {
    observationTypesBloc.add(
      ObservationTypeAdded(
        observationType: state.selectedObservationType!.copyWith(
          name: observationTypeNameController.text,
        ),
      ),
    );
  }

  void _editObservationType(ObservationTypesState state) {
    observationTypesBloc.add(
      ObservationTypeEdited(
        observationType: state.selectedObservationType!.copyWith(
          name: observationTypeNameController.text,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ObservationTypesBloc, ObservationTypesState>(
      listener: (context, state) {
        if (state.selectedObservationType != null) {
          observationTypeSeverity =
              state.selectedObservationType!.security.isEmpty
                  ? null
                  : state.selectedObservationType!.security;
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
        if (state.observationTypeAddedStatus == EntityStatus.succuess ||
            state.observationTypeAddedStatus == EntityStatus.failure) {
          GoRouter.of(context).go('/observation-types');
        }

        if (state.observationTypeEditedStatus == EntityStatus.succuess ||
            state.observationTypeEditedStatus == EntityStatus.failure) {
          GoRouter.of(context).go('/observation-types');
        }
      },
      builder: (context, state) {
        return AddEditMasterTemplate(
          label: 'observation type',
          id: widget.observationTypeId,
          selectedEntity: state.selectedObservationType,
          addEntity: () => _addObservationType(state),
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
                          security: severity.key,
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
