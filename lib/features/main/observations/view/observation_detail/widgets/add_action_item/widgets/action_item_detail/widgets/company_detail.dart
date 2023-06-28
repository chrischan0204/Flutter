import '/common_libraries.dart';
import '../../../../form_item.dart';

class CompanyDetailView extends StatelessWidget {
  const CompanyDetailView({super.key});

  @override
  Widget build(BuildContext context) {
    return ObservationDetailFormItemView(
      label: 'Company',
      content: BlocBuilder<AddActionItemBloc, AddActionItemState>(
        builder: (context, state) {
          return Text(
            state.actionItem!.assigneeName,
            style: textNormal14,
          );
        },
      ),
    );
  }
}
