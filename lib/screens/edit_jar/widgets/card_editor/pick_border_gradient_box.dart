import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:jar_of_hearts/screens/edit_jar/widgets/card_editor/pick_border_gradient.dart';
import 'package:jar_of_hearts/utils/app_colors.dart';
import 'package:collection/collection.dart';

class PickBorderGradientBox extends StatelessWidget {
  const PickBorderGradientBox({
    Key? key,
    required this.bgGradient,
  }) : super(key: key);

  final List<Color>? bgGradient;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        InkWell(
          onTap: () {
            Get.dialog(
                const PickBorderGradient(
                  isColor: false,
                ),
                useSafeArea: true,
                barrierColor: Colors.transparent);
          },
          child: Container(
            height: 110,
            width: 110,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15),
                border: Border.all(
                  width: 2,
                  color: bgGradient?.firstOrNull != bgGradient?.lastOrNull
                      ? Colors.green
                      : Colors.transparent,
                ),
                gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: bgGradient ?? AppColors.gradient.colors,
                )
                //color: bgColor ?? Colors.blueGrey,
                ),
          ),
        ),
        const SizedBox(
          height: 5,
        ),
        const Text(
          'Border Gradient',
          style: TextStyle(color: Colors.white),
        ),
      ],
    );
  }
}
