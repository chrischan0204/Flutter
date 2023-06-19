import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '/utils/custom_notification.dart';
import '/data/model/model.dart';
import '/global_widgets/global_widget.dart';
import '/data/bloc/bloc.dart';
import 'widgets/audit_template_list.dart';

class SiteShowView extends StatelessWidget {
  final String siteId;
  const SiteShowView({
    super.key,
    required this.siteId,
  });

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ShowSiteBloc(
        sitesRepository: RepositoryProvider.of(context),
      ),
      child: SiteShowWidget(siteId: siteId),
    );
  }
}

class SiteShowWidget extends StatefulWidget {
  final String siteId;
  const SiteShowWidget({
    super.key,
    required this.siteId,
  });

  @override
  State<SiteShowWidget> createState() => _SiteShowWidgetState();
}

class _SiteShowWidgetState extends State<SiteShowWidget> {
  late ShowSiteBloc showSiteBloc;

  static String pageTitle = 'Site';
  static String pageLabel = 'site';
  static String descriptionForDelete =
      'The site has users or observations associated to it';

  Map<String, Widget> get tabItems {
    return {
      'Audit Templates': AuditTemplateListView(siteId: widget.siteId),
      'Site kiosks': Container(),
    };
  }

  @override
  void initState() {
    showSiteBloc = context.read<ShowSiteBloc>()
      ..add(ShowSiteLoaded(id: widget.siteId));
    super.initState();
  }

  _deleteSite() {
    showSiteBloc.add(ShowSiteDeleted(id: widget.siteId));
  }

  void _checkDeleteResult(ShowSiteState state, BuildContext context) {
    if (state.deleteStatus == EntityStatus.success) {
      CustomNotification(
        context: context,
        notifyType: NotifyType.success,
        content: state.message,
      ).showNotification();

      GoRouter.of(context).go('/sites');
    }
    if (state.deleteStatus == EntityStatus.failure) {
      CustomNotification(
        context: context,
        notifyType: NotifyType.error,
        content: state.message,
      ).showNotification();
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShowSiteBloc, ShowSiteState>(
      listener: (context, state) {
        _checkDeleteResult(state, context);
      },
      builder: (context, state) {
        return EntityShowTemplate(
          title: pageTitle,
          label: pageLabel,
          deleteEntity: () => _deleteSite(),
          deletable: state.site?.deletable ?? false,
          descriptionForDelete: descriptionForDelete,
          tabItems: tabItems,
          entity: state.site,
          crudStatus: state.deleteStatus,
        );
      },
    );
  }
}
