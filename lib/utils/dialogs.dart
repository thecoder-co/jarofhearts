import 'package:flutter/material.dart';
import 'package:get/get.dart';

class Dialogs {
  static void loadDialog() {
    Get.dialog(const Center(child: CircularProgressIndicator.adaptive()));
  }

  static void showSnackBar(String message) {
    Get.showSnackbar(
      GetSnackBar(
        message: message,
        borderRadius: 15,
        duration: const Duration(seconds: 2),
        margin: const EdgeInsets.all(20),
        snackStyle: SnackStyle.FLOATING,
        snackPosition:
            Get.isBottomSheetOpen! ? SnackPosition.TOP : SnackPosition.BOTTOM,
      ),
    );
  }

  static void showErrorSnackBar(String message) {
    Get.showSnackbar(
      GetSnackBar(
        message: message,
        borderRadius: 15,
        margin: const EdgeInsets.all(20),
        duration: const Duration(seconds: 2),
        backgroundColor: Colors.red,
        snackStyle: SnackStyle.FLOATING,
        snackPosition:
            Get.isBottomSheetOpen! ? SnackPosition.TOP : SnackPosition.BOTTOM,
      ),
    );
  }
}
