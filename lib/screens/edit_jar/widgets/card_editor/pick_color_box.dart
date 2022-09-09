import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:jar_of_hearts/screens/edit_jar/widgets/card_editor/pick_color.dart';

class PickCardColorBox extends StatelessWidget {
  const PickCardColorBox({
    Key? key,
    required this.bgColor,
  }) : super(key: key);

  final Color? bgColor;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        InkWell(
          onTap: () {
            Get.dialog(
              const PickCardColor(),
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
                color: bgColor != null ? Colors.green : Colors.transparent,
              ),
              color: bgColor ?? Colors.blueGrey,
            ),
          ),
        ),
        const SizedBox(
          height: 5,
        ),
        const Text(
          'Color',
          style: TextStyle(color: Colors.white),
        ),
      ],
    );
  }
}
