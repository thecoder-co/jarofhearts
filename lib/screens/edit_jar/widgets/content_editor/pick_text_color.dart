import 'package:flutter/material.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';
import 'package:get/get.dart';
import 'package:jar_of_hearts/controllers/jar_controller.dart';
import 'package:jar_of_hearts/screens/edit_jar/widgets/bg_editor/pick_gradient.dart';
import 'package:jar_of_hearts/screens/home/widgets/sizedboxes.dart';
import 'package:jar_of_hearts/utils/size.dart';

class PickTextColor extends StatefulWidget {
  const PickTextColor({Key? key}) : super(key: key);

  @override
  State<PickTextColor> createState() => _PickColorState();
}

class _PickColorState extends State<PickTextColor> {
  final jarController = Get.put(JarController());
  var pickedColor = const Color(0xffA1C6EA);
  @override
  void initState() {
    super.initState();
    pickedColor = jarController.currentJar['textColor'] != null
        ? Color(jarController.currentJar['textColor'])
        : const Color(0xffA1C6EA);
  }

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
                'Pick a color',
                style: TextStyle(color: Colors.white),
              ),
              const Spacer(),
              HueRingPicker(
                pickerColor: pickedColor,
                enableAlpha: false,
                displayThumbColor: true,
                portraitOnly: isLandscape ? true : false,
                onColorChanged: (color) {
                  setState(() {
                    pickedColor = color;
                  });

                  //      jarController.saveEdit();
                },
              ),
              const Spacer(),
              InkWell(
                onTap: () {
                  jarController.currentJar['textColor'] = pickedColor.value;
                  jarController.currentJar.refresh();
                  jarController.currentJar.refresh();

                  Get.back();
                },
                child: Container(
                  height: 50,
                  width: 100,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15),
                    color: pickedColor,
                  ),
                  child: const Text('Done'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
