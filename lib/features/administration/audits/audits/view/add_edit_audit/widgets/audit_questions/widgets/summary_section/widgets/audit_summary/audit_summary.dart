import '/common_libraries.dart';
import 'widgets/widgets.dart';

class AuditSummaryView extends StatefulWidget {
  final String auditId;
  const AuditSummaryView({
    super.key,
    required this.auditId,
  });

  @override
  State<AuditSummaryView> createState() => _AuditSummaryViewState();
}

class _AuditSummaryViewState extends State<AuditSummaryView> {
  @override
  void initState() {
    context
        .read<AuditDetailBloc>()
        .add(AuditDetailLoaded(auditId: widget.auditId));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return const Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(child: AuditSummary1()),
        Expanded(child: AuditSummary2())
      ],
    );
  }
}
