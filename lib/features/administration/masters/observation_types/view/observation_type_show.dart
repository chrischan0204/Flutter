import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '/utils/custom_notification.dart';
import '/data/model/model.dart';
import '/data/bloc/bloc.dart';
import '/global_widgets/global_widget.dart';

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
    observationTypesBloc.add(const ObservationTypesStatusInited());
    observationTypesBloc.add(ObservationTypeSelectedById(
      observationTypeId: widget.observationTypeId,
    ));

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ObservationTypesBloc, ObservationTypesState>(
      listener: (context, state) {
        if (state.observationTypeCrudStatus == EntityStatus.succuess) {
          observationTypesBloc.add(const ObservationTypesStatusInited());
          CustomNotification(
            context: context,
            notifyType: NotifyType.success,
            content: state.message,
          ).showNotification();

          GoRouter.of(context).go('/observation-types');
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
        return EntityShowTemplate(
          title: 'Observation Type',
          label: 'observation type',
          entity: state.selectedObservationType,
          deleteEntity: () {
            observationTypesBloc.add(
              ObservationTypeDeleted(
                observationTypeId: state.selectedObservationType!.id!,
              ),
            );
          },
          crudStatus: state.observationTypeCrudStatus,
        );
      },
    );
  }
}
