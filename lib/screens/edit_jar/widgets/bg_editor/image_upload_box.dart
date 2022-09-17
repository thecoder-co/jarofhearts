import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:jar_of_hearts/controllers/jar_controller.dart';
import 'package:jar_of_hearts/screens/edit_jar/widgets/bg_editor/upload_unsplash_image.dart';
import 'package:jar_of_hearts/screens/home/widgets/sizedboxes.dart';

class ImageUploadBox extends StatelessWidget {
  ImageUploadBox({
    Key? key,
  }) : super(key: key);

  final jarController = Get.put(JarController());

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 110,
      width: 110,
      child: Column(
        children: [
          Expanded(
            child: InkWell(
              onTap: () {
                jarController.finishImage();
              },
              child: Container(
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(
                    width: 2,
                    color: Colors.black,
                  ),
                ),
                child: Icon(
                  Icons.upload,
                  color: Colors.grey[300],
                ),
              ),
            ),
          ),
          const Height(10),
          Expanded(
            child: InkWell(
              onTap: () {
                Get.dialog(const PickUpsplashImage());
              },
              child: Container(
                alignment: Alignment.center,
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(
                    width: 2,
                    color: Colors.black,
                  ),
                ),
                child:
                    Image.asset('assets/upsplash.png', color: Colors.grey[300]),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
