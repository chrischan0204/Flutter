import 'package:flutter/material.dart';
import 'package:safety_eta/features/administration/masters/masters_widgets/masters_template/widgets/crud_view/widgets/custom_color_picker.dart';
import 'package:safety_eta/features/administration/masters/masters_widgets/masters_template/widgets/crud_view/widgets/widgets.dart';
import '../../masters_widgets/masters_template/masters_template.dart';
import '/data/bloc/bloc.dart';

class PriorityLevels extends StatefulWidget {
  const PriorityLevels({super.key});

  @override
  State<PriorityLevels> createState() => _PriorityLevelsState();
}

class _PriorityLevelsState extends State<PriorityLevels> {
  @override
  void initState() {
    super.initState();
    context.read<PriorityLevelsBloc>().add(PriorityLevelsRetrieved());
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<PriorityLevelsBloc, PriorityLevelsState>(
      builder: (context, state) {
        return MastersTemplate(
          description:
              'List of defined Priority Levels. Types can be added or current ones edited from this screen.',
          entities: state.priorityLevels,
          title: 'Priority Levels',
          label: 'priority level',
          note:
              'This Priority Level is in use on 21 observations. An priority level can be removed from future use by deactivating. It will preserve all past data as is.',
          addEntity: () async {},
          editEntity: () async {},
          deleteEntity: () async {},
          onRowClick: (value) {},
          onActiveChanged: (value) {},
          crudItems: [
            CrudItem(
              label: 'Priority Level (*)',
              content: CustomTextField(
                hintText: 'e.g. Medium-low',
                onChanged: (value) {},
              ),
            ),
            // CrudItem(
            //   label: 'Priority Type (*)',
            //   content: CustomSingleSelect(
            //     items: [
            //       'Corrective',
            //       'Positive',
            //     ],
            //     hint: 'Select Type',
            //     onChanged: (value) {},
            //   ),
            // ),
            CrudItem(
              label: 'Color (*)',
              content: CustomColorPicker(
                color: Colors.blue,
              ),
            ),
          ],
        );
      },
    );
  }
}
