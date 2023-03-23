import 'package:flutter/material.dart';
import 'package:safety_eta/features/administration/masters/masters_widgets/add_edit_master_template/add_edit_master_template.dart';

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
  @override
  Widget build(BuildContext context) {
    return AddEditMasterTemplate(
      label: 'Observation Type',
    );
  }
}
