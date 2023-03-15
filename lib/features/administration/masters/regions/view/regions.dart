import 'package:flutter/material.dart';

import '../../widgets/widgets.dart';
import '/data/bloc/bloc.dart';

class Regions extends StatefulWidget {
  const Regions({super.key});

  @override
  State<Regions> createState() => _RegionsState();
}

class _RegionsState extends State<Regions> {
  @override
  void initState() {
    super.initState();
    context.read<RegionsBloc>().add(RegionsRetrieved());
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<RegionsBloc, RegionsState>(
      builder: (context, state) {
        return MasterTable(
          description: 'The following regions are available to create sites in',
          entities: state.regions,
          title: 'Regions',
          label: 'region',
        );
      },
    );
  }
}
