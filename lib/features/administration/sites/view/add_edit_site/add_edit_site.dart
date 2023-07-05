import 'package:safety_eta/features/administration/sites/view/add_edit_site/widgets/assign_templates_to_site.dart';

import '/common_libraries.dart';
import 'widgets/widgets.dart';

class AddEditSiteView extends StatelessWidget {
  final String? siteId;
  final String? view;
  const AddEditSiteView({
    super.key,
    this.siteId,
    this.view,
  });

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => AddEditSiteBloc(context),
      child: AddEditSiteWidget(siteId: siteId),
    );
  }
}

class AddEditSiteWidget extends StatefulWidget {
  final String? siteId;
  final String? view;
  const AddEditSiteWidget({
    super.key,
    this.siteId,
    this.view,
  });

  @override
  State<AddEditSiteWidget> createState() => _AddEditSiteWidgetState();
}

class _AddEditSiteWidgetState extends State<AddEditSiteWidget> {
  late AddEditSiteBloc addEditSiteBloc;

  static String pageLabel = 'site';

  @override
  void initState() {
    addEditSiteBloc = context.read()
      ..add(AddEditSiteRegionListLoaded())
      ..add(AddEditSiteTypeListLoaded());
    if (widget.siteId != null) {
      addEditSiteBloc.add(AddEditSiteLoaded(id: widget.siteId!));
    }

    super.initState();
  }

  Map<String, Widget> get tabItems => widget.siteId != null
      ? {
          'Audit Template': AssignTemplatesToSiteView(siteId: widget.siteId!),
        }
      : {};

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AddEditSiteBloc, AddEditSiteState>(
      listener: (context, state) {
        if (state.status.isSuccess) {
          CustomNotification(
            context: context,
            notifyType: NotifyType.success,
            content: state.message,
          ).showNotification();
          if (widget.siteId == null) {
            GoRouter.of(context)
                .go('/sites/edit/${state.createdSiteId}?view=created');
          }
        }
        if (state.status.isFailure) {
          CustomNotification(
            context: context,
            notifyType: NotifyType.error,
            content: state.message,
          ).showNotification();
        }
      },
      builder: (context, state) {
        return AddEditEntityTemplate(
          label: pageLabel,
          id: widget.siteId,
          selectedEntity: state.loadedSite,
          addEntity: () => addEditSiteBloc.add(AddEditSiteAdded()),
          editEntity: () =>
              addEditSiteBloc.add(AddEditSiteEdited(id: widget.siteId ?? '')),
          crudStatus: state.status,
          tabItems: tabItems,
          view: widget.view,
          formDirty: state.formDirty,
          child: const AddEditTemplateFormView(),
        );
      },
    );
  }
}
