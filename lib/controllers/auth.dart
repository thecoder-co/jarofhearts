import 'package:get/get.dart';
import 'package:jar_of_hearts/apis/login.dart';
import 'package:jar_of_hearts/apis/register.dart';
import 'package:jar_of_hearts/screens/auth/login_screen.dart';
import 'package:jar_of_hearts/utils/dialogs.dart';
import 'package:jar_of_hearts/utils/string_exception.dart';
import 'package:jar_of_hearts/utils/user_preference.dart';

class AuthController extends GetxController {
  Future<bool> registerUser({
    required String username,
    required String password,
  }) async {
    bool status = false;
    try {
      Dialogs.loadDialog();
      await registerUserApi(username: username, password: password);
      status = true;
      Get.back();
    } on StringException catch (e) {
      Get.back();
      Dialogs.showErrorSnackBar(e.toString());
      rethrow;
    } on Exception {
      Get.back();
      Dialogs.showErrorSnackBar('An error occoured');
      rethrow;
    }

    return status;
  }

  Future<bool> loginUser({
    required String username,
    required String password,
  }) async {
    bool status = false;
    try {
      Dialogs.loadDialog();
      final data = await loginUserApi(username: username, password: password);
      status = true;
      UserPreferences.saveToken(data['access_token']);

      Get.back();
    } on StringException catch (e) {
      Get.back();
      Dialogs.showErrorSnackBar(e.toString());
      rethrow;
    } on Exception {
      Get.back();
      Dialogs.showErrorSnackBar('An error occoured');
      rethrow;
    }

    return status;
  }

  static void logout() {
    UserPreferences.removeToken();
    Get.offAll(() => const LoginScreen());
  }
}
