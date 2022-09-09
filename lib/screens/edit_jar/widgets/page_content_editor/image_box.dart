import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:jar_of_hearts/controllers/jar_controller.dart';

class ImageBox extends StatelessWidget {
  final String imageUrl;
  ImageBox({
    Key? key,
    required this.imageUrl,
  }) : super(key: key);

  final jarController = Get.put(JarController());
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        jarController.currentJar['pages']?[jarController.currentIndex.value]
            ?['image'] = imageUrl;
        jarController.currentJar.refresh();
        Get.back();
      },
      child: Container(
        height: 110,
        width: 110,
        alignment: Alignment.center,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15),
          border: Border.all(
            width: 2,
            color: Colors.transparent,
          ),
          image: DecorationImage(
            image: NetworkImage(imageUrl),
            fit: BoxFit.cover,
          ),
        ),
      ),
    );
  }
}
