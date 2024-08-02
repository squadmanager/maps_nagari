import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:maps_nagari/app/widgets/color_widget.dart';
import 'package:maps_nagari/app/widgets/text_button_widget.dart';

class DefaultDialogWidget {
  void getDefaultDialog(
    BuildContext context,
    String title,
    Widget widgetContent,
    VoidCallback pressConfirm,
    String textConfirm,
    Color colorBackgroundConfirm,
    Color textColorConfirm,
    VoidCallback pressCancel,
    String textCancel,
  ) {
    Get.defaultDialog(
      title: '${title}',
      titleStyle: GoogleFonts.poppins(
        color: HexColor(ColorWidget().black),
        fontWeight: FontWeight.w600,
      ),
      radius: 10.0,
      content: SizedBox(
        width: MediaQuery.of(context).size.width,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: widgetContent,
        ),
      ),
      confirm: TextButtonWidget(
        color: colorBackgroundConfirm,
        onPress: pressConfirm,
        child: Text(
          "${textConfirm}",
          style: GoogleFonts.poppins(
            textStyle: TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.w600,
              color: textColorConfirm,
            ),
          ),
        ),
      ),
      cancel: TextButtonWidget(
        onPress: pressCancel,
        color: HexColor(ColorWidget().grey),
        child: Text(
          "${textCancel}",
          style: GoogleFonts.poppins(
            textStyle: TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.w600,
              color: HexColor(ColorWidget().white),
            ),
          ),
        ),
      ),
    );
  }

  void getDefaultDialogWithoutButton(
    context,
    bool barrierDismissible,
    String title,
    Widget widgetContent,
  ) {
    Get.defaultDialog(
      barrierDismissible: barrierDismissible,
      title: '${title}',
      titleStyle: GoogleFonts.poppins(
        color: HexColor(ColorWidget().black),
        fontWeight: FontWeight.w600,
      ),
      radius: 10.0,
      content: SizedBox(
        width: MediaQuery.of(context).size.width,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: widgetContent,
        ),
      ),
    );
  }
}
