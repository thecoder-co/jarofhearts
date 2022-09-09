import 'package:flutter/material.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';
import 'package:get/get.dart';
import 'package:jar_of_hearts/controllers/jar_controller.dart';
import 'package:jar_of_hearts/screens/home/widgets/sizedboxes.dart';
import 'package:jar_of_hearts/utils/size.dart';

class PickGradient extends StatefulWidget {
  const PickGradient({Key? key}) : super(key: key);

  @override
  State<PickGradient> createState() => _PickGradientState();
}

class _PickGradientState extends State<PickGradient> {
  final jarController = Get.put(JarController());
  int? firstColor;
  int? secondColor;

  Color pickerColor = Colors.blueGrey;

  bool isFirst = true;

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
              Text(
                'Pick ${isFirst ? 'a' : 'next'} color',
                style: const TextStyle(color: Colors.white),
              ),
              const SizedBox(
                height: 20,
              ),
              const Spacer(),
              HueRingPicker(
                pickerColor: pickerColor,
                enableAlpha: false,
                displayThumbColor: true,
                portraitOnly: isLandscape ? true : false,
                onColorChanged: (color) {
                  setState(() {
                    pickerColor = color;
                  });
                  if (isFirst) {
                    setState(() {
                      firstColor = color.value;
                    });
                  } else {
                    setState(() {
                      secondColor = color.value;
                    });
                  }
//                  setState(() {});
                },
              ),
              const Spacer(),
              const SizedBox(
                height: 30,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Visibility(
                    visible: !isFirst,
                    child: IconButton(
                      onPressed: () {
                        setState(() {
                          isFirst = true;
                        });
                      },
                      icon: const Icon(Icons.arrow_back_ios_new_rounded),
                    ),
                  ),
                  const SizedBox(
                    width: 20,
                  ),
                  InkWell(
                    onTap: () {
                      if (firstColor == null || secondColor == null) return;

                      jarController.currentJar['bgColor'] = null;
                      jarController.currentJar['bgImage'] = null;

                      jarController.currentJar['bgGradient'] = [
                        firstColor,
                        secondColor
                      ];
                      jarController.currentJar.refresh();
                      //       jarController.saveEdit();

                      Get.back();
                    },
                    child: Container(
                      height: 50,
                      width: 100,
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15),
                        gradient: LinearGradient(
                            begin: Alignment.topLeft,
                            end: Alignment.bottomRight,
                            colors: firstColor == null
                                ? [Colors.blueGrey, Colors.blueGrey]
                                : secondColor == null
                                    ? [Color(firstColor!), Color(firstColor!)]
                                    : [
                                        Color(firstColor!),
                                        Color(secondColor!)
                                      ]),
                      ),
                      child: const Text('Done'),
                    ),
                  ),
                  const SizedBox(
                    width: 20,
                  ),
                  Visibility(
                    visible: isFirst,
                    child: IconButton(
                      onPressed: () {
                        setState(() {
                          isFirst = false;
                        });
                      },
                      icon: const Icon(Icons.arrow_forward_ios_rounded),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class Back extends StatelessWidget {
  const Back({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        InkWell(
            onTap: () => Get.back(),
            child: const Icon(
              Icons.close,
              color: Colors.white,
            ))
      ],
    );
  }
}
