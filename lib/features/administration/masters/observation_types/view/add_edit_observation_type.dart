import 'package:flutter/material.dart';

import '../bloc/add_edit_observation_type/add_edit_observation_type_bloc.dart';
import '/utils/custom_notification.dart';
import '/global_widgets/global_widget.dart';
import '/data/bloc/bloc.dart';

class AddEditObservationTypeView extends StatelessWidget {
  final String? observationTypeId;
  const AddEditObservationTypeView({
    super.key,
    this.observationTypeId,
  });

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => AddEditObservationTypeBloc(
        formDirtyBloc: context.read(),
        observationTypesRepository: RepositoryProvider.of(context),
      ),
      child: AddEditObservationTypeWidget(observationTypeId: observationTypeId),
    );
  }
}

class AddEditObservationTypeWidget extends StatefulWidget {
  final String? observationTypeId;
  const AddEditObservationTypeWidget({
    super.key,
    this.observationTypeId,
  });

  @override
  State<AddEditObservationTypeWidget> createState() =>
      _AddEditObservationTypeViewState();
}

class _AddEditObservationTypeViewState
    extends State<AddEditObservationTypeWidget> {
  late AddEditObservationTypeBloc addEditObservationTypeBloc;

  @override
  void initState() {
    addEditObservationTypeBloc = context.read();
    if (widget.observationTypeId != null) {
      addEditObservationTypeBloc.add(AddEditObservationTypeLoaded(
          observationTypeId: widget.observationTypeId!));
    }

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AddEditObservationTypeBloc,
        AddEditObservationTypeState>(
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
          label: 'observation type',
          id: widget.observationTypeId,
          selectedEntity: state.loadedObservationType,
          addEntity: () =>
              addEditObservationTypeBloc.add(AddEditObservationTypeAdded()),
          crudStatus: state.status,
          editEntity: () => addEditObservationTypeBloc.add(
              AddEditObservationTypeEdited(id: widget.observationTypeId ?? '')),
          child: Column(
            children: [
              _buildObservationTypeNameField(),
              _buildSeveritySelectField(),
              _buildVisibilitySelectField(),
              if (widget.observationTypeId != null) _buildActiveSwitch(),
            ],
          ),
        );
      },
    );
  }

  Widget _buildActiveSwitch() {
    return BlocBuilder<AddEditObservationTypeBloc, AddEditObservationTypeState>(
      builder: (context, state) {
        return FormItem(
          label: 'Deactivate?',
          content: CustomSwitch(
            label: 'This observation type is deactivated',
            switchValue: state.deactivated,
            onChanged: (deactivated) {
              addEditObservationTypeBloc.add(
                  AddEditObservationTypeDeactivatedChanged(
                      deactivated: deactivated));
            },
          ),
        );
      },
    );
  }

  Widget _buildVisibilitySelectField() {
    return BlocBuilder<AddEditObservationTypeBloc, AddEditObservationTypeState>(
      builder: (context, state) {
        return FormItem(
          label: 'Visibility',
          content: CustomSingleSelect(
            items: const <String, String>{
              'Everywhere': 'Everywhere',
              'Assessment Only': 'Assessment Only',
            },
            selectedValue: state.observationTypeVisibility,
            hint: 'Select Visibility',
            onChanged: (visibility) {
              addEditObservationTypeBloc.add(
                  AddEditObservationTypeVisibilityChanged(
                      observationTypeVisibility: visibility.value));
            },
          ),
        );
      },
    );
  }

  Widget _buildSeveritySelectField() {
    return BlocBuilder<AddEditObservationTypeBloc, AddEditObservationTypeState>(
      builder: (context, state) {
        return FormItem(
          label: 'Severity (*)',
          content: CustomSingleSelect(
            items: const <String, String>{
              'Good Catch': 'Good Catch',
              'Near Miss': 'Near Miss',
              'Unsafe': 'Unsafe',
              'Positive': 'Positive',
            },
            hint: 'Select Severity',
            selectedValue: state.observationTypeSeverity,
            onChanged: (severity) {
              addEditObservationTypeBloc.add(
                  AddEditObservationTypeSeverityChanged(
                      observationTypeSeverity: severity.value));
            },
          ),
          message: state.observationTypeSeverityValidationMessage,
        );
      },
    );
  }

  Widget _buildObservationTypeNameField() {
    return BlocBuilder<AddEditObservationTypeBloc, AddEditObservationTypeState>(
      builder: (context, state) {
        return FormItem(
          label: 'Observation Type Name (*)',
          content: CustomTextField(
            key: ValueKey(state.loadedObservationType?.id),
            initialValue: state.observationTypeName,
            hintText: 'Observation Type Name',
            onChanged: (observationTypeName) {
              addEditObservationTypeBloc.add(AddEditObservationTypeNameChanged(
                  observationTypeName: observationTypeName));
            },
          ),
          message: state.observationTypeNameValidationMessage,
        );
      },
    );
  }
}
