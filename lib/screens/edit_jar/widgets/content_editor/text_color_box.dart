import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:jar_of_hearts/controllers/jar_controller.dart';
import 'package:jar_of_hearts/screens/edit_jar/widgets/content_editor/pick_text_color.dart';

class TextColorBox extends StatelessWidget {
  TextColorBox({
    Key? key,
  }) : super(key: key);
  final jarController = Get.put(JarController());
  @override
  Widget build(BuildContext context) {
    return Obx(() {
      Color? color;
      if (jarController.currentJar['textColor'] != null) {
        color = Color(jarController.currentJar['textColor']);
      }
      return Column(
        children: [
          InkWell(
            onTap: () {
              Get.dialog(
                const PickTextColor(),
                barrierColor: Colors.transparent,
                useSafeArea: true,
              );
            },
            child: Container(
              height: 110,
              width: 110,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15),
                color: color ?? const Color(0xffA1C6EA),
              ),
            ),
          ),
          const SizedBox(
            height: 5,
          ),
          const Text(
            'Color',
            style: TextStyle(color: Colors.white),
          ),
        ],
      );
    });
  }
}
