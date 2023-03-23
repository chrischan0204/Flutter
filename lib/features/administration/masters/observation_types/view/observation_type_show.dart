import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:safety_eta/data/model/model.dart';

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
    return BlocConsumer<ObservationTypesBloc, ObservationTypesState>(
      listener: (context, state) {
        if (state.observationTypeDeletedStatus == EntityStatus.succuess) {
          GoRouter.of(context).go('/observation-types');
        }
      },
      builder: (context, state) {
        return MasterShowTemplate(
          title: 'Observation Type',
          label: 'Observation Type',
          entity: state.selectedObservationType,
          deleteEntity: () {
            observationTypesBloc.add(
              ObservationTypeDeleted(
                observationTypeId: state.selectedObservationType!.id!,
              ),
            );
          },
        );
      },
    );
  }
}
