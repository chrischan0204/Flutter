import '/common_libraries.dart';

class ObservationTypeSelectField extends StatelessWidget {
  const ObservationTypeSelectField({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ExecuteAuditBloc, ExecuteAuditState>(
      builder: (context, auditState) {
        Map<String, ObservationType> items = {}..addEntries(
            auditState.observationTypeList.map((observationType) =>
                MapEntry(observationType.name ?? '', observationType)));
        return BlocBuilder<ExecuteAuditObservationBloc,
            ExecuteAuditObservationState>(
          builder: (context, state) {
            return CustomSingleSelect(
              items: items,
              hint: 'Select Observation Type',
              selectedValue: auditState.observationTypeList.isEmpty
                  ? null
                  : state.observationType?.name,
              onChanged: (observationType) {
                context.read<ExecuteAuditObservationBloc>().add(
                    ExecuteAuditObservationTypeChanged(
                        observationType: observationType.value));
              },
            );
          },
        );
      },
    );
  }
}

class ProjectSelectField extends StatelessWidget {
  const ProjectSelectField({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ExecuteAuditObservationBloc,
        ExecuteAuditObservationState>(
      builder: (context, state) {
        Map<String, Project> items = {}..addEntries(state.projectList
            .map((project) => MapEntry(project.name ?? '', project)));
        return CustomSingleSelect(
          items: items,
          hint: 'Select Project',
          selectedValue: state.projectList.isEmpty ? null : state.project?.name,
          onChanged: (project) {
            context.read<ExecuteAuditObservationBloc>().add(
                ExecuteAuditObservationProjectChanged(project: project.value));
          },
        );
      },
    );
  }
}

class PriorityLevelSelectField extends StatelessWidget {
  const PriorityLevelSelectField({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ExecuteAuditBloc, ExecuteAuditState>(
      builder: (context, auditState) {
        Map<String, PriorityLevel> items = {}..addEntries(
            auditState.priorityLevelList.map((priorityLevel) =>
                MapEntry(priorityLevel.name ?? '', priorityLevel)));
        return BlocBuilder<ExecuteAuditObservationBloc,
            ExecuteAuditObservationState>(
          builder: (context, state) {
            return CustomSingleSelect(
              items: items,
              hint: 'Select Priority Level',
              selectedValue: auditState.observationTypeList.isEmpty
                  ? null
                  : state.priorityLevel?.name,
              onChanged: (priorityLevel) {
                context.read<ExecuteAuditObservationBloc>().add(
                    ExecuteAuditObservationPriorityLevelChanged(
                        priorityLevel: priorityLevel.value));
              },
            );
          },
        );
      },
    );
  }
}

class SiteSelectField extends StatelessWidget {
  const SiteSelectField({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ExecuteAuditBloc, ExecuteAuditState>(
      builder: (context, auditState) {
        Map<String, Site> items = {}..addEntries(
            auditState.siteList.map((site) => MapEntry(site.name ?? '', site)));
        return BlocBuilder<ExecuteAuditObservationBloc,
            ExecuteAuditObservationState>(
          builder: (context, state) {
            return CustomSingleSelect(
              items: items,
              hint: 'Select Site',
              selectedValue: auditState.observationTypeList.isEmpty
                  ? null
                  : state.site?.name,
              onChanged: (site) {
                context
                    .read<ExecuteAuditObservationBloc>()
                    .add(ExecuteAuditObservationSiteChanged(site: site.value));
              },
            );
          },
        );
      },
    );
  }
}

class ObservationTextField extends StatelessWidget {
  const ObservationTextField({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ExecuteAuditObservationBloc,
        ExecuteAuditObservationState>(
      builder: (context, state) {
        return CustomTextField(
          key: ValueKey(state.auditObservation?.id),
          initialValue: state.observation,
          hintText:
              'Safety Observation. e.g. Slippery staircase due to oil spill.',
          onChanged: (observation) {
            context.read<ExecuteAuditObservationBloc>().add(
                ExecuteAuditObservationNameChanged(observation: observation));
          },
        );
      },
    );
  }
}

class AreaTextField extends StatelessWidget {
  const AreaTextField({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ExecuteAuditObservationBloc,
        ExecuteAuditObservationState>(
      builder: (context, state) {
        return CustomTextField(
          key: ValueKey(state.auditObservation?.id),
          initialValue: state.area,
          hintText: 'Observation area e.g. in front of admin office',
          onChanged: (area) {
            context
                .read<ExecuteAuditObservationBloc>()
                .add(ExecuteAuditObservationAreaChanged(area: area));
          },
        );
      },
    );
  }
}

class ResponseTextField extends StatelessWidget {
  const ResponseTextField({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ExecuteAuditObservationBloc,
        ExecuteAuditObservationState>(
      builder: (context, state) {
        return CustomTextField(
          key: ValueKey(state.auditObservation?.id),
          initialValue: state.response,
          hintText:
              'What did you do? e.g. called housekeeping to address issue',
          onChanged: (response) {
            context.read<ExecuteAuditObservationBloc>().add(
                ExecuteAuditObservationResponseChanged(response: response));
          },
        );
      },
    );
  }
}

class CompanySelectField extends StatelessWidget {
  const CompanySelectField({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ExecuteAuditObservationBloc,
        ExecuteAuditObservationState>(
      builder: (context, state) {
        Map<String, Company> items = {}..addEntries(state.companyList
            .map((company) => MapEntry(company.name ?? '', company)));
        return CustomSingleSelect(
          items: items,
          hint: 'Select Company',
          selectedValue: state.companyList.isEmpty ? null : state.company?.name,
          onChanged: (company) {
            context.read<ExecuteAuditObservationBloc>().add(
                ExecuteAuditObservationCompanyChanged(company: company.value));
          },
        );
      },
    );
  }
}

class ObservationFilePicker extends StatelessWidget {
  const ObservationFilePicker({super.key});

  @override
  Widget build(BuildContext context) {
    return CustomMultiFilePicker(
        onSelect: (fileList) => context
            .read<ExecuteAuditObservationBloc>()
            .add(ExecuteAuditObservationFileListChanged(fileList: fileList)));
  }
}

class ObservationCreateUpdateView extends StatelessWidget {
  const ObservationCreateUpdateView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ExecuteAuditObservationBloc,
        ExecuteAuditObservationState>(
      builder: (context, state) {
        return Column(
          children: [
            ObservationCreateUpdateFormItemView(
              label: 'Observation (*)',
              content: const ObservationTextField(),
              validationMessage: state.observationValidationMessage,
            ),
            ObservationCreateUpdateFormItemView(
              label: 'Area (*)',
              content: const AreaTextField(),
              validationMessage: state.areaValidationMessage,
            ),
            ObservationCreateUpdateFormItemView(
              label: 'Site (*)',
              content: const SiteSelectField(),
              validationMessage: state.siteValidationMessage,
            ),
            const ObservationCreateUpdateFormItemView(
              label: 'Response',
              content: ResponseTextField(),
            ),
            ObservationCreateUpdateFormItemView(
              label: 'Priority Level (*)',
              content: const PriorityLevelSelectField(),
              validationMessage: state.priorityLevelValidationMessage,
            ),
            ObservationCreateUpdateFormItemView(
              label: 'Observation Type (*)',
              content: const ObservationTypeSelectField(),
              validationMessage: state.observationTypeValidationMessage,
            ),
            ObservationCreateUpdateFormItemView(
              label: 'Company (*)',
              content: const CompanySelectField(),
              validationMessage: state.companyValidationMessage,
            ),
            ObservationCreateUpdateFormItemView(
              label: 'Project (*)',
              content: const ProjectSelectField(),
              validationMessage: state.projectValidationMessage,
            ),
            const ObservationCreateUpdateFormItemView(
              label: 'Upload Images or documents',
              content: ObservationFilePicker(),
            ),
          ],
        );
      },
    );
  }
}

class ObservationCreateUpdateFormItemView extends StatelessWidget {
  final String label;
  final Widget content;
  final String validationMessage;
  const ObservationCreateUpdateFormItemView({
    super.key,
    required this.label,
    required this.content,
    this.validationMessage = '',
  });

  @override
  Widget build(BuildContext context) {
    return CustomBottomBorderContainer(
      padding: inset20,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Text(
            '$label:',
            style: textNormal12,
          ),
          spacery10,
          content,
          if (validationMessage.isNotEmpty) spacery5,
          if (validationMessage.isNotEmpty)
            Text(validationMessage,
                style: textNormal12.copyWith(color: Colors.red))
        ],
      ),
    );
  }
}
