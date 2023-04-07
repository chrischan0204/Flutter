import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '/utils/custom_notification.dart';
import '/data/model/model.dart';
import '/global_widgets/global_widget.dart';
import '/data/bloc/bloc.dart';

class ShowProjectView extends StatefulWidget {
  final String projectId;
  const ShowProjectView({
    super.key,
    required this.projectId,
  });

  @override
  State<ShowProjectView> createState() => _ShowProjectViewState();
}

class _ShowProjectViewState extends State<ShowProjectView> {
  late ProjectsBloc projectsBloc;

  static String pageTitle = 'Project';
  static String pageLabel = 'project';

  @override
  void initState() {
    projectsBloc = context.read<ProjectsBloc>()
      ..add(
        ProjectSelectedById(projectId: widget.projectId),
      );
    super.initState();
  }

  _deleteProject(ProjectsState state) {
    projectsBloc.add(ProjectDeleted(projectId: state.selectedProject!.id!));
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ProjectsBloc, ProjectsState>(
      listener: (context, state) => _checkDeleteProjectStatus(state, context),
      builder: (context, state) {
        return EntityShowTemplate(
          title: pageTitle,
          label: pageLabel,
          deleteEntity: () => _deleteProject(state),
          tabItems: _buildTabs,
          entity: state.selectedProject,
        );
      },
    );
  }

  Map<String, Widget> get _buildTabs {
    return {
      'Project Details': Container(),
      'Associated Companies': Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 20.0),
            child: Text(
              'The following companies are associated with this project. Edit project to associate/ remove companies from this project',
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
                    'Company Name',
                  ),
                ),
                DataColumn(
                  label: Text(
                    'Role',
                  ),
                ),
                DataColumn(
                  label: Text(
                    'Added By',
                  ),
                ),
                DataColumn(
                  label: Text(
                    'Added on',
                  ),
                ),
              ],
              rows: [],
            ),
          ),
        ],
      ),
    };
  }

  void _checkDeleteProjectStatus(ProjectsState state, BuildContext context) {
    if (state.projectCrudStatus == EntityStatus.success) {
      projectsBloc.add(ProjectsStatusInited());
      CustomNotification(
        context: context,
        notifyType: NotifyType.success,
        content: state.message,
      ).showNotification();

      GoRouter.of(context).go('/projects');
    }
    if (state.projectCrudStatus == EntityStatus.failure) {
      projectsBloc.add(ProjectsStatusInited());
      CustomNotification(
        context: context,
        notifyType: NotifyType.error,
        content: state.message,
      ).showNotification();
    }
  }
}
