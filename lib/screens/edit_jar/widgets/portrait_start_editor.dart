import 'package:flutter/material.dart';
import 'package:jar_of_hearts/controllers/jar_controller.dart';
import 'package:jar_of_hearts/screens/edit_jar/widgets/bg_editor/background_editor.dart';
import 'package:get/get.dart';
import 'package:jar_of_hearts/screens/edit_jar/widgets/card_editor/card_editor.dart';
import 'package:jar_of_hearts/screens/edit_jar/widgets/content_editor/content_editor.dart';

class PortraitJarEditor extends StatelessWidget {
  PortraitJarEditor({Key? key}) : super(key: key);

  final jarController = Get.put(JarController());

  @override
  Widget build(BuildContext context) {
    return Container(
      key: JarController.editorKey,
      color: Colors.grey[900],
      padding: const EdgeInsets.symmetric(vertical: 5),
      // height: double.infinity,
      width: double.infinity,
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            children: [
              const SizedBox(
                width: 5,
              ),
              BgEditor(),
              const SizedBox(width: 20),
              ContentEditor(),
              const SizedBox(
                width: 20,
              ),
              CardEditor(),
            ],
          ),
        ),
      ),
    );
  }
}
