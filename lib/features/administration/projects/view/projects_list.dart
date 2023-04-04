import 'package:flutter/material.dart';

import '/data/model/model.dart';
import '/global_widgets/entities_list_template/entities_list_template.dart';
import '/data/bloc/bloc.dart';

class ProjectsListView extends StatefulWidget {
  const ProjectsListView({super.key});

  @override
  State<ProjectsListView> createState() => _ProjectsListViewState();
}

class _ProjectsListViewState extends State<ProjectsListView> {
  late ProjectsBloc projectsBloc;

  @override
  void initState() {
    projectsBloc = context.read<ProjectsBloc>()..add(ProjectsRetrieved());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ProjectsBloc, ProjectsState>(
      builder: (context, state) {
        return EntityListTemplate(
          title: 'Projects',
          label: 'project',
          entities: state.projects,
          showTableHeaderButtons: true,
          onRowClick: (selectedProject) {
            projectsBloc.add(
                ProjectSelected(selectedProject: selectedProject as Project));
          },
          entityRetrievedStatus: state.projectsRetrievedStatus,
          selectedEntity: state.selectedProject,
        );
      },
    );
  }
}
