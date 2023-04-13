import 'package:flutter/material.dart';

import '/constants/color.dart';
import '/data/model/model.dart';
import '/global_widgets/global_widget.dart';
import '/data/bloc/bloc.dart';

class CompaniesListView extends StatefulWidget {
  const CompaniesListView({super.key});

  @override
  State<CompaniesListView> createState() => _CompaniesListViewState();
}

class _CompaniesListViewState extends State<CompaniesListView> {
  late CompaniesBloc companiesBloc;
  late SitesBloc sitesBloc;
  late RegionsBloc regionsBloc;
  late ProjectsBloc projectsBloc;

  bool filterApplied = false;

  List<Region> filterRegions = [];
  List<Site> filterSites = [];
  List<Project> filterProjects = [];
  bool filterActive = true;

  TextEditingController filterNameHasController =
      TextEditingController(text: '');

  static String pageTitle = 'Companies';
  static String pageLabel = 'company';
  static String emptyMessage =
      'There are no companies. Please click on New Company to add new company';

  @override
  void initState() {
    companiesBloc = context.read<CompaniesBloc>()..add(CompaniesRetrieved());
    sitesBloc = context.read<SitesBloc>()..add(SitesRetrieved());
    regionsBloc = context.read<RegionsBloc>()..add(AssignedRegionsRetrieved());
    projectsBloc = context.read<ProjectsBloc>()..add(ProjectsRetrieved());

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CompaniesBloc, CompaniesState>(
      builder: (context, state) {
        return EntityListTemplate(
          title: pageTitle,
          label: pageLabel,
          entities: state.companies,
          showTableHeaderButtons: true,
          onRowClick: (selectedCompany) => _selectCompany(selectedCompany),
          emptyMessage: emptyMessage,
          entityRetrievedStatus: state.companiesRetrievedStatus,
          selectedEntity: state.selectedCompany,
          onTableSort: (sortInfo) => _sortCompanies(sortInfo),
          applyFilter: () => _applyFilter(),
          clearFilter: () => _clearFilter(),
          filterResultBody: _buildFilterResultBody(),
          filterApplied: filterApplied,
          filterBody: _buildFilterBody(),
        );
      },
    );
  }

  void _clearFilter() {
    setState(() {
      filterApplied = false;
    });
  }

  void _applyFilter() {
    setState(() {
      filterApplied = true;
    });
  }

  Column _buildFilterBody() {
    return Column(
      children: [
        _buildFilterCompanyNameTextField(),
        _buildFilterRegionMultiSelectField(),
        _buildFilterSiteMultiSelectField(),
        _buildFilterProjectMultiSelectField(),
        _buildFilterActiveSwitch(),
      ],
    );
  }

  DetailItem _buildFilterCompanyNameTextField() {
    return DetailItem(
      label: 'Name has',
      content: CustomTextField(
        controller: filterNameHasController,
        hintText: 'Company Name contains',
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
            selectedItems: filterSites,
            hint: 'Associated with sites',
            onChanged: (sites) {
              filterSites = sites.map((site) => site as Site).toList();
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
            selectedItems: filterRegions,
            hint: 'Select Regions',
            onChanged: (regions) {
              filterRegions =
                  regions.map((region) => region as Region).toList();
            },
          );
        },
      ),
    );
  }

  DetailItem _buildFilterProjectMultiSelectField() {
    return DetailItem(
      label: 'Project',
      content: BlocBuilder<ProjectsBloc, ProjectsState>(
        builder: (context, state) {
          return CustomMultiSelect(
            items: <String, Project>{}..addEntries(
                state.projects.map(
                  (project) => MapEntry(project.name!, project),
                ),
              ),
            selectedItems: filterProjects,
            hint: 'Associated with projects',
            onChanged: (projects) {
              filterProjects =
                  projects.map((project) => project as Project).toList();
            },
          );
        },
      ),
    );
  }

  void _sortCompanies(MapEntry<String, bool> sortInfo) {
    companiesBloc
        .add(CompaniesSorted(column: sortInfo.key, sortType: sortInfo.value));
  }

  void _selectCompany(Entity selectedCompany) {
    companiesBloc.add(CompanySelectedById(companyId: selectedCompany.id!));
  }

  Wrap _buildFilterResultBody() {
    return Wrap(
      children: [
        FilterItem(
          label: 'Name has:',
          content: filterNameHasController.text,
        ),
        FilterItem(
          label: 'Region:',
          content: filterRegions.map((region) => region.name ?? '').join(', '),
        ),
        FilterItem(
          label: 'Site:',
          content: filterSites.map((site) => site.name ?? '').join(', '),
        ),
        FilterItem(
          label: 'Project:',
          content:
              filterProjects.map((project) => project.name ?? '').join(', '),
        ),
        FilterItem(
          label: 'Active:',
          content: filterActive ? 'Yes' : 'No',
        ),
      ],
    );
  }
}
