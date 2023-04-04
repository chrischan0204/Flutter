import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '/utils/custom_notification.dart';
import '/data/model/model.dart';
import '/global_widgets/global_widget.dart';
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

  _deleteSite(SitesState state) {
    sitesBloc.add(SiteDeleted(siteId: state.selectedSite!.id!));
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SitesBloc, SitesState>(
      listener: (context, state) {
        if (state.siteCrudStatus == EntityStatus.success) {
          sitesBloc.add(SitesStatusInited());
          CustomNotification(
            context: context,
            notifyType: NotifyType.success,
            content: state.message,
          ).showNotification();

          GoRouter.of(context).go('/sites');
        }
        if (state.siteCrudStatus == EntityStatus.failure) {
          sitesBloc.add(SitesStatusInited());
          CustomNotification(
            context: context,
            notifyType: NotifyType.error,
            content: state.message,
          ).showNotification();
        }
      },
      builder: (context, state) {
        return EntityShowTemplate(
          title: 'Site',
          label: 'site',
          deleteEntity: () => _deleteSite(state),
          deletable:
              state.selectedSite == null ? true : state.selectedSite!.deletable,
          descriptionForDelete:
              'The site has users or observations associated to it',
          tabItems: {
            'Site Details': Container(),
            'Audits Templates': Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 20.0),
                  child: Text(
                    'The following templates are associated with this site. Edit site to associate/ remove templates from this site',
                    style: TextStyle(
                      fontSize: 14,
                      fontFamily: 'OpenSans',
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ),
                const CustomDivider(),
                Container(
                  child: DataTable(
                    columns: const [
                      DataColumn(
                        label: Text(
                          'Template Name',
                        ),
                      ),
                      DataColumn(
                        label: Text(
                          'Created By',
                        ),
                      ),
                      DataColumn(
                        label: Text(
                          'Last Revised on',
                        ),
                      ),
                    ],
                    rows: [],
                    // rows: List<AuditTemplate>.from(state.selectedSite != null
                    //         ? state.selectedSite!.auditTemplates
                    //         : [])
                    //     .map((auditTemplate) => DataRow(
                    //         cells: List.from(
                    //                 auditTemplate.toTableDetailMap().values)
                    //             .map((detail) => DataCell(CustomDataCell(
                    //                   data: detail,
                    //                 )))
                    //             .toList()))
                    //     .toList(),
                  ),
                ),
              ],
            ),
            'Site kiosks': Container(),
          },
          entity: state.selectedSite,
        );
      },
    );
  }
}
