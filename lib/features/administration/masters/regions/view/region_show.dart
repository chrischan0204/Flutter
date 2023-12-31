import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '/utils/custom_notification.dart';
import '/global_widgets/global_widget.dart';
import '/data/bloc/bloc.dart';

class RegionShowView extends StatefulWidget {
  final String regionId;
  const RegionShowView({
    super.key,
    required this.regionId,
  });

  @override
  State<RegionShowView> createState() => _RegionShowViewState();
}

class _RegionShowViewState extends State<RegionShowView> {
  late RegionsBloc regionsBloc;

  static String pageTitle = 'Region';
  static String pageLabel = 'region';

  static String descriptionForDelete =
      'Region cannot be deleted, as it\'s having sites associated with it.';

  @override
  void initState() {
    regionsBloc = context.read<RegionsBloc>();
    regionsBloc.add(const RegionsStatusInited());
    regionsBloc.add(RegionSelectedById(
      regionId: widget.regionId,
    ));

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<RegionsBloc, RegionsState>(
      listener: (context, state) => _checkDeleteRegionStatus(state, context),
      builder: (context, state) {
        return EntityShowTemplate(
          title: pageTitle,
          label: pageLabel,
          entity: state.selectedRegion,
          deletable: state.selectedRegion == null
              ? true
              : state.selectedRegion!.deletable,
          deleteEntity: () => _deleteRegion(state),
          descriptionForDelete: state.selectedRegion?.active == false
              ? 'Region cannot be deleted, as it\'s deactivated.'
              : descriptionForDelete,
          crudStatus: state.regionCrudStatus,
        );
      },
    );
  }

  void _deleteRegion(RegionsState state) {
    regionsBloc.add(
      RegionDeleted(
        regionId: state.selectedRegion!.id!,
      ),
    );
  }

  void _checkDeleteRegionStatus(RegionsState state, BuildContext context) {
    if (state.regionCrudStatus.isSuccess) {
      regionsBloc.add(const RegionsStatusInited());
      CustomNotification(
        context: context,
        notifyType: NotifyType.success,
        content: state.message,
      ).showNotification();

      GoRouter.of(context).go('/regions');
    }
    if (state.regionCrudStatus.isFailure) {
      regionsBloc.add(const RegionsStatusInited());
      CustomNotification(
        context: context,
        notifyType: NotifyType.error,
        content: state.message,
      ).showNotification();
    }
  }
}
