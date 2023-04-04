import 'package:flutter/material.dart';
import 'package:safety_eta/global_widgets/global_widget.dart';

import '/constants/color.dart';
import '/data/model/model.dart';
import '/data/bloc/bloc.dart';

class ProjectsListView extends StatefulWidget {
  const ProjectsListView({super.key});

  @override
  State<ProjectsListView> createState() => _ProjectsListViewState();
}

class _ProjectsListViewState extends State<ProjectsListView> {
  late ProjectsBloc projectsBloc;
  late SitesBloc sitesBloc;
  late RegionsBloc regionsBloc;

  bool active = true;

  TextEditingController filterNameHasController =
      TextEditingController(text: '');
  TextEditingController filterRefCodeController =
      TextEditingController(text: '');
  TextEditingController filterRefNameController =
      TextEditingController(text: '');

  @override
  void initState() {
    projectsBloc = context.read<ProjectsBloc>()..add(ProjectsRetrieved());
    sitesBloc = context.read<SitesBloc>()..add(SitesRetrieved());
    regionsBloc = context.read<RegionsBloc>()..add(AssignedRegionsRetrieved());

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
          filterBody: Column(
            children: [
              DetailItem(
                label: 'Region',
                content: BlocBuilder<RegionsBloc, RegionsState>(
                  builder: (context, state) {
                    return CustomMultiSelect(
                      items: <String, Region>{}..addEntries(
                          state.assignedRegions.map(
                            (assignedRegion) =>
                                MapEntry(assignedRegion.name!, assignedRegion),
                          ),
                        ),
                      hint: 'Select Regions',
                      selectedItems: [],
                      onChanged: (regions) {},
                    );
                  },
                ),
              ),
              DetailItem(
                label: 'Site',
                content: BlocBuilder<SitesBloc, SitesState>(
                  builder: (context, state) {
                    return CustomMultiSelect(
                      items: <String, Site>{}..addEntries(
                          state.sites.map(
                            (site) => MapEntry(site.name!, site),
                          ),
                        ),
                      hint: 'Select Sites',
                      selectedItems: [],
                      onChanged: (sites) {},
                    );
                  },
                ),
              ),
              DetailItem(
                label: 'Active',
                content: CustomSwitch(
                  switchValue: active,
                  trueString: 'Yes',
                  falseString: 'No',
                  textColor: darkTeal,
                  onChanged: (value) {
                    setState(() {
                      active = value;
                    });
                  },
                ),
              ),
              DetailItem(
                label: 'Name has',
                content: CustomTextField(
                  controller: filterNameHasController,
                  hintText: 'Project Name contains',
                  onChanged: (nameHas) {},
                ),
              ),
              DetailItem(
                label: 'Ref Code',
                content: CustomTextField(
                  controller: filterRefCodeController,
                  hintText: 'Project Name contains',
                  onChanged: (refCode) {},
                ),
              ),
              DetailItem(
                label: 'Ref Name',
                content: CustomTextField(
                  controller: filterRefNameController,
                  hintText: 'Project Name contains',
                  onChanged: (refName) {},
                ),
              ),
              DetailItem(
                label: 'Contractors',
                content: CustomMultiSelect(
                  items: const <String, Entity>{
                    '3CMA Metal': Entity(id: '1', name: '3CMA Metal'),
                    'Alington Cement Works':
                        Entity(id: '2', name: 'Alington Cement Works'),
                    'Burlingto Garden and Tree':
                        Entity(id: '3', name: 'Burlingto Garden and Tree'),
                    'Carter Concrete': Entity(id: '4', name: 'Carter Concrete'),
                    'Floyd Window repairs':
                        Entity(id: '5', name: 'Floyd Window repairs'),
                  },
                  hint: 'Select Contractors',
                  selectedItems: [],
                  onChanged: (contractors) {},
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
