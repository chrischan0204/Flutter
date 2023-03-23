import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:safety_eta/data/model/model.dart';
import 'package:safety_eta/features/administration/masters/masters_widgets/masters_list_template/widgets/widgets.dart';
import 'package:safety_eta/global_widgets/global_widget.dart';
import '../../masters_widgets/add_edit_master_template/add_edit_master_template.dart';
import '../../masters_widgets/add_edit_master_template/widgets/form_item.dart';
import '../../masters_widgets/masters_list_template/widgets/crud_view/widgets/custom_textfield.dart';
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

  @override
  void initState() {
    observationTypesBloc = context.read<ObservationTypesBloc>();

    if (widget.observationTypeId != null) {
      observationTypesBloc.add(
        ObservationTypeSelectedById(
            observationTypeId: widget.observationTypeId!),
      );
    } else {
      observationTypesBloc.add(
        ObservationTypeSelected(
          observationType: ObservationType(
            security: '',
            visibility: '',
            active: true,
          ),
        ),
      );
    }
    super.initState();
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
          // observationTypeNameController.text =
          //     state.selectedObservationType!.name ?? '';
        } else {
          observationTypeSeverity = null;
          observationTypeVisibility = null;
          observationTypeDeactive = false;
        }
        if (state.observationTypeAddedStatus == EntityStatus.succuess) {
          GoRouter.of(context).go('/observation-types');
        }

        if (state.observationTypeEditedStatus == EntityStatus.succuess) {
          GoRouter.of(context).go('/observation-types');
        }
      },
      builder: (context, state) {
        return AddEditMasterTemplate(
          label: 'observation type',
          id: widget.observationTypeId,
          selectedEntity: state.selectedObservationType,
          addEntity: () {
            observationTypesBloc.add(
              ObservationTypeAdded(
                observationType: state.selectedObservationType!.copyWith(
                  name: observationTypeNameController.text,
                ),
              ),
            );
          },
          editEntity: () {
            observationTypesBloc.add(
              ObservationTypeEdited(
                observationType: state.selectedObservationType!.copyWith(
                  name: observationTypeNameController.text,
                ),
              ),
            );
          },
          child: Column(
            children: [
              BlocListener<ObservationTypesBloc, ObservationTypesState>(
                listener: (context, state) {
                  observationTypeNameController.text =
                      state.selectedObservationType!.name ?? '';
                },
                listenWhen: (previous, current) =>
                    previous.selectedObservationType == null &&
                    current.selectedObservationType != null,
                child: FormItem(
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
                          security: severity,
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
                          visibility: visibility,
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
