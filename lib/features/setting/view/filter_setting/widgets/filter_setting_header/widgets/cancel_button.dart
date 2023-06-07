import 'package:flutter/material.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';

class CancelButton extends StatelessWidget {
  final VoidCallback onFilterOptionClosed;
  const CancelButton({
    super.key,
    required this.onFilterOptionClosed,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () => onFilterOptionClosed(),
      style: ElevatedButton.styleFrom(
          backgroundColor: Colors.grey,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(3))),
      child: Row(
        children: [
          Icon(
            PhosphorIcons.regular.floppyDiskBack,
            color: Colors.white,
            size: 18,
          ),
          const SizedBox(width: 5),
          const Text(
            'Cancel',
            style: TextStyle(color: Colors.white),
          ),
        ],
      ),
    );
  }
}
