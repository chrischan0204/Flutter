import 'package:flutter/material.dart';
import '/data/model/model.dart';
import '../../masters_widgets/widgets.dart';
import '/data/bloc/bloc.dart';

class ObservationTypesListView extends StatefulWidget {
  const ObservationTypesListView({super.key});

  @override
  State<ObservationTypesListView> createState() => _ObservationTypesState();
}

class _ObservationTypesState extends State<ObservationTypesListView> {
  late ObservationTypesBloc observationTypesBloc;
  @override
  void initState() {
    super.initState();
    observationTypesBloc = context.read<ObservationTypesBloc>();
    observationTypesBloc.add(ObservationTypesRetrieved());
    observationTypesBloc.add(const ObservationTypesStatusInited());
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ObservationTypesBloc, ObservationTypesState>(
      builder: (context, state) {
        return MastersListTemplate(
          description:
              'List of defined observation types. Types can be added or current ones edited from this screen.',
          entities: state.observationTypes,
          title: 'Observation Types List',
          label: 'observation type',
          note:
              'This observation type is in use on 173 observations. An observation type can be removed from future use by deactivating. It will preserve all past data as is.',
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
