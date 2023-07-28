import '/common_libraries.dart';
import 'widgets/widgets.dart';

class ActionItemDetailViewForObservation extends StatelessWidget {
  const ActionItemDetailViewForObservation({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AddActionItemBloc, AddActionItemState>(
      builder: (context, state) {
        if (state.actionItem != null) {
          return const Column(
            children: [
              TaskDetailView(),
              DueByDetailView(),
              AssigneeDetailView(),
              CategoryDetailView(),
              CompanyDetailView(),
              ProjectDetailView(),
              LocationDetailView(),
              NotesDetailView(),
            ],
          );
        }
        return Container();
      },
    );
  }
}
