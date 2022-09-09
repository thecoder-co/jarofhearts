import 'package:flutter/material.dart';
import 'package:jar_of_hearts/controllers/jar_controller.dart';
import 'package:get/get.dart';
import 'package:jar_of_hearts/screens/edit_jar/widgets/page_content_editor/page_content_editor.dart';
import 'package:jar_of_hearts/screens/home/widgets/sizedboxes.dart';
import 'package:jar_of_hearts/utils/size.dart';

class SecondEditor extends StatelessWidget {
  SecondEditor({Key? key}) : super(key: key);

  final jarController = Get.put(JarController());

  @override
  Widget build(BuildContext context) {
    return Container(
      key: JarController.editorSecondKey,
      color: Colors.grey[900],
      padding: const EdgeInsets.symmetric(horizontal: 20),
      height: WindowSize.isLandscape(context) ? double.infinity : null,
      width: WindowSize.isLandscape(context) ? null : double.infinity,
      // width: WindowSize.width(context) / 3,
      child: SingleChildScrollView(
        child: WindowSize.isLandscape(context)
            ? SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Height(kToolbarHeight + 10),
                    PageContentEditor(),
                  ],
                ),
              )
            : SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: [
                    PageContentEditor(),
                  ],
                ),
              ),
      ),
    );
  }
}
