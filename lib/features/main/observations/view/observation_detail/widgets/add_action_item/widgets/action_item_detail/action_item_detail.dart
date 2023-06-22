import '/common_libraries.dart';
import 'widgets/widgets.dart';

class ActionItemDetailView extends StatelessWidget {
  const ActionItemDetailView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AddActionItemBloc, AddActionItemState>(
      builder: (context, state) {
        if (state.actionItem != null) {
          return Column(
            children: const [
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
