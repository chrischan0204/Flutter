import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';
import 'package:strings/strings.dart';

import '/global_widgets/global_widget.dart';
import '/constants/color.dart';

class AddEditMasterTemplate extends StatefulWidget {
  final String label;
  const AddEditMasterTemplate({
    super.key,
    required this.label,
  });

  @override
  State<AddEditMasterTemplate> createState() => _MyWidgetState();
}

class _MyWidgetState extends State<AddEditMasterTemplate> {
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
                  Text(
                    'New ${camelize(widget.label)}',
                    style: TextStyle(
                      color: darkTeal,
                      fontSize: 18,
                      fontWeight: FontWeight.w600,
                      fontFamily: 'OpenSans',
                    ),
                  ),
                  const SizedBox(
                    width: 15,
                  ),
                  CustomButton(
                    backgroundColor: const Color(0xff0c83ff),
                    hoverBackgroundColor: const Color(0xff0b76e6),
                    iconData: PhosphorIcons.listNumbers,
                    text: '${camelize(widget.label)} List',
                    onClick: () {
                      String location = GoRouter.of(context).location;
                      location = location.replaceAll('new', '');
                      GoRouter.of(context).go(location);
                    },
                  )
                ],
              ),
            ),
            const CustomDivider(),
            Padding(
              padding: const EdgeInsets.only(
                top: 50,
              ),
            )
          ],
        ),
      ),
    );
  }
}
