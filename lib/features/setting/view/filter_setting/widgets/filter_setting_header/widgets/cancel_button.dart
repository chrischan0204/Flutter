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
        children: const [
          Icon(
            PhosphorIcons.floppyDiskBack,
            color: Colors.white,
            size: 18,
          ),
          SizedBox(width: 5),
          Text(
            'Cancel',
            style: TextStyle(color: Colors.white),
          ),
        ],
      ),
    );
  }
}
