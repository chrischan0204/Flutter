import 'package:flutter/material.dart';

import '/data/bloc/bloc.dart';
import '../../masters_widgets/master_show_template/master_show_template.dart';

class ObservationTypeShowView extends StatefulWidget {
  final String observationTypeId;
  const ObservationTypeShowView({
    super.key,
    required this.observationTypeId,
  });

  @override
  State<ObservationTypeShowView> createState() =>
      _ObservationTypeShowViewState();
}

class _ObservationTypeShowViewState extends State<ObservationTypeShowView> {
  late ObservationTypesBloc observationTypesBloc;

  @override
  void initState() {
    observationTypesBloc = context.read<ObservationTypesBloc>();

    observationTypesBloc.add(ObservationTypeSelectedById(
      observationTypeId: widget.observationTypeId,
    ));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ObservationTypesBloc, ObservationTypesState>(
      builder: (context, state) {
        return MasterShowTemplate(
          title:
              'Observation Type',
          label: 'Observation Type',
          entity: state.selectedObservationType,
          onDelete: () {},
        );
      },
    );
  }
}
