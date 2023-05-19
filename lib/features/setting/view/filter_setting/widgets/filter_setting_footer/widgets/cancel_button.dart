import 'package:flutter/material.dart';

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
      child: const Text(
        'Cancel',
        style: TextStyle(color: Colors.white),
      ),
    );
  }
}
