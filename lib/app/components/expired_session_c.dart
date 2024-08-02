import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:maps_nagari/app/widgets/color_widget.dart';

import '../modules/login/controllers/auth_controller.dart';
import '../widgets/default_dialog_widget.dart';
import '../widgets/text_button_widget.dart';

class ExpiredSessionC {
  void dialog() {
    DefaultDialogWidget().getDefaultDialogWithoutButton(
      Get.context,
      false,
      'Alert',
      Column(
        children: [
          Text(
            'Your session has expired, please log in again!',
            style: GoogleFonts.poppins(
              fontSize: 15.0,
              fontWeight: FontWeight.w600,
              color: HexColor(ColorWidget().black),
            ),
          ),
          const SizedBox(
            height: 10.0,
          ),
          SizedBox(
            height: 40.0,
            child: TextButtonWidget(
              onPress: () {
                AuthController().logout();
              },
              color: HexColor(ColorWidget().red),
              child: Text(
                'Sign Out',
                style: GoogleFonts.poppins(
                  fontSize: 15.0,
                  fontWeight: FontWeight.w600,
                  color: HexColor(ColorWidget().white),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}