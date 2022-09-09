import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:jar_of_hearts/controllers/jar_controller.dart';

class AddJarBox extends StatelessWidget {
  AddJarBox({
    Key? key,
  }) : super(key: key);
  final jarController = Get.put(JarController());

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        jarController.createJarAndEnter();
      },
      child: Container(
        height: 200,
        width: 300,
        decoration: BoxDecoration(
          color: Colors.grey[300],
          borderRadius: BorderRadius.circular(25),
        ),
        alignment: Alignment.center,
        child: ClipOval(
          child: Container(
            height: 150,
            width: 150,
            alignment: Alignment.center,
            color: Colors.grey,
            child: const Icon(
              Icons.add_rounded,
              size: 50,
              color: Colors.white,
            ),
          ),
        ),
      ),
    );
  }
}
