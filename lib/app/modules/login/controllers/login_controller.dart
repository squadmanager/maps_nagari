import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:maps_nagari/app/data/providers/auth_provider.dart';
import 'package:maps_nagari/app/routes/app_pages.dart';
import 'package:maps_nagari/app/widgets/color_widget.dart';
import 'package:maps_nagari/app/widgets/default_dialog_widget.dart';
import 'package:maps_nagari/app/widgets/snackbar_widget.dart';

class LoginController extends GetxController {
  final TextEditingController usernameC = TextEditingController();
  final TextEditingController passwordC = TextEditingController();
  final formKey = GlobalKey<FormState>().obs;
  var loading = false.obs;
  var isAuth = false.obs;
  var hiddenPassword = true.obs;

  Future<void> submitLogin(
      String username, String password, form, context) async {
    final isValid = form.currentState.validate();
    if (!isValid) {
      return;
    }

    loading.value = true;
    if (username != '' && password != '') {
      var dataLogin = await AuthProvider().loginStore(username, password);
      if (dataLogin['message'] == 'Too Many Attempts.') {
        DefaultDialogWidget().getDefaultDialogWithoutButton(
          context,
          true,
          'alert'.tr,
          Text(
            'alertTooManyAttempts'.tr,
            style: GoogleFonts.poppins(
              fontSize: 15.0,
              fontWeight: FontWeight.w600,
              color: HexColor(ColorWidget().black),
            ),
          ),
        );
        loading.value = false;
        return;
      }

      if (dataLogin['status']) {
        var profile = await AuthProvider().getProfile(dataLogin['token']);

        if (profile.status) {
          final box = GetStorage();
          box.write(
            'dataUser',
            {
              'userId': profile.data.userId,
              'userName': profile.data.userName,
              'fullName': profile.data.fullName,
              'email': profile.data.email,
              'role': profile.data.role,
              'status': profile.data.status,
              'colour': profile.data.colour,
              'type': profile.data.type,
              'deviceToken': profile.data.deviceToken,
              'token': dataLogin['token'],
              'dateTimeLogin': DateTime.now().toString(),
              'gpsGroup': profile.data.GPSGroup,
            },
          );

          loading.value = false;
          isAuth.value = true;
          Get.offAllNamed(Routes.BOTTOM_NAVIGATION);
          usernameC.text = '';
          passwordC.text = '';
        } else {
          loading.value = false;
          SnackbarWidget().getSnackbar(
              'Something Went Wrong'.tr, profile.message, 'error');
        }
      } else {
        loading.value = false;
        SnackbarWidget().getSnackbar(
            'Something Went Wrong'.tr, dataLogin['message'], 'error');
      }
    }
  }
}
