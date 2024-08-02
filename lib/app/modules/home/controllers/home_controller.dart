import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:maps_nagari/app/data/providers/auth_provider.dart';
import 'package:maps_nagari/app/routes/app_pages.dart';
import 'package:maps_nagari/app/widgets/snackbar_widget.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HomeController extends GetxController {
  var hiddenPassword = true.obs;
  var loading = false.obs;
  var isAuth = false.obs;

  var requireConsent = false;

  var isLightTheme = false.obs;

  Future<void> autoLogin() async {
    await GetStorage.init();
    final box = GetStorage();

    if (box.read('dataUser') != null) {
      final data = box.read('dataUser') as Map<String, dynamic>;
      AuthProvider().logout(data['token']).then(
        (value) {
          submitLogin('sysadmin', '111111');
        },
      );
      // isAuth.value = true;
    } else {
      submitLogin('sysadmin', '111111');
    }
  }

  Future<void> submitLogin(String username, String password) async {
    loading.value = true;
    if (username != '' && password != '') {
      var dataLogin = await AuthProvider().loginStore(username, password);
      if (dataLogin['status']) {
        var profile = await AuthProvider().getProfile(dataLogin['token']);

        if (profile.status) {
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
                'gpsGroup': profile.data.GPSGroup,
              },
            );
          }

          loading.value = false;
          isAuth.value = true;
          Get.offAllNamed(Routes.BOTTOM_NAVIGATION);
        } else {
          loading.value = false;
          SnackbarWidget()
              .getSnackbar('Something went wrong', profile.message, 'error');
        }
      } else {
        loading.value = false;
        SnackbarWidget()
            .getSnackbar('Something went wrong', dataLogin['message'], 'error');
      }
    } else {
      loading.value = false;
      SnackbarWidget().getSnackbar('Something went wrong',
          'Username & Password cannot be empty', 'error');
    }
  }

  void logout() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    await preferences.clear();
    Get.offAllNamed(Routes.HOME);
    isAuth.value = false;
  }
}
