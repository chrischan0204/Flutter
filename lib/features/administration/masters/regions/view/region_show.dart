import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../masters_widgets/widgets.dart';
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
        if (state.regionDeletedStatus == EntityStatus.succuess ||
            state.regionDeletedStatus == EntityStatus.failure) {
          GoRouter.of(context).go('/regions');
        }
      },
      builder: (context, state) {
        return MasterShowTemplate(
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
        );
      },
    );
  }
}
