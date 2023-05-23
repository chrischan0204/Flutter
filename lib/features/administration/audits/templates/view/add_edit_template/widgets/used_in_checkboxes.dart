import '/common_libraries.dart';

class UsedInCheckBoxes extends StatefulWidget {
  const UsedInCheckBoxes({super.key});

  @override
  State<UsedInCheckBoxes> createState() => _UsedInCheckBoxesState();
}

class _UsedInCheckBoxesState extends State<UsedInCheckBoxes> {
  late AddEditTemplateBloc addEditTemplateBloc;
  @override
  void initState() {
    addEditTemplateBloc = context.read();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AddEditTemplateBloc, AddEditTemplateState>(
      builder: (context, state) {
        return FormItem(
          label: 'Used in',
          content: Row(
            children: [
              Checkbox(
                value: state.usedInAudit,
                onChanged: (usedInAudit) =>
                    addEditTemplateBloc.add(AddEditTemplateUsedInAudit(
                  usedInAudit: usedInAudit!,
                )),
              ),
              const SizedBox(width: 5),
              const Text('Audits', style: TextStyle(fontSize: 12)),
            ],
          ),
          sideContent: Row(
            children: [
              Checkbox(
                value: state.usedInInspection,
                onChanged: (usedInInspection) =>
                    addEditTemplateBloc.add(AddEditTemplateUsedInInspection(
                  usedInInspection: usedInInspection!,
                )),
              ),
              const SizedBox(width: 5),
              const Text('Inspections', style: TextStyle(fontSize: 12)),
            ],
          ),
        );
      },
    );
  }
}
