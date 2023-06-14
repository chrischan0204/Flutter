import '/common_libraries.dart';

class ResponseScaleSelectFieldView extends StatefulWidget {
  const ResponseScaleSelectFieldView({
    super.key,
  });

  @override
  State<ResponseScaleSelectFieldView> createState() =>
      _ResponseScaleSelectFieldViewState();
}

class _ResponseScaleSelectFieldViewState
    extends State<ResponseScaleSelectFieldView> {
  String? selectedValue;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 20),
      child: BlocConsumer<TemplateDesignerBloc, TemplateDesignerState>(
        listener: (context, state) => setState(() => selectedValue = null),
        listenWhen: (previous, current) => previous.level != current.level,
        builder: (context, state) {
          Map<String, ResponseScale> items = {};

          items.addEntries(
              state.responseScaleList.map((e) => MapEntry(e.name, e)));
          return CustomSingleSelect(
            hint: 'Select response scale',
            selectedValue: selectedValue,
            items: items,
            onChanged: (value) {
              setState(() => selectedValue = value.key);
              context.read<TemplateDesignerBloc>().add(
                    TemplateDesignerResponseScaleItemListLoaded(
                      responseScaleId: (value.value as ResponseScale).id,
                    ),
                  );
            },
          );
        },
      ),
    );
  }
}
