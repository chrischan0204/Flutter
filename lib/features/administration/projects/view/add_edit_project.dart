import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '/global_widgets/global_widget.dart';
import '/utils/utils.dart';
import '/data/model/model.dart';
import '/data/bloc/bloc.dart';
import 'assign_companies_to_project.dart';

class AddEditProjectView extends StatefulWidget {
  final String? projectId;
  final String? view;
  const AddEditProjectView({
    super.key,
    this.projectId,
    this.view,
  });

  @override
  State<AddEditProjectView> createState() => _AddEditProjectViewState();
}

class _AddEditProjectViewState extends State<AddEditProjectView> {
  late ProjectsBloc projectsBloc;
  late SitesBloc sitesBloc;
  late RolesBloc rolesBloc;
  TextEditingController projectNameController = TextEditingController(text: '');
  TextEditingController referenceNumberController =
      TextEditingController(text: '');
  TextEditingController referenceNameController =
      TextEditingController(text: '');
  String? site;

  String projectNameValidationMessage = '';
  String siteValidationMessage = '';

  bool isFirstInit = true;

  static String pageLabel = 'project';

  @override
  void initState() {
    projectsBloc = context.read<ProjectsBloc>();
    sitesBloc = context.read<SitesBloc>()..add(SitesRetrieved());
    if (widget.projectId != null) {
      projectsBloc.add(
        ProjectSelectedById(projectId: widget.projectId!),
      );
      rolesBloc = context.read<RolesBloc>()..add(RolesRetrieved());
    } else {
      projectsBloc.add(const ProjectSelected(selectedProject: Project()));
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
          label: pageLabel,
          id: widget.projectId,
          selectedEntity: state.selectedProject,
          addEntity: () => _addProject(state),
          editEntity: () => _editProject(state),
          isCrudDataFill: _checkFormDataFill(),
          crudStatus: state.projectCrudStatus,
          tabItems: _buildTabs(state),
          view: widget.view,
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

  Map<String, Widget> _buildTabs(ProjectsState state) {
    if (widget.projectId == null) {
      return {};
    }
    return {
      'Details': Container(),
      'Companies': AssignCompaniesToProjectView(
        projectId: widget.projectId!,
        projectName: state.selectedProject?.name ?? '',
        view: widget.view,
      ),
      '': Container(),
    };
  }

  // check if some of fields are filled
  bool _checkFormDataFill() {
    return widget.projectId == null
        ? projectNameController.text.trim().isNotEmpty ||
            referenceNameController.text.trim().isNotEmpty ||
            referenceNumberController.text.trim().isNotEmpty ||
            (site != null && site!.isNotEmpty)
        : true;
  }

  // change form data whenever the state changes
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

  // check if the crud result is success or failure
  void _checkCrudResult(ProjectsState state, BuildContext context) {
    if (state.projectCrudStatus == EntityStatus.success) {
      projectsBloc.add(ProjectsStatusInited());
      CustomNotification(
        context: context,
        notifyType: NotifyType.success,
        content: state.message,
      ).showNotification();
      if (widget.projectId == null) {
        GoRouter.of(context)
            .go('/projects/edit/${state.selectedProject!.id}?view=created');
      }
    }
    if (state.projectCrudStatus == EntityStatus.failure) {
      projectsBloc.add(ProjectsStatusInited());
      setState(() {
        projectNameValidationMessage = state.message;
      });
    }
  }

  // return text field for project name
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

  // return select field for site
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

  // return text field for reference number
  FormItem _buildReferenceNumberField(ProjectsState state) {
    String label = 'Reference Number', hintText = 'Internal reference number';
    return FormItem(
      label: label,
      content: CustomTextField(
        controller: referenceNumberController,
        hintText: hintText,
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

  // return text field for reference name
  FormItem _buildReferenceNameField(ProjectsState state) {
    String label = 'Reference Name', hintText = 'Internal reference name';
    return FormItem(
      label: label,
      content: CustomTextField(
        controller: referenceNameController,
        hintText: hintText,
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

  // check if field are empty
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

  // call event to add project
  void _addProject(ProjectsState state) {
    if (!_validate()) return;
    projectsBloc.add(ProjectAdded(project: state.selectedProject!));
  }

  // call even to edit project
  void _editProject(ProjectsState state) {
    if (!_validate()) return;
    projectsBloc.add(ProjectEdited(project: state.selectedProject!));
  }
}
