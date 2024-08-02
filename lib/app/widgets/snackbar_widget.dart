import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:maps_nagari/app/widgets/color_widget.dart';

class SnackbarWidget {
  void getSnackbar(String title, String message, String type) {
    Get.snackbar(
      '${title}',
      '',
      duration: const Duration(milliseconds: 2500),
      messageText: Text(
        '${message}',
        style: GoogleFonts.poppins(
          fontWeight: FontWeight.w400,
          color: HexColor(ColorWidget().white),
        ),
      ),
      colorText: HexColor(ColorWidget().white),
      backgroundColor: type == 'success'
          ? HexColor(ColorWidget().green)
          : HexColor(ColorWidget().red),
    );
  }
}
