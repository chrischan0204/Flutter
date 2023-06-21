import '/common_libraries.dart';

class AreaTextField extends StatelessWidget {
  const AreaTextField({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AddEditAuditBloc, AddEditAuditState>(
      builder: (context, state) {
        return CustomTextField(
          key: ValueKey(state.loadedAudit?.id),
          initialValue: state.area,
          hintText: 'Area',
          onChanged: (area) {
            context
                .read<AddEditAuditBloc>()
                .add(AddEditAuditAreaChanged(area: area));
          },
        );
      },
    );
  }
}
