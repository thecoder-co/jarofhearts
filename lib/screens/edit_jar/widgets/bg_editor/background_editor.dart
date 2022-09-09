// ignore_for_file: prefer_conditional_assignment

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:jar_of_hearts/controllers/jar_controller.dart';
import 'package:jar_of_hearts/screens/edit_jar/widgets/bg_editor/pick_color_box.dart';
import 'package:jar_of_hearts/screens/edit_jar/widgets/bg_editor/pick_gradient_box.dart';
import 'package:jar_of_hearts/screens/edit_jar/widgets/bg_editor/pick_image_box.dart';
import 'package:jar_of_hearts/utils/size.dart';

class BgEditor extends StatelessWidget {
  BgEditor({Key? key}) : super(key: key);

  final jarController = Get.put(JarController());
  Color? bgColor;
  List<Color>? bgGradient;
  String? bgImage;
  @override
  Widget build(BuildContext context) {
    return Obx(() {
      if (jarController.currentJar['bgColor'] != null) {
        bgColor = Color(jarController.currentJar['bgColor']);
      } else {
        bgColor = null;
      }

      if (jarController.currentJar['bgGradient'] != null) {
        List gradient = jarController.currentJar['bgGradient'];
        bgGradient = gradient.map((e) => Color(e)).toList();
      } else {
        bgGradient = null;
      }

      if (jarController.currentJar['bgImage'] != null) {
        bgImage = jarController.currentJar['bgImage'];
      } else {
        bgImage = null;
      }

      return Container(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            const Text(
              'Background Color/Gradient',
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
                          PickColorBox(bgColor: bgColor),
                          const SizedBox(
                            width: 20,
                          ),
                          PickGradientBox(bgGradient: bgGradient),
                        ],
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      PickImageBox(bgImage: bgImage)
                    ],
                  )
                : Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      PickColorBox(bgColor: bgColor),
                      const SizedBox(
                        width: 20,
                      ),
                      PickGradientBox(bgGradient: bgGradient),
                      const SizedBox(
                        width: 20,
                      ),
                      PickImageBox(bgImage: bgImage)
                    ],
                  ),
          ],
        ),
      );
    });
  }
}
