import 'package:flutter/material.dart';
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
        return MastersListTemplate(
          description:
              'List of defined awareness categories. These will show only while assessing an observation. Types can be added or current ones edited from this screen.',
          entities: state.awarenessCategories,
          title: 'Awareness Categories',
          label: 'awareness category',
          note:
              'This awareness category is in use on 41 assessments. An awareness category can be removed from future use by deactivating. It will preserve all past data as is.',
          onRowClick: (value) {},
        );
      },
    );
  }
}
