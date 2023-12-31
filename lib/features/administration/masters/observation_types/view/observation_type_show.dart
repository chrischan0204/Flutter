import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '/utils/custom_notification.dart';
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

  static String pageTitle = 'Observation Type';
  static String pageLabel = 'observation type';

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
      listener: (context, state) =>
          _checkDeleteObservationTypeStatus(state, context),
      builder: (context, state) {
        return EntityShowTemplate(
          title: pageTitle,
          label: pageLabel,
          entity: state.selectedObservationType,
          deleteEntity: () => _deleteObservationType(state),
          crudStatus: state.observationTypeCrudStatus,
        );
      },
    );
  }

  void _deleteObservationType(ObservationTypesState state) {
    observationTypesBloc.add(
      ObservationTypeDeleted(
        observationTypeId: state.selectedObservationType!.id!,
      ),
    );
  }

  void _checkDeleteObservationTypeStatus(
      ObservationTypesState state, BuildContext context) {
    if (state.observationTypeCrudStatus.isSuccess) {
      observationTypesBloc.add(const ObservationTypesStatusInited());
      CustomNotification(
        context: context,
        notifyType: NotifyType.success,
        content: state.message,
      ).showNotification();

      GoRouter.of(context).go('/observation-types');
    }
    if (state.observationTypeCrudStatus .isFailure) {
      observationTypesBloc.add(const ObservationTypesStatusInited());
      CustomNotification(
        context: context,
        notifyType: NotifyType.error,
        content: state.message,
      ).showNotification();
    }
  }
}
