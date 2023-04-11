import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
export 'package:awesome_dialog/awesome_dialog.dart';

class CustomAlert {
  final BuildContext context;
  final String? title;
  final double width;
  final String description;
  final String btnOkText;
  final VoidCallback? btnOkOnPress;
  final VoidCallback? btnCancelOnPress;
  final DialogType dialogType;
  CustomAlert({
    required this.context,
    this.title,
    required this.width,
    required this.description,
    required this.btnOkText,
    this.btnOkOnPress,
    this.btnCancelOnPress,
    required this.dialogType,
  });
  void show() {
    AwesomeDialog(
      context: context,
      width: width,
      dialogType: dialogType,
      headerAnimationLoop: false,
      animType: AnimType.bottomSlide,
      title: title,
      dialogBorderRadius: BorderRadius.circular(5),
      desc: description,
      buttonsTextStyle: const TextStyle(color: Colors.white),
      showCloseIcon: true,
      btnCancelOnPress: btnCancelOnPress,
      btnOkOnPress: () => btnOkOnPress!(),
      btnOkText: btnOkText,
      buttonsBorderRadius: BorderRadius.circular(3),
      padding: const EdgeInsets.all(10),
    ).show();
  }
}
