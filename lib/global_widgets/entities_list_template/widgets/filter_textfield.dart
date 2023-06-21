import '/common_libraries.dart';

class FilterTextField extends StatefulWidget {
  final String hintText;
  final String label;
  final VoidCallback applyFilter;
  final VoidCallback clearFilter;
  final ValueChanged<String> onChange;
  final bool canFilter;

  const FilterTextField({
    super.key,
    required this.hintText,
    required this.label,
    required this.applyFilter,
    required this.clearFilter,
    required this.onChange,
    this.canFilter = false,
  });

  @override
  State<FilterTextField> createState() => _FilterTextFieldState();
}

class _FilterTextFieldState extends State<FilterTextField> {
  TextEditingController filterController = TextEditingController();
  late FocusNode focusNode;
  String hintText = '';

  @override
  void initState() {
    hintText = widget.hintText;
    focusNode = FocusNode();
    super.initState();
  }

  @override
  void dispose() {
    focusNode.dispose();
    filterController.dispose();
    super.dispose();
  }

  void onSubmit() {
    if (filterController.text.trim().length > 1 || widget.canFilter) {
      setState(() {
        hintText =
            "Showing ${widget.label} matching '${filterController.text}' below.";
      });
      filterController.clear();
      widget.applyFilter();
    } else {
      CustomNotification(
        context: context,
        notifyType: NotifyType.info,
        content: 'You should type at least two letters.',
      ).showNotification();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: CustomTextField(
            hintText: hintText,
            focusNode: focusNode,
            onChanged: (val) {
              widget.onChange(val);
            },
            onSubmitted: (value) {
              onSubmit();
              focusNode.requestFocus();
            },
            controller: filterController,
            suffixIconData: PhosphorIcons.regular.funnel,
            suffixIconColor: const Color(0xff0c81ff),
            onSuffixIconClick: () {
              onSubmit();
            },
          ),
        ),
        spacerx12,
        InkWell(
          onTap: () {
            widget.clearFilter();
            filterController.clear();
            setState(() {
              hintText = widget.hintText;
            });
          },
          child: Icon(
            PhosphorIcons.regular.arrowCounterClockwise,
            color: Colors.red,
          ),
        )
      ],
    );
  }
}
