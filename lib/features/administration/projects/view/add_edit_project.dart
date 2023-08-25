import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../bloc/add_edit_project/add_edit_project_bloc.dart';
import '/global_widgets/global_widget.dart';
import '/utils/utils.dart';
import '/data/model/model.dart';
import '/data/bloc/bloc.dart';
import 'assign_companies_to_project.dart';

class AddEditProjectView extends StatelessWidget {
  final String? projectId;
  final String? view;
  const AddEditProjectView({
    super.key,
    this.projectId,
    this.view,
  });

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => AddEditProjectBloc(
        projectsRepository: RepositoryProvider.of(context),
        sitesRepository: RepositoryProvider.of(context),
        formDirtyBloc: context.read(),
      ),
      child: AddEditProjectWidget(
        projectId: projectId,
        view: view,
      ),
    );
  }
}

class AddEditProjectWidget extends StatefulWidget {
  final String? projectId;
  final String? view;
  const AddEditProjectWidget({
    super.key,
    this.projectId,
    this.view,
  });

  @override
  State<AddEditProjectWidget> createState() => _AddEditProjectWidgetState();
}

class _AddEditProjectWidgetState extends State<AddEditProjectWidget> {
  late AddEditProjectBloc addEditProjectBloc;

  static String pageLabel = 'project';

  @override
  void initState() {
    addEditProjectBloc = context.read()..add(AddEditProjectSiteListLoaded());
    context.read<SitesBloc>().add(SitesLoaded());
    if (widget.projectId != null) {
      addEditProjectBloc.add(AddEditProjectLoaded(id: widget.projectId!));
      context.read<RolesBloc>().add(RolesLoaded());
    }

    super.initState();
  }

  Map<String, Widget> get tabViews => widget.projectId == null
      ? {}
      : {
          'Companies': AssignCompaniesToProjectView(
            projectId: widget.projectId!,
            view: widget.view,
          ),
        };

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AddEditProjectBloc, AddEditProjectState>(
      listener: (context, state) {
        if (state.status.isSuccess) {
          CustomNotification(
            context: context,
            notifyType: NotifyType.success,
            content: state.message,
          ).showNotification();
          if (widget.projectId == null) {
            GoRouter.of(context)
                .go('/projects/edit/${state.createdProjectId}?view=created');
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
      listenWhen: (previous, current) => previous.status != current.status,
      builder: (context, state) {
        return AddEditEntityTemplate(
          label: pageLabel,
          id: widget.projectId,
          selectedEntity: state.loadedProject,
          addEntity: () => addEditProjectBloc.add(AddEditProjectAdded()),
          editEntity: () => addEditProjectBloc
              .add(AddEditProjectEdited(id: widget.projectId ?? '')),
          crudStatus: state.status,
          formDirty: state.formDirty,
          tabItems: tabViews,
          view: widget.view,
          child: Column(
            children: [
              _buildProjectNameField(),
              _buildSiteSelectField(),
              _buildReferenceNumberField(),
              _buildReferenceNameField(),
            ],
          ),
        );
      },
    );
  }

  // return text field for project name
  Widget _buildProjectNameField() {
    return BlocBuilder<AddEditProjectBloc, AddEditProjectState>(
      builder: (context, state) {
        return FormItem(
          label: 'Project Name (*)',
          content: CustomTextField(
            key: ValueKey(state.loadedProject?.id),
            initialValue: state.projectName,
            hintText: 'Project Name',
            onChanged: (name) =>
                addEditProjectBloc.add(AddEditProjectNameChanged(name: name)),
          ),
          message: state.projectNameValidationMessage,
        );
      },
    );
  }

  // return select field for site
  Widget _buildSiteSelectField() {
    return BlocBuilder<AddEditProjectBloc, AddEditProjectState>(
      builder: (context, state) {
        Map<String, Site> items = <String, Site>{}..addEntries(
            state.siteList.map((site) => MapEntry(site.name ?? '', site)));
        return FormItem(
          label: 'Site (*)',
          content: CustomSingleSelect(
            items: items,
            hint: 'Select Site',
            selectedValue: state.siteList.isEmpty ? null : state.site?.name,
            onChanged: (site) => addEditProjectBloc
                .add(AddEditProjecSiteChanged(site: site.value as Site)),
          ),
          message: state.siteValidationMessage,
        );
      },
    );
  }

  // return text field for reference number
  Widget _buildReferenceNumberField() {
    String label = 'Reference Number', hintText = 'Internal reference number';
    return BlocBuilder<AddEditProjectBloc, AddEditProjectState>(
      builder: (context, state) {
        return FormItem(
          label: label,
          content: CustomTextField(
            key: ValueKey(state.loadedProject?.id),
            initialValue: state.referenceNumber,
            hintText: hintText,
            onChanged: (referenceNumber) {
              addEditProjectBloc.add(AddEditProjectReferenceNumberChanged(
                  referenceNumber: referenceNumber));
            },
          ),
          message: state.refereneceNumberValidationMessage,
        );
      },
    );
  }

  // return text field for reference name
  Widget _buildReferenceNameField() {
    String label = 'Reference Name', hintText = 'Internal reference name';
    return BlocBuilder<AddEditProjectBloc, AddEditProjectState>(
      builder: (context, state) {
        return FormItem(
          label: label,
          content: CustomTextField(
            key: ValueKey(state.loadedProject?.id),
            initialValue: state.referenceName,
            hintText: hintText,
            onChanged: (referenceName) {
              addEditProjectBloc.add(AddEditProjectReferenceNameChanged(
                  referenceName: referenceName));
            },
          ),
          message: state.referenceNameValidationMessage,
        );
      },
    );
  }
}
