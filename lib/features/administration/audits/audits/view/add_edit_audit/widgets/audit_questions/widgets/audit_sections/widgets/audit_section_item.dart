import '/common_libraries.dart';

class AuditSectionItemView extends StatefulWidget {
  final bool active;
  final bool disabled;
  final AuditSection auditSection;
  const AuditSectionItemView({
    super.key,
    required this.active,
    required this.auditSection,
    this.disabled = false,
  });

  @override
  State<AuditSectionItemView> createState() => _AuditSectionItemViewState();
}

class _AuditSectionItemViewState extends State<AuditSectionItemView> {
  bool _hover = false;

  Color _getColor() {
    if (_hover) {
      return const Color(0xfff7fdf1);
    } else if (!widget.auditSection.isIncluded) {
      return const Color(0xfff7f2f2);
    } else if (widget.active) {
      return const Color(0xffecfadc);
    }
    return Colors.transparent;
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => context.read<AuditQuestionsBloc>().add(
          AuditQuestionsSelectedAuditSectionChanged(
              auditSection: widget.auditSection)),
      onHover: (value) => setState(() => _hover = value),
      child: CustomBottomBorderContainer(
        padding: insetx10,
        backgroundColor: _getColor(),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: Padding(
                padding: insetx20y10,
                child: Text(
                  widget.auditSection.name,
                  style: textNormal14.copyWith(color: primaryColor),
                ),
              ),
            ),
            if (widget.auditSection.isNew) spacerx10,
            if (widget.auditSection.isNew)
              CustomBadge(
                label: 'NEW',
                color: lightBlue,
              )
          ],
        ),
      ),
    );
  }
}
