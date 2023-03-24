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
  String successType = 'none';

  @override
  void initState() {
    super.initState();
    observationTypesBloc = context.read<ObservationTypesBloc>();
    observationTypesBloc.add(ObservationTypesRetrieved());
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ObservationTypesBloc, ObservationTypesState>(
      listener: (context, state) => _displayNofitication(state),
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
          successType: successType,
        );
      },
    );
  }

  void _displayNofitication(ObservationTypesState state) {
    bool success = false, failed = false;
    if (state.observationTypeAddedStatus == EntityStatus.succuess) {
      setState(() {
        successType = 'add';
      });
      success = true;
    }
    if (state.observationTypeEditedStatus == EntityStatus.succuess) {
      setState(() {
        successType = 'edit';
      });
      success = true;
    }
    if (state.observationTypeDeletedStatus == EntityStatus.succuess) {
      setState(() {
        successType = 'delete';
      });
      success = true;
    }
    if (state.observationTypeAddedStatus == EntityStatus.failure) {
      setState(() {
        successType = 'add-fail';
      });
      failed = true;
    }
    if (state.observationTypeEditedStatus == EntityStatus.failure) {
      setState(() {
        successType = 'edit-fail';
      });
      failed = true;
    }
    if (state.observationTypeDeletedStatus == EntityStatus.failure) {
      setState(() {
        successType = 'delete-fail';
      });
      failed = true;
    }
    if (success || failed) {
      observationTypesBloc.add(const ObservationTypesStatusInited());
    }
  }
}
