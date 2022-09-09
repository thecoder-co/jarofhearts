// ignore_for_file: prefer_conditional_assignment

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:jar_of_hearts/controllers/jar_controller.dart';
import 'package:jar_of_hearts/screens/edit_jar/widgets/bg_editor/pick_color_box.dart';
import 'package:jar_of_hearts/screens/edit_jar/widgets/bg_editor/pick_gradient_box.dart';
import 'package:jar_of_hearts/screens/edit_jar/widgets/bg_editor/pick_image_box.dart';
import 'package:jar_of_hearts/screens/edit_jar/widgets/content_editor/edit_text_box.dart';
import 'package:jar_of_hearts/screens/edit_jar/widgets/content_editor/pick_font_box.dart';
import 'package:jar_of_hearts/screens/edit_jar/widgets/content_editor/pick_sound_box.dart';
import 'package:jar_of_hearts/screens/edit_jar/widgets/content_editor/text_color_box.dart';
import 'package:jar_of_hearts/screens/home/widgets/sizedboxes.dart';
import 'package:jar_of_hearts/utils/size.dart';

class ContentEditor extends StatelessWidget {
  ContentEditor({Key? key}) : super(key: key);

  final jarController = Get.put(JarController());
  Color? bgColor;
  List<Color>? bgGradient;
  String? bgImage;
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          const Text(
            'Content',
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
                        const EditTextBox(),
                        const SizedBox(
                          width: 20,
                        ),
                        TextColorBox()
                      ],
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Row(
                      children: [
                        const PickFontBox(),
                        const Width(20),
                        PickSoundBox(),
                      ],
                    ),
                  ],
                )
              : Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const EditTextBox(),
                    const SizedBox(
                      width: 20,
                    ),
                    TextColorBox(),
                    const SizedBox(
                      width: 20,
                    ),
                    const PickFontBox(),
                    const Width(20),
                    PickSoundBox(),
                  ],
                ),
        ],
      ),
    );
  }
}
