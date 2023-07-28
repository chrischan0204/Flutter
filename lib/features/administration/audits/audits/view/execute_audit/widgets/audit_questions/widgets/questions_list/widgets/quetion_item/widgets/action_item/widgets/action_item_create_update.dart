import '/common_libraries.dart';

class SiteSelectField extends StatelessWidget {
  const SiteSelectField({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ExecuteAuditBloc, ExecuteAuditState>(
      builder: (context, auditState) {
        Map<String, Site> items = {}..addEntries(
            auditState.siteList.map((site) => MapEntry(site.name ?? '', site)));
        return BlocBuilder<ExecuteAuditActionItemBloc,
            ExecuteAuditActionItemState>(
          builder: (context, state) {
            return CustomSingleSelect(
              items: items,
              hint: 'Select Site',
              selectedValue:
                  auditState.assigneeList.isEmpty ? null : state.site?.name,
              onChanged: (site) {
                context.read<ExecuteAuditActionItemBloc>()
                  ..add(ExecuteAuditActionItemSiteChanged(site: site.value))
                  ..add(ExecuteAuditActionItemProjectListLoaded(
                      siteId: site.value.id))
                  ..add(ExecuteAuditActionItemCompanyListLoaded(
                      siteId: site.value.id));
              },
            );
          },
        );
      },
    );
  }
}

class DueByDatePicker extends StatelessWidget {
  const DueByDatePicker({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ExecuteAuditActionItemBloc, ExecuteAuditActionItemState>(
      builder: (context, state) {
        return CustomDateTimePicker(
          key: ValueKey(state.auditActionItem?.id),
          initialValue: state.dueBy?.toString(),
          dateTimePickerType: DateTimePickerType.date,
          onChange: (dueBy) {
            context
                .read<ExecuteAuditActionItemBloc>()
                .add(ExecuteAuditActionItemDueByChanged(dueBy: dueBy));
          },
        );
      },
    );
  }
}

class AssigneeSelectField extends StatelessWidget {
  const AssigneeSelectField({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ExecuteAuditBloc, ExecuteAuditState>(
      builder: (context, auditState) {
        Map<String, User> items = {}..addEntries(auditState.assigneeList
            .map((assignee) => MapEntry(assignee.name ?? '', assignee)));
        return BlocBuilder<ExecuteAuditActionItemBloc,
            ExecuteAuditActionItemState>(
          builder: (context, state) {
            return CustomSingleSelect(
              items: items,
              hint: 'Select Assignee',
              selectedValue:
                  auditState.assigneeList.isEmpty ? null : state.assignee?.name,
              onChanged: (assignee) {
                context.read<ExecuteAuditActionItemBloc>().add(
                    ExecuteAuditActionItemAssigneeChanged(
                        assignee: assignee.value));
              },
            );
          },
        );
      },
    );
  }
}

class CategorySelectField extends StatelessWidget {
  const CategorySelectField({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ExecuteAuditBloc, ExecuteAuditState>(
      builder: (context, auditState) {
        Map<String, AwarenessCategory> items = {}..addEntries(auditState
            .categoryList
            .map((category) => MapEntry(category.name ?? '', category)));
        return BlocBuilder<ExecuteAuditActionItemBloc,
            ExecuteAuditActionItemState>(
          builder: (context, state) {
            return CustomSingleSelect(
              items: items,
              hint: 'Select Category',
              selectedValue:
                  auditState.assigneeList.isEmpty ? null : state.category?.name,
              onChanged: (category) {
                context.read<ExecuteAuditActionItemBloc>().add(
                    ExecuteAuditActionItemCategoryChanged(
                        category: category.value));
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
    return BlocBuilder<ExecuteAuditActionItemBloc, ExecuteAuditActionItemState>(
      builder: (context, state) {
        Map<String, Project> items = {}..addEntries(state.projectList
            .map((project) => MapEntry(project.name ?? '', project)));
        return CustomSingleSelect(
          items: items,
          hint: 'Select Project',
          selectedValue: state.projectList.isEmpty ? null : state.project?.name,
          onChanged: (project) {
            context.read<ExecuteAuditActionItemBloc>().add(
                ExecuteAuditActionItemProjectChanged(project: project.value));
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
    return BlocBuilder<ExecuteAuditActionItemBloc, ExecuteAuditActionItemState>(
      builder: (context, state) {
        Map<String, Company> items = {}..addEntries(state.companyList
            .map((company) => MapEntry(company.name ?? '', company)));
        return CustomSingleSelect(
          items: items,
          hint: 'Select Company',
          selectedValue: state.companyList.isEmpty ? null : state.company?.name,
          onChanged: (company) {
            context.read<ExecuteAuditActionItemBloc>().add(
                ExecuteAuditActionItemCompanyChanged(company: company.value));
          },
        );
      },
    );
  }
}

class ActionItemTextField extends StatelessWidget {
  const ActionItemTextField({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ExecuteAuditActionItemBloc, ExecuteAuditActionItemState>(
      builder: (context, state) {
        return CustomTextField(
          key: ValueKey(state.auditActionItem?.id),
          initialValue: state.name,
          hintText: 'Action item',
          onChanged: (actionItem) {
            context
                .read<ExecuteAuditActionItemBloc>()
                .add(ExecuteAuditActionItemNameChanged(actionItem: actionItem));
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
    return BlocBuilder<ExecuteAuditActionItemBloc, ExecuteAuditActionItemState>(
      builder: (context, state) {
        return CustomTextField(
          key: ValueKey(state.auditActionItem?.id),
          initialValue: state.area,
          hintText: 'Area information',
          onChanged: (area) {
            context
                .read<ExecuteAuditActionItemBloc>()
                .add(ExecuteAuditActionItemAreaChanged(area: area));
          },
        );
      },
    );
  }
}

class NotesTextField extends StatelessWidget {
  const NotesTextField({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ExecuteAuditActionItemBloc, ExecuteAuditActionItemState>(
      builder: (context, state) {
        return CustomTextField(
          key: ValueKey(state.auditActionItem?.id),
          initialValue: state.notes,
          hintText: 'Notes about action item',
          minLines: 3,
          height: null,
          maxLines: 100,
          contentPadding: const EdgeInsets.symmetric(
            vertical: 12,
            horizontal: 10,
          ),
          onChanged: (notes) => context
              .read<ExecuteAuditActionItemBloc>()
              .add(ExecuteAuditActionItemNotesChanged(notes: notes)),
        );
      },
    );
  }
}

class ActionItemFilePicker extends StatelessWidget {
  const ActionItemFilePicker({super.key});

  @override
  Widget build(BuildContext context) {
    return CustomMultiFilePicker(
        onSelect: (fileList) => context
            .read<ExecuteAuditActionItemBloc>()
            .add(ExecuteAuditActionItemFileListChanged(fileList: fileList)));
  }
}

class IsClosedCheckBox extends StatelessWidget {
  const IsClosedCheckBox({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ExecuteAuditActionItemBloc, ExecuteAuditActionItemState>(
      builder: (context, state) {
        return Container(
          alignment: Alignment.centerLeft,
          child: Checkbox(
            value: state.isClosed,
            onChanged: (isClosed) => context
                .read<ExecuteAuditActionItemBloc>()
                .add(ExecuteAuditActionItemIsClosedChanged(isClosed: isClosed!)),
          ),
        );
      },
    );
  }
}

class ActionItemCreateUpdateView extends StatelessWidget {
  const ActionItemCreateUpdateView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ExecuteAuditActionItemBloc, ExecuteAuditActionItemState>(
      builder: (context, state) {
        return Column(
          children: [
            ActionItemCreateUpdateFormItemView(
              label: 'Action required (*)',
              content: const ActionItemTextField(),
              validationMessage: state.nameValidationMessage,
            ),
            ActionItemCreateUpdateFormItemView(
              label: 'Site (*)',
              content: const SiteSelectField(),
              validationMessage: state.siteValidationMessage,
            ),
            ActionItemCreateUpdateFormItemView(
              label: 'Due By (*)',
              content: const DueByDatePicker(),
              validationMessage: state.dueByValidationMessage,
            ),
            ActionItemCreateUpdateFormItemView(
              label: 'Assignee (*)',
              content: const AssigneeSelectField(),
              validationMessage: state.assigneeValidationMessage,
            ),
            const ActionItemCreateUpdateFormItemView(
              label: 'Category',
              content: CategorySelectField(),
            ),
            const ActionItemCreateUpdateFormItemView(
              label: 'Company',
              content: CompanySelectField(),
            ),
            const ActionItemCreateUpdateFormItemView(
              label: 'Project',
              content: ProjectSelectField(),
            ),
            const ActionItemCreateUpdateFormItemView(
              label: 'Area',
              content: AreaTextField(),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                CustomBottomBorderContainer(
                  padding: insetx20y10,
                  child: Text(
                    'Notes:',
                    style: textNormal12,
                  ),
                ),
                CustomBottomBorderContainer(
                  padding: insetx20y10,
                  child: const NotesTextField(),
                ),
              ],
            ),
            const ActionItemCreateUpdateFormItemView(
              label: 'Upload Images or documents',
              content: ActionItemFilePicker(),
            ),
            if (state.auditActionItem != null)
              const ActionItemCreateUpdateFormItemView(
                label: 'Mark As Closed',
                content: IsClosedCheckBox(),
              ),
          ],
        );
      },
    );
  }
}

class ActionItemCreateUpdateFormItemView extends StatelessWidget {
  final String label;
  final Widget content;
  final String validationMessage;
  const ActionItemCreateUpdateFormItemView({
    super.key,
    required this.label,
    required this.content,
    this.validationMessage = '',
  });

  @override
  Widget build(BuildContext context) {
    return CustomBottomBorderContainer(
      padding: insetx20y10,
      child: Row(
        children: [
          Expanded(
            child: Text(
              '$label:',
              style: textNormal12,
            ),
          ),
          Expanded(
            flex: 2,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                content,
                if (validationMessage.isNotEmpty) spacery5,
                if (validationMessage.isNotEmpty)
                  Text(validationMessage,
                      style: textNormal12.copyWith(color: Colors.red))
              ],
            ),
          ),
        ],
      ),
    );
  }
}
