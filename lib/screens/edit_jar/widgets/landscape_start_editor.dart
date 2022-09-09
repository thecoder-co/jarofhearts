import 'package:flutter/material.dart';
import 'package:jar_of_hearts/controllers/jar_controller.dart';
import 'package:jar_of_hearts/screens/edit_jar/widgets/bg_editor/background_editor.dart';
import 'package:get/get.dart';
import 'package:jar_of_hearts/screens/edit_jar/widgets/card_editor/card_editor.dart';
import 'package:jar_of_hearts/screens/edit_jar/widgets/content_editor/content_editor.dart';

class LandScapeJarEditor extends StatelessWidget {
  LandScapeJarEditor({Key? key}) : super(key: key);

  final jarController = Get.put(JarController());

  @override
  Widget build(BuildContext context) {
    return Container(
      key: JarController.editorKey,
      color: Colors.grey[900],
      padding: const EdgeInsets.symmetric(horizontal: 20),
      height: double.infinity,
      // width: WindowSize.width(context) / 3,
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(
              height: kToolbarHeight,
            ),
            BgEditor(),
            const SizedBox(height: 20),
            ContentEditor(),
            const SizedBox(
              height: 20,
            ),
            CardEditor(),
          ],
        ),
      ),
    );
  }
}
