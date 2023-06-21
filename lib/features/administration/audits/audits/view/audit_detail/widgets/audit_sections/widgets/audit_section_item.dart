import '/common_libraries.dart';

class AuditSectionItemView extends StatefulWidget {
  final bool active;
  final AuditSection auditSection;
  const AuditSectionItemView({
    super.key,
    required this.active,
    required this.auditSection,
  });

  @override
  State<AuditSectionItemView> createState() => _AuditSectionItemViewState();
}

class _AuditSectionItemViewState extends State<AuditSectionItemView> {
  bool _hover = false;

  @override
  Widget build(BuildContext context) {
    Color _getColor() {
      if (_hover) {
        return const Color(0xfff7fdf1);
      } else if (widget.active) {
        return const Color(0xffecfadc);
      }
      return Colors.transparent;
    }

    return InkWell(
      onTap: () => context.read<AuditDetailBloc>().add(
          AuditDetailSelectedAuditSectionChanged(
              auditSection: widget.auditSection)),
      onHover: (value) => setState(() => _hover = value),
      child: Container(
        decoration: BoxDecoration(
          color: _getColor(),
          border: Border(bottom: BorderSide(color: grey)),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Padding(
              padding: insetx20y10,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    widget.auditSection.name,
                    style: textNormal14.copyWith(color: primaryColor),
                  ),
                  CustomBadge(
                    color: widget.auditSection.status.toColor(),
                    label: widget.auditSection.status.toString(),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
