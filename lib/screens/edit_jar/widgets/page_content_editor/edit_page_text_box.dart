import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:jar_of_hearts/controllers/jar_controller.dart';
import 'package:jar_of_hearts/screens/edit_jar/widgets/page_content_editor/edit_text.dart';

class EditPageTextBox extends StatelessWidget {
  EditPageTextBox({
    Key? key,
  }) : super(key: key);
  final jarController = Get.put(JarController());
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        InkWell(
          onTap: () {
            if ((jarController.currentJar['pages'] as List?)?.isEmpty ?? true) {
              jarController.currentJar['pages'] = [
                {'text': 'Edit something...'}
              ];
            }
            if ((jarController.currentJar['pages'] as List).length ==
                jarController.currentIndex.value) {
              jarController.currentJar['pages']
                  .add({'text': 'Edit something...'});
            }
            jarController.currentJar.refresh();
            Get.dialog(
              const EditPageText(),
              barrierColor: Colors.transparent,
              useSafeArea: true,
            );
          },
          child: Container(
            height: 110,
            width: 110,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(15),
              color: Colors.blueGrey,
            ),
            alignment: Alignment.center,
            child: const Text(
              'Aa',
              style: TextStyle(fontSize: 30),
            ),
          ),
        ),
        const SizedBox(
          height: 5,
        ),
        const Text(
          'Text',
          style: TextStyle(color: Colors.white),
        ),
      ],
    );
  }
}
