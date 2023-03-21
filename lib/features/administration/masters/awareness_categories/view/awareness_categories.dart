import 'package:flutter/material.dart';
import 'package:safety_eta/features/administration/masters/masters_widgets/masters_template/widgets/crud_view/widgets/custom_textfield.dart';

import '../../masters_widgets/masters_template/widgets/crud_view/widgets/crud_item.dart';
import '../../masters_widgets/widgets.dart';
import '/data/bloc/bloc.dart';

class AwarenessCategories extends StatefulWidget {
  const AwarenessCategories({super.key});

  @override
  State<AwarenessCategories> createState() => _AwarenessCategoriesState();
}

class _AwarenessCategoriesState extends State<AwarenessCategories> {
  @override
  void initState() {
    super.initState();
    context.read<AwarenessCategoriesBloc>().add(
          AwarenessCategoriesRetrieved(),
        );
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AwarenessCategoriesBloc, AwarenessCategoriesState>(
      builder: (context, state) {
        return MastersTemplate(
          description:
              'List of defined awareness categories. These will show only while assessing an observation. Types can be added or current ones edited from this screen.',
          entities: state.awarenessCategories,
          title: 'Awareness Categories',
          label: 'awareness category',
          note:
              'This awareness category is in use on 41 assessments. An awareness category can be removed from future use by deactivating. It will preserve all past data as is.',
          addEntity: () {},
          editEntity: () {},
          deleteEntity: () {},
          onRowClick: (value) {},
          onActiveChanged: (value) {},
          crudItems: [
            // CrudItem(
            //   label: 'Awareness Group (*)',
            //   content: CustomSingleSelect(
            //     items: state.awarenessGroups,
            //     hint: 'Select Awareness Group',
            //     onChanged: (value) {},
            //   ),
            // ),
            CrudItem(
              label: 'Awareness Group (*)',
              content: CustomTextField(
                hintText: 'e.g. Signage',
                onChanged: (value) {},
              ),
            ),
          ],
        );
      },
    );
  }
}
