import 'package:flutter/material.dart';
import 'package:safety_eta/global_widgets/global_widget.dart';

import '/data/bloc/bloc.dart';

class SiteShowView extends StatefulWidget {
  final String siteId;
  const SiteShowView({
    super.key,
    required this.siteId,
  });

  @override
  State<SiteShowView> createState() => _SiteShowViewState();
}

class _SiteShowViewState extends State<SiteShowView> {
  late SitesBloc sitesBloc;

  @override
  void initState() {
    sitesBloc = context.read<SitesBloc>()
      ..add(
        SiteSelectedById(siteId: widget.siteId),
      );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SitesBloc, SitesState>(
      builder: (context, state) {
        return EntityShowTemplate(
          title: 'Site',
          label: 'site',
          deleteEntity: () {},
          entity: state.selectedSite,
        );
      },
    );
  }
}
