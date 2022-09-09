import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:jar_of_hearts/screens/edit_jar/widgets/card_editor/pick_border_gradient.dart';
import 'package:collection/collection.dart';

class PickBorderColorBox extends StatelessWidget {
  const PickBorderColorBox({
    Key? key,
    required this.bgColor,
  }) : super(key: key);

  final List<Color>? bgColor;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        InkWell(
          onTap: () {
            Get.dialog(
              const PickBorderGradient(
                isColor: true,
              ),
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
                color: bgColor?.firstOrNull == bgColor?.lastOrNull
                    ? Colors.green
                    : Colors.transparent,
              ),
              color: bgColor?[0] ?? Colors.blueGrey,
            ),
          ),
        ),
        const SizedBox(
          height: 5,
        ),
        const Text(
          'Border Color',
          style: TextStyle(color: Colors.white),
        ),
      ],
    );
  }
}
