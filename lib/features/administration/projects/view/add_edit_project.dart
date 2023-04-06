import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '/global_widgets/global_widget.dart';
import '/utils/utils.dart';
import '/data/model/model.dart';
import '/data/bloc/bloc.dart';

class AddEditProjectView extends StatefulWidget {
  final String? projectId;
  const AddEditProjectView({
    super.key,
    this.projectId,
  });

  @override
  State<AddEditProjectView> createState() => _AddEditProjectViewState();
}

class _AddEditProjectViewState extends State<AddEditProjectView> {
  late ProjectsBloc projectsBloc;
  late SitesBloc sitesBloc;
  TextEditingController projectNameController = TextEditingController(
    text: '',
  );
  TextEditingController referenceNumberController = TextEditingController(
    text: '',
  );
  TextEditingController referenceNameController = TextEditingController(
    text: '',
  );
  String? site;

  String projectNameValidationMessage = '';
  String siteValidationMessage = '';

  bool isFirstInit = true;

  @override
  void initState() {
    projectsBloc = context.read<ProjectsBloc>();
    sitesBloc = context.read<SitesBloc>()..add(SitesRetrieved());
    if (widget.projectId != null) {
      projectsBloc.add(
        ProjectSelectedById(projectId: widget.projectId!),
      );
    } else {
      projectsBloc.add(
        const ProjectSelected(
          selectedProject: Project(),
        ),
      );
    }

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ProjectsBloc, ProjectsState>(
      listener: (context, state) {
        _changeFormData(state);
        _checkCrudResult(state, context);
      },
      builder: (context, state) {
        return AddEditEntityTemplate(
          label: 'project',
          id: widget.projectId,
          selectedEntity: state.selectedProject,
          addEntity: () => _addProject(state),
          editEntity: () => _editProject(state),
          addButtonName: 'Assign Companies',
          crudStatus: state.projectCrudStatus,
          child: Column(
            children: [
              _buildProjectNameField(state),
              _buildSiteSelectField(state),
              _buildReferenceNumberField(state),
              _buildReferenceNameField(state),
            ],
          ),
        );
      },
    );
  }

  void _changeFormData(ProjectsState state) {
    if (state.selectedProject != null) {
      site = state.selectedProject!.siteName.isEmpty
          ? null
          : state.selectedProject!.siteName;

      if (isFirstInit) {
        projectNameController.text =
            widget.projectId == null ? '' : state.selectedProject!.name ?? '';
        referenceNameController.text = widget.projectId == null
            ? ''
            : state.selectedProject!.referneceName;
        referenceNumberController.text = widget.projectId == null
            ? ''
            : state.selectedProject!.referenceNumber;
        isFirstInit = false;
      }
    }
  }

  void _checkCrudResult(ProjectsState state, BuildContext context) {
    if (state.projectCrudStatus == EntityStatus.success) {
      projectsBloc.add(ProjectsStatusInited());
      CustomNotification(
        context: context,
        notifyType: NotifyType.success,
        content: state.message,
      ).showNotification();
      GoRouter.of(context).go('/projects/abc/assign-companies');
    }
    if (state.projectCrudStatus == EntityStatus.failure) {
      projectsBloc.add(ProjectsStatusInited());
    }
  }

  FormItem _buildProjectNameField(ProjectsState state) {
    return FormItem(
      label: 'Project Name (*)',
      content: CustomTextField(
        controller: projectNameController,
        hintText: 'Project Name',
        onChanged: (projectName) {
          setState(() {
            projectNameValidationMessage = '';
          });
          projectsBloc.add(
            ProjectSelected(
              selectedProject: state.selectedProject!.copyWith(
                name: projectName,
              ),
            ),
          );
        },
      ),
      message: projectNameValidationMessage,
    );
  }

  BlocBuilder<SitesBloc, SitesState> _buildSiteSelectField(
      ProjectsState state) {
    return BlocBuilder<SitesBloc, SitesState>(
      builder: (context, sitesState) {
        Map<String, String> items = <String, String>{}..addEntries(sitesState
            .sites
            .map((site) => MapEntry(site.name ?? '', site.id!)));
        return FormItem(
          label: 'Site (*)',
          content: CustomSingleSelect(
            items: items,
            hint: 'Select Site',
            selectedValue: sitesState.sites.isEmpty ? null : site,
            onChanged: (site) {
              setState(() {
                siteValidationMessage = '';
              });
              projectsBloc.add(
                ProjectSelected(
                  selectedProject: state.selectedProject!.copyWith(
                    siteName: site.key,
                    siteId: site.value,
                  ),
                ),
              );
            },
          ),
          message: siteValidationMessage,
        );
      },
    );
  }

  FormItem _buildReferenceNumberField(ProjectsState state) {
    return FormItem(
      label: 'Reference Number',
      content: CustomTextField(
        controller: referenceNumberController,
        hintText: 'Internal reference number',
        onChanged: (referenceNumber) {
          projectsBloc.add(
            ProjectSelected(
              selectedProject: state.selectedProject!.copyWith(
                referenceNumber: referenceNumber,
              ),
            ),
          );
        },
      ),
    );
  }

  FormItem _buildReferenceNameField(ProjectsState state) {
    return FormItem(
      label: 'Reference Name',
      content: CustomTextField(
        controller: referenceNameController,
        hintText: 'Internal reference name',
        onChanged: (referenceName) {
          projectsBloc.add(
            ProjectSelected(
              selectedProject: state.selectedProject!.copyWith(
                referneceName: referenceName,
              ),
            ),
          );
        },
      ),
    );
  }

  bool _validate() {
    bool validated = true;
    if (projectNameController.text.isEmpty ||
        projectNameController.text.trim().isEmpty) {
      setState(() {
        projectNameValidationMessage =
            'Project name is required and cannot be blank.';
      });

      validated = false;
    }

    if (site == null ||
        (site != null && (site!.isEmpty || site!.trim().isEmpty))) {
      setState(() {
        siteValidationMessage = 'Site is required.';
      });

      validated = false;
    }

    return validated;
  }

  void _addProject(ProjectsState state) {
    if (!_validate()) return;
    projectsBloc.add(ProjectAdded(project: state.selectedProject!));
  }

  void _editProject(ProjectsState state) {
    if (!_validate()) return;
    projectsBloc.add(ProjectEdited(project: state.selectedProject!));
  }
}
