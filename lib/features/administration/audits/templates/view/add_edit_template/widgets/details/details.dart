import '/common_libraries.dart';

import 'widgets/widgets.dart';

class AddEditTemplateDetailsView extends StatefulWidget {
  final String? templateId;
  const AddEditTemplateDetailsView({
    super.key,
    required this.templateId,
  });

  @override
  State<AddEditTemplateDetailsView> createState() =>
      _AddEditTemplateDetailsViewState();
}

class _AddEditTemplateDetailsViewState
    extends State<AddEditTemplateDetailsView> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return const Column(
      children: [
        TemplateDescriptionField(),
        RevisionDatePicker(),
      ],
    );
  }
}
