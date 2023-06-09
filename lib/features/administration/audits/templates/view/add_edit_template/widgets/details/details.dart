import 'package:flutter/material.dart';

import 'widgets/widgets.dart';

class AddEditTemplateDetailsView extends StatelessWidget {
  const AddEditTemplateDetailsView({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: const [
        TemplateDescriptionField(),
        RevisionDatePicker(),
        // UsedInCheckBoxes()
      ],
    );
  }
}
