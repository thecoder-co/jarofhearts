import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:jar_of_hearts/controllers/jar_controller.dart';

class SoundUploadBox extends StatelessWidget {
  SoundUploadBox({
    Key? key,
  }) : super(key: key);

  final jarController = Get.put(JarController());

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        jarController.finishSound();
      },
      child: Container(
        height: 110,
        width: 110,
        alignment: Alignment.center,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15),
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
    );
  }
}
