import '/common_libraries.dart';

class SummaryView extends StatefulWidget {
  const SummaryView({super.key});

  @override
  State<SummaryView> createState() => _SummaryViewState();
}

class _SummaryViewState extends State<SummaryView> {
  bool _hover = false;

  void _getSummary() => context
      .read<TemplateDesignerBloc>()
      .add(const TemplateDesignerTemplateSectionSelected());

  @override
  Widget build(BuildContext context) {
    return InkWell(
      hoverColor: Colors.transparent,
      onTap: () {
        CustomAlert.checkFormDirty(_getSummary, context);
      },
      onHover: (value) => setState(() => _hover = value),
      child: Container(
        color: _hover ? const Color(0xfff7fdf1) : const Color(0xffecfadc),
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 25),
        child: Text(
          'Summary View',
          style: TextStyle(
            color: primaryColor,
            fontSize: 14,
          ),
        ),
      ),
    );
  }
}
