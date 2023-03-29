import 'package:flutter/material.dart';
import '/data/model/model.dart';
import '/global_widgets/global_widget.dart';
import '/data/bloc/bloc.dart';

class ObservationTypesListView extends StatefulWidget {
  const ObservationTypesListView({super.key});

  @override
  State<ObservationTypesListView> createState() => _ObservationTypesState();
}

class _ObservationTypesState extends State<ObservationTypesListView> {
  late ObservationTypesBloc observationTypesBloc;
  String successType = 'none';

  @override
  void initState() {
    super.initState();
    observationTypesBloc = context.read<ObservationTypesBloc>()
      ..add(ObservationTypesRetrieved());
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ObservationTypesBloc, ObservationTypesState>(
      builder: (context, state) {
        return EntityListTemplate(
          description:
              'List of defined observation types. Types can be added or current ones edited from this screen.',
          entities: state.observationTypes,
          title: 'Observation Types List',
          label: 'observation type',
          emptyMessage:
              'There are no observation types. Please click on New Observation Type to assign new observation type.',
          entityRetrievedStatus: state.observationTypesRetrievedStatus,
          onRowClick: (observationType) {
            observationTypesBloc.add(ObservationTypeSelected(
              observationType: observationType as ObservationType,
            ));
          },
          selectedEntity: state.selectedObservationType,
        );
      },
    );
  }
}
