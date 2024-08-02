import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:maps_nagari/app/widgets/color_widget.dart';
import 'package:maps_nagari/app/widgets/default_dialog_widget.dart';

class WarningWidget {
  void dialog(String text) {
    DefaultDialogWidget().getDefaultDialogWithoutButton(
        Get.context,
        true,
        'Alert',
        Text(
          text,
          style: GoogleFonts.poppins(
            fontSize: 15.0,
            fontWeight: FontWeight.w500,
            color: HexColor(ColorWidget().red),
          ),
        ),
      );
  }
}