import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '/utils/custom_notification.dart';
import '/global_widgets/global_widget.dart';
import '/data/model/model.dart';
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
      listener: (context, state) {
        if (state.regionCrudStatus == EntityStatus.succuess) {
          regionsBloc.add(const RegionsStatusInited());
          CustomNotification(
            context: context,
            notifyType: NotifyType.success,
            content: state.message,
          ).showNotification();

          GoRouter.of(context).go('/regions');
        }
        if (state.regionCrudStatus == EntityStatus.failure) {
          regionsBloc.add(const RegionsStatusInited());
          CustomNotification(
            context: context,
            notifyType: NotifyType.error,
            content: state.message,
          ).showNotification();
        }
      },
      builder: (context, state) {
        return EntityShowTemplate(
          title: 'Region',
          label: 'region',
          entity: state.selectedRegion,
          deletable: state.selectedRegion == null
              ? true
              : state.selectedRegion!.deletable,
          deleteEntity: () {
            regionsBloc.add(
              RegionDeleted(
                regionId: state.selectedRegion!.id!,
              ),
            );
          },
          crudStatus: state.regionCrudStatus,
        );
      },
    );
  }
}
