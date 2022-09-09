import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:jar_of_hearts/controllers/jar_controller.dart';
import 'package:jar_of_hearts/screens/edit_jar/widgets/page_content_editor/pick_page_image.dart';

class PickPageImageBox extends StatelessWidget {
  PickPageImageBox({
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
              const PickPageImage(),
              barrierColor: Colors.transparent,
              useSafeArea: true,
            );
          },
          child: Container(
            height: 110,
            width: 110,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(15),
              border: Border.all(
                width: 2,
              ),
              image: const DecorationImage(
                image: AssetImage('assets/jar of hearts.jpeg'),
                fit: BoxFit.cover,
              ),
            ),
          ),
        ),
        const SizedBox(
          height: 5,
        ),
        const Text(
          'Image',
          style: TextStyle(color: Colors.white),
        ),
      ],
    );
  }
}
