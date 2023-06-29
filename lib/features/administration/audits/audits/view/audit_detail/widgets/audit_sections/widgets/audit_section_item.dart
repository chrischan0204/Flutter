import '/common_libraries.dart';

class AuditSectionItemView extends StatefulWidget {
  final bool active;
  final AuditSectionAndQuestion auditSection;
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

  Color _getBackgroundColor() {
    if (_hover) {
      return const Color(0xfff7fdf1);
    } else if (widget.active) {
      return const Color(0xffecfadc);
    }
    return Colors.transparent;
  }

  Color _getBadgeColor(String status) {
    switch (status) {
      case 'Not Started':
        return warnColor;
      case 'Partial':
        return Colors.blueGrey;
      case 'In Progress':
        return primaryColor;
      case 'Done':
        return successColor;
    }
    return successColor;
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => context.read<AuditDetailBloc>().add(
          AuditDetailSelectedAuditSectionChanged(
              auditSection: widget.auditSection)),
      onHover: (value) => setState(() => _hover = value),
      child: Container(
        decoration: BoxDecoration(
          color: _getBackgroundColor(),
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
                    widget.auditSection.auditSectionName,
                    style: textNormal14.copyWith(color: primaryColor),
                  ),
                  CustomBadge(
                    color: _getBadgeColor(widget.auditSection.sectionStatus),
                    label: widget.auditSection.sectionStatus,
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
