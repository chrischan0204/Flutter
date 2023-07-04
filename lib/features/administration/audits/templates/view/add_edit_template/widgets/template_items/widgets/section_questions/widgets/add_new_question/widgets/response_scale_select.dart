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
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 20),
      child: BlocConsumer<TemplateDesignerBloc, TemplateDesignerState>(
        listener: (context, state) {},
        listenWhen: (previous, current) => previous.level != current.level,
        builder: (context, state) {
          Map<String, ResponseScale> items = {};

          items.addEntries(
              state.responseScaleList.map((e) => MapEntry(e.name, e)));
          return CustomSingleSelect(
            hint: 'Select response scale',
            key: ValueKey(
                state.currentTemplateSectionItemByLevel(state.level)?.id),
            selectedValue: state.currentResponseScaleItem?.name,
            items: items,
            onChanged: (value) {
              context.read<TemplateDesignerBloc>().add(
                  TemplateDesignerResponseScaleSelected(
                      responseScaleId: (value.value as ResponseScale).id));

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
