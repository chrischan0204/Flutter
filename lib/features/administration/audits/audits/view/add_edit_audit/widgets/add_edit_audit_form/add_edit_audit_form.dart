import '/common_libraries.dart';
import 'widgets/widgets.dart';

class AddEditAuditFormView extends StatelessWidget {
  const AddEditAuditFormView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AddEditAuditBloc, AddEditAuditState>(
      builder: (context, state) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          mainAxisSize: MainAxisSize.min,
          children: [
            FormItemVertical(
              leftLabel: 'Name (*)',
              leftChild: const AuditNameTextField(),
              leftValidationMessage: state.auditNameValidationMessage,
              rightLabel: 'Date/Time (*)',
              rightChild: const AuditDatePicker(),
              rightValidationMessage: state.auditDateValidationMessage,
            ),
            FormItemVertical(
              leftLabel: 'Site (*)',
              leftChild: const SiteSelectField(),
              leftValidationMessage: state.siteValidationMessage,
              rightLabel: 'Project',
              rightChild: const ProjectSelectField(),
            ),
            FormItemVertical(
              leftLabel: 'Template (*)',
              leftChild: const TemplateSelectField(),
              leftValidationMessage: state.templateValidationMessage,
              rightLabel: 'Area',
              rightChild: const AreaTextField(),
            ),
            const FormItemVertical(
              leftLabel: 'Companies',
              leftChild: CompaniesTextField(),
              rightLabel: 'Inspectors',
              rightChild: InspectorsTextField(),
            ),
          ],
        );
      },
    );
  }
}
