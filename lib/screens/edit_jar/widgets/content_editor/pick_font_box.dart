import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:jar_of_hearts/screens/edit_jar/widgets/content_editor/pick_font.dart';

class PickFontBox extends StatelessWidget {
  const PickFontBox({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        InkWell(
          onTap: () {
            Get.dialog(
              const PickFont(),
              barrierColor: Colors.transparent,
              useSafeArea: true,
            );
          },
          child: Container(
            height: 110,
            width: 110,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(15),
              color: Colors.blueGrey,
            ),
            alignment: Alignment.center,
            child: const Text(
              'Aa',
              style: TextStyle(fontSize: 30),
            ),
          ),
        ),
        const SizedBox(
          height: 5,
        ),
        const Text(
          'Font',
          style: TextStyle(color: Colors.white),
        ),
      ],
    );
  }
}
