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

  bool filterApplied = false;

  List<String> filterRegions = [];
  List<String> filterSites = [];
  List<String> filterContractors = [];
  bool filterActive = true;

  TextEditingController filterNameHasController =
      TextEditingController(text: '');
  TextEditingController filterRefCodeController =
      TextEditingController(text: '');
  TextEditingController filterRefNameController =
      TextEditingController(text: '');

  static String pageTitle = 'Projects';
  static String pageLabel = 'project';
  static String emptyMessage =
      'There are no projects. Please click on New Project to add new project';

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
          title: pageTitle,
          label: pageLabel,
          viewName: pageLabel,
          entities: state.projects,
          showTableHeaderButtons: true,
          onRowClick: (selectedProject) => _selectProject(selectedProject),
          emptyMessage: emptyMessage,
          entityRetrievedStatus: state.projectsRetrievedStatus,
          selectedEntity: state.selectedProject,
          onTableSorted: (sortedProjects) => _sortProjects(sortedProjects),
        );
      },
    );
  }

  void _clearFilter() {
    setState(() {
      filterApplied = false;
      filterRegions = [];
      filterSites = [];
      filterContractors = [];
      filterActive = true;
      filterNameHasController.text = '';
      filterRefCodeController.text = '';
      filterRefNameController.text = '';
    });
  }

  void _onFilterApplied() {
    setState(() {
      filterApplied = true;
    });
  }

  Column _buildFilterBody() {
    return Column(
      children: [
        _buildFilterRegionMultiSelectField(),
        _buildFilterSiteMultiSelectField(),
        _buildFilterActiveSwitch(),
        _buildFilterProjectNameTextField(),
        _buildFilterRefCodeTextField(),
        _buildFilterRefNameTextField(),
        _buildFilterContractorsMultiSelectField(),
      ],
    );
  }

  DetailItem _buildFilterContractorsMultiSelectField() {
    return DetailItem(
      label: 'Contractors',
      content: CustomMultiSelect(
        items: const <String, Entity>{
          '3CMA Metal': Entity(id: '1', name: '3CMA Metal'),
          'Alington Cement Works':
              Entity(id: '2', name: 'Alington Cement Works'),
          'Burlingto Garden and Tree':
              Entity(id: '3', name: 'Burlingto Garden and Tree'),
          'Carter Concrete': Entity(id: '4', name: 'Carter Concrete'),
          'Floyd Window repairs': Entity(id: '5', name: 'Floyd Window repairs'),
        },
        hint: 'Select Contractors',
        selectedItems: [],
        onChanged: (contractors) {
          filterContractors =
              contractors.map((contractor) => contractor.name ?? '').toList();
        },
      ),
    );
  }

  DetailItem _buildFilterRefNameTextField() {
    return DetailItem(
      label: 'Ref Name',
      content: CustomTextField(
        controller: filterRefNameController,
        hintText: 'Project Name contains',
        onChanged: (refName) {},
      ),
    );
  }

  DetailItem _buildFilterRefCodeTextField() {
    return DetailItem(
      label: 'Ref Code',
      content: CustomTextField(
        controller: filterRefCodeController,
        hintText: 'Project Name contains',
        onChanged: (refCode) {},
      ),
    );
  }

  DetailItem _buildFilterProjectNameTextField() {
    return DetailItem(
      label: 'Name has',
      content: CustomTextField(
        controller: filterNameHasController,
        hintText: 'Project Name contains',
        onChanged: (nameHas) {},
      ),
    );
  }

  DetailItem _buildFilterActiveSwitch() {
    return DetailItem(
      label: 'Active',
      content: CustomSwitch(
        switchValue: filterActive,
        trueString: 'Yes',
        falseString: 'No',
        textColor: darkTeal,
        onChanged: (value) {
          setState(() {
            filterActive = value;
          });
        },
      ),
    );
  }

  DetailItem _buildFilterSiteMultiSelectField() {
    return DetailItem(
      label: 'Site',
      content: BlocBuilder<SitesBloc, SitesState>(
        builder: (context, state) {
          return CustomMultiSelect(
            items: <String, Site>{}..addEntries(
                state.sites.map(
                  (site) => MapEntry(site.name!, site),
                ),
              ),
            selectedItems: [],
            hint: 'Select Sites',
            onChanged: (sites) {
              filterSites = sites.map((site) => site.name ?? '').toList();
            },
          );
        },
      ),
    );
  }

  DetailItem _buildFilterRegionMultiSelectField() {
    return DetailItem(
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
            selectedItems: [],
            hint: 'Select Regions',
            onChanged: (regions) {
              filterRegions =
                  regions.map((region) => region.name ?? '').toList();
            },
          );
        },
      ),
    );
  }

  void _sortProjects(List<Entity> sortedProjects) {
    projectsBloc.add(ProjectsSorted(
        projects: sortedProjects
            .map((sortedProject) => sortedProject as Project)
            .toList()));
  }

  void _selectProject(Entity selectedProject) {
    projectsBloc.add(ProjectSelectedById(projectId: selectedProject.id!));
  }

  Wrap _buildFilterResultBody() {
    return Wrap(
      children: [
        FilterItem(
          label: 'Region:',
          content: filterRegions.join(', '),
        ),
        FilterItem(
          label: 'Site:',
          content: filterSites.join(', '),
        ),
        FilterItem(
          label: 'Active:',
          content: filterActive ? 'Yes' : 'No',
        ),
        FilterItem(
          label: 'Name has:',
          content: filterNameHasController.text,
        ),
        FilterItem(
          label: 'Ref Code:',
          content: filterRefCodeController.text,
        ),
        FilterItem(
          label: 'Ref Name:',
          content: filterRefNameController.text,
        ),
        FilterItem(
          label: 'Contractors:',
          content: filterContractors.join(', '),
          last: true,
        ),
      ],
    );
  }
}
