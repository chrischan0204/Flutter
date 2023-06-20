import '/common_libraries.dart';
import 'widgets/widgets.dart';

class AddEditAuditFormView extends StatelessWidget {
  const AddEditAuditFormView({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: const [
        AuditNameTextField(),
        AuditDatePicker(),
        SiteSelectField(),
        TemplateSelectField(),
        CompaniesTextField(),
        AuditTimePicker(),
        ProjectSelectField(),
        AreaTextField(),
        InspectorsTextField()
      ],
    );
  }
}
