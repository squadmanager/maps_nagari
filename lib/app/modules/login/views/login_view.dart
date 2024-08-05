import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:maps_nagari/app/modules/login/controllers/login_controller.dart';
import 'package:maps_nagari/app/widgets/color_widget.dart';

import '../../../widgets/elevated_button_widget.dart';
import '../../../widgets/input_widget.dart';

class LoginView extends GetView<LoginController> {
  const LoginView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Obx(
        () => SafeArea(
          child: Form(
            key: controller.formKey.value,
            child: Center(
              child: SingleChildScrollView(
                scrollDirection: Axis.vertical,
                padding: const EdgeInsets.symmetric(vertical: 10.0),
                child: SizedBox(
                  width: Get.width / 3,
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(left: 20.0, right: 20.0),
                        child: Image.asset(
                          'assets/images/logo_urbana.png',
                          width: 150,
                          height: 150,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(
                            top: 10.0, left: 20.0, right: 20.0),
                        child: Text(
                          'Maps Nagari',
                          style: TextStyle(
                            fontFamily: 'BerlinSans',
                            fontWeight: FontWeight.w700,
                            fontSize: 40.0,
                            color: HexColor(ColorWidget().primary),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(
                            left: 20.0, right: 20.0, top: 20.0),
                        child: InputWidget(
                          title: 'Username',
                          controllerText: controller.usernameC,
                          hintText: 'Enter Username',
                          messageError: 'Username Required!',
                          obscureText: false,
                          textRequired: true,
                          onTap: () {},
                          maxLines: 1,
                          paddingVertical: 0,
                          prefixIcon: SvgPicture.asset(
                            'assets/icons/user-circle.svg',
                            color: HexColor(ColorWidget().grey),
                            fit: BoxFit.scaleDown,
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(
                            top: 20.0, right: 20.0, left: 20.0),
                        child: InputWidget(
                          title: 'Passowrd',
                          controllerText: controller.passwordC,
                          hintText: 'Enter Password',
                          messageError: 'Password Required!',
                          obscureText: controller.hiddenPassword.value,
                          suffixIcon: GestureDetector(
                            onTap: () => controller.hiddenPassword.toggle(),
                            child: SvgPicture.asset(
                              controller.hiddenPassword.value
                                  ? 'assets/icons/eye-slash.svg'
                                  : 'assets/icons/eye.svg',
                              color: HexColor(ColorWidget().grey),
                              fit: BoxFit.scaleDown,
                            ),
                          ),
                          textRequired: true,
                          onTap: () {},
                          maxLines: 1,
                          paddingVertical: 0,
                          prefixIcon: SvgPicture.asset(
                            'assets/icons/lock.svg',
                            color: HexColor(ColorWidget().grey),
                            fit: BoxFit.scaleDown,
                          ),
                        ),
                      ),
                      if (controller.loading.isTrue) ...[
                        Container(
                          margin: const EdgeInsets.only(top: 40.0, left: 20.0, right: 20.0),
                          width: double.infinity,
                          height: 48.0,
                          child: ElevatedButtonWidget(
                            onPress: () {},
                            color: HexColor(ColorWidget().primary),
                            child: SizedBox(
                              height: 28.0,
                              width: 28.0,
                              child: CircularProgressIndicator(
                                color: HexColor(ColorWidget().white),
                              ),
                            ),
                          ),
                        ),
                      ] else ...[
                        Container(
                          margin: const EdgeInsets.only(top: 40.0, left: 20.0, right: 20.0),
                          width: double.infinity,
                          height: 48.0,
                          child: ElevatedButtonWidget(
                            onPress: () {
                              controller.submitLogin(
                                controller.usernameC.text,
                                controller.passwordC.text,
                                controller.formKey.value,
                                context,
                              );
                            },
                            color: HexColor(ColorWidget().primary),
                            child: Text(
                              'Login',
                              style: GoogleFonts.poppins(
                                fontWeight: FontWeight.w600,
                                fontSize: 18.0,
                                color: HexColor(ColorWidget().white),
                              ),
                            ),
                          ),
                        ),
                      ]
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
