import 'package:flutter/material.dart';
import '../../masters_widgets/masters_template/masters_template.dart';
import '../../masters_widgets/masters_template/widgets/crud_view/widgets/widgets.dart';
import '/data/bloc/bloc.dart';

class ObservationTypes extends StatefulWidget {
  const ObservationTypes({super.key});

  @override
  State<ObservationTypes> createState() => _ObservationTypesState();
}

class _ObservationTypesState extends State<ObservationTypes> {
  @override
  void initState() {
    super.initState();
    context.read<ObservationTypesBloc>().add(ObservationTypesRetrieved());
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ObservationTypesBloc, ObservationTypesState>(
      builder: (context, state) {
        return MastersTemplate(
          description:
              'List of defined observation types. Types can be added or current ones edited from this screen.',
          entities: state.observationTypes,
          title: 'Observation Types',
          label: 'observation type',
          note:
              'This observation type is in use on 173 observations. An observation type can be removed from future use by deactivating. It will preserve all past data as is.',
          addEntity: () async {},
          editEntity: () async {},
          deleteEntity: () async {},
          onRowClick: (value) {},
          onActiveChanged: (value) {},
          crudItems: [
            CrudItem(
              label: 'Observation Type (*)',
              content: CustomTextField(
                hintText: 'e.g. Good Catch',
                onChanged: (value) {},
              ),
            ),
            // CrudItem(
            //   label: 'Severity (*)',
            //   content: CustomSingleSelect(
            //     items: const [
            //       'Good Catch',
            //       'Near Miss',
            //       'Positive',
            //     ],
            //     hint: 'Select Severity',
            //     onChanged: (value) {},
            //   ),
            // ),
            // CrudItem(
            //   label: 'Severity (*)',
            //   content: CustomSingleSelect(
            //     items: const [
            //       'Everywhere',
            //       'Assessment only',
            //     ],
            //     hint: 'Select Visibility',
            //     onChanged: (value) {},
            //   ),
            // ),
          ],
        );
      },
    );
  }
}
