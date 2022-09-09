// ignore_for_file: prefer_conditional_assignment

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:jar_of_hearts/controllers/jar_controller.dart';
import 'package:jar_of_hearts/screens/edit_jar/widgets/page_content_editor/edit_page_text_box.dart';
import 'package:jar_of_hearts/screens/edit_jar/widgets/page_content_editor/pick_page_image_box.dart';
import 'package:jar_of_hearts/screens/edit_jar/widgets/page_content_editor/pick_page_sound_box.dart';
import 'package:jar_of_hearts/screens/home/widgets/sizedboxes.dart';
import 'package:jar_of_hearts/utils/size.dart';

class PageContentEditor extends StatelessWidget {
  PageContentEditor({Key? key}) : super(key: key);

  final jarController = Get.put(JarController());

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
                        EditPageTextBox(),
                        const SizedBox(
                          width: 20,
                        ),
                        PickPageImageBox()
                      ],
                    ),
                    const Height(20),
                    PickPageSoundBox(),
                  ],
                )
              : Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    EditPageTextBox(),
                    const SizedBox(
                      width: 20,
                    ),
                    PickPageImageBox(),
                    const Width(20),
                    PickPageSoundBox(),
                  ],
                ),
        ],
      ),
    );
  }
}
