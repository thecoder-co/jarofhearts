// ignore_for_file: prefer_conditional_assignment

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:jar_of_hearts/controllers/jar_controller.dart';
import 'package:jar_of_hearts/screens/edit_jar/widgets/card_editor/pick_border_color_box.dart';
import 'package:jar_of_hearts/screens/edit_jar/widgets/card_editor/pick_border_gradient_box.dart';
import 'package:jar_of_hearts/screens/edit_jar/widgets/card_editor/pick_color_box.dart';
import 'package:jar_of_hearts/screens/edit_jar/widgets/card_editor/pick_gradient_box.dart';
import 'package:jar_of_hearts/screens/edit_jar/widgets/card_editor/pick_image_box.dart';
import 'package:jar_of_hearts/screens/home/widgets/sizedboxes.dart';
import 'package:jar_of_hearts/utils/size.dart';

class CardEditor extends StatelessWidget {
  CardEditor({Key? key}) : super(key: key);

  final jarController = Get.put(JarController());
  Color? bgColor;
  List<Color>? bgGradient;
  String? bgImage;

  List<Color>? cardBorderBgGradient;
  @override
  Widget build(BuildContext context) {
    return Obx(() {
      if (jarController.currentJar['cardBgColor'] != null) {
        bgColor = Color(jarController.currentJar['cardBgColor']);
      } else {
        bgColor = null;
      }

      if (jarController.currentJar['cardBgGradient'] != null) {
        List gradient = jarController.currentJar['cardBgGradient'];
        bgGradient = gradient.map((e) => Color(e)).toList();
      } else {
        bgGradient = null;
      }

      if (jarController.currentJar['cardBgImage'] != null) {
        bgImage = jarController.currentJar['cardBgImage'];
      } else {
        bgImage = null;
      }

      if (jarController.currentJar['bgCardBorderGradient'] != null) {
        List gradient = jarController.currentJar['bgCardBorderGradient'];
        cardBorderBgGradient = gradient.map((e) => Color(e)).toList();
      } else {
        cardBorderBgGradient = null;
      }

      return Container(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            const Text(
              'Card Background',
              style: TextStyle(
                color: Colors.white,
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            WindowSize.isLandscape(context)
                ? Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Row(
                        children: [
                          PickCardColorBox(bgColor: bgColor),
                          const SizedBox(
                            width: 20,
                          ),
                          PickCardGradientBox(bgGradient: bgGradient),
                        ],
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      Row(
                        children: [
                          PickCardImageBox(bgImage: bgImage),
                          const Width(20),
                          PickBorderColorBox(bgColor: cardBorderBgGradient),
                        ],
                      ),
                      const Height(20),
                      PickBorderGradientBox(bgGradient: cardBorderBgGradient),
                    ],
                  )
                : Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      PickCardColorBox(bgColor: bgColor),
                      const SizedBox(
                        width: 20,
                      ),
                      PickCardGradientBox(bgGradient: bgGradient),
                      const SizedBox(
                        width: 20,
                      ),
                      PickCardImageBox(bgImage: bgImage),
                      const Width(20),
                      PickBorderColorBox(bgColor: cardBorderBgGradient),
                      const Width(20),
                      PickBorderGradientBox(bgGradient: cardBorderBgGradient),
                    ],
                  ),
          ],
        ),
      );
    });
  }
}
