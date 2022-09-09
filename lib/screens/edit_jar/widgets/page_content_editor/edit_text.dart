import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:jar_of_hearts/controllers/jar_controller.dart';
import 'package:jar_of_hearts/screens/edit_jar/widgets/bg_editor/pick_gradient.dart';
import 'package:jar_of_hearts/screens/home/widgets/sizedboxes.dart';
import 'package:jar_of_hearts/utils/size.dart';

class EditPageText extends StatefulWidget {
  const EditPageText({Key? key}) : super(key: key);

  @override
  State<EditPageText> createState() => _EditTextState();
}

class _EditTextState extends State<EditPageText> {
  final jarController = Get.put(JarController());
  @override
  void initState() {
    // TODO: implement initState
    text.text = jarController.currentJar['pages']
            ?[jarController.currentIndex.value]?['text'] ??
        '';
    super.initState();
  }

  final text = TextEditingController();

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
                'Edit text',
                style: TextStyle(color: Colors.white),
              ),
              const SizedBox(
                height: 20,
              ),
              const Spacer(),
              TextFormField(
                controller: text,
                onChanged: (v) {},
                style: const TextStyle(
                  color: Colors.white,
                ),
              ),
              const Spacer(),
              const SizedBox(
                height: 30,
              ),
              ElevatedButton(
                onPressed: () {
                  jarController.currentJar['pages']
                      ?[jarController.currentIndex.value]?['text'] = text.text;

                  jarController.currentJar.refresh();
                  Get.back();
                },
                child: const Text('Done'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
