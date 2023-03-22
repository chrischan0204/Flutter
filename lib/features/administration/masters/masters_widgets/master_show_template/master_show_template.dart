import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';
import 'package:safety_eta/constants/color.dart';
import 'package:safety_eta/global_widgets/global_widget.dart';
import 'package:strings/strings.dart';

class MasterShowTemplate extends StatefulWidget {
  final String title;
  final String label;
  final VoidCallback onDelete;
  final Widget child;

  const MasterShowTemplate({
    super.key,
    required this.title,
    required this.label,
    required this.onDelete,
    required this.child,
  });

  @override
  State<MasterShowTemplate> createState() => _MasterShowTemplateState();
}

class _MasterShowTemplateState extends State<MasterShowTemplate> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10),
      child: SizedBox(
        width: double.infinity,
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 20,
                vertical: 15,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Flexible(
                    flex: 55,
                    child: Text(
                      widget.title,
                      style: TextStyle(
                        color: darkTeal,
                        fontSize: 18,
                        fontWeight: FontWeight.w600,
                        fontFamily: 'OpenSans',
                      ),
                    ),
                  ),
                  const SizedBox(
                    width: 15,
                  ),
                  Flexible(
                    flex: 45,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        CustomButton(
                          backgroundColor: const Color(0xff0c83ff),
                          hoverBackgroundColor: const Color(0xff0b76e6),
                          iconData: PhosphorIcons.listNumbers,
                          text: '${camelize(widget.label)} List',
                          onClick: () {
                            String location = GoRouter.of(context).location;
                            location = location.replaceRange(
                                location.indexOf('show'), null, '');
                            GoRouter.of(context).go(location);
                          },
                        ),
                        const SizedBox(
                          width: 15,
                        ),
                        CustomButton(
                          backgroundColor: const Color(0xfff58646),
                          hoverBackgroundColor: const Color(0xffdd793f),
                          iconData: PhosphorIcons.gear,
                          text: 'Edit ${camelize(widget.label)}',
                          onClick: () => GoRouter.of(context).go(
                            GoRouter.of(context)
                                .location
                                .replaceAll('show', 'edit'),
                          ),
                        ),
                        const SizedBox(
                          width: 15,
                        ),
                        CustomButton(
                          backgroundColor: const Color(0xffef4444),
                          hoverBackgroundColor: const Color(0xffd73d3d),
                          iconData: PhosphorIcons.gear,
                          text: '${camelize(widget.label)} List',
                          onClick: () => widget.onDelete(),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            const CustomDivider(),
            Padding(
              padding: const EdgeInsets.only(
                top: 50,
              ),
              child: widget.child,
            )
          ],
        ),
      ),
    );
  }
}
