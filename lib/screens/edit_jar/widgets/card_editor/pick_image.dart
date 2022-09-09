import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:jar_of_hearts/controllers/jar_controller.dart';
import 'package:jar_of_hearts/screens/edit_jar/widgets/bg_editor/image_upload_box.dart';
import 'package:jar_of_hearts/screens/edit_jar/widgets/bg_editor/pick_gradient.dart';
import 'package:jar_of_hearts/screens/edit_jar/widgets/card_editor/image_box.dart';
import 'package:jar_of_hearts/screens/home/widgets/sizedboxes.dart';
import 'package:jar_of_hearts/utils/size.dart';

class PickCardImage extends StatefulWidget {
  const PickCardImage({Key? key}) : super(key: key);

  @override
  State<PickCardImage> createState() => _PickColorState();
}

class _PickColorState extends State<PickCardImage> {
  final jarController = Get.put(JarController());
  @override
  Widget build(BuildContext context) {
    final boxContext = JarController.editorKey.currentContext!;
    final box = boxContext.findRenderObject() as RenderBox;
    final isLandscape = WindowSize.isLandscape(context);
    return Container(
      alignment: isLandscape ? Alignment.centerLeft : Alignment.bottomCenter,
      child: Material(
        child: Container(
          height: double.infinity,
          width: isLandscape ? box.size.width : double.infinity,
          padding: const EdgeInsets.all(20),
          color: Colors.grey[900],
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const Back(),
              const Height(10),
              const Text(
                'Your images',
                style: TextStyle(color: Colors.white),
              ),
              const Height(10),
              Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Obx(() => GridView.count(
                            shrinkWrap: true,
                            physics: const NeverScrollableScrollPhysics(),
                            mainAxisSpacing: 20,
                            crossAxisSpacing: 20,
                            childAspectRatio: 1,
                            crossAxisCount: 2,
                            children: [
                              ImageUploadBox(),
                              ...List.generate(
                                jarController
                                        .profile['body']?['images']?.length ??
                                    0,
                                (index) => CardImageBox(
                                  imageUrl: jarController.profile['body']
                                      ['images'][index]['url'],
                                ),
                              ),
                            ],
                          )),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
