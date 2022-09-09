import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:jar_of_hearts/screens/edit_jar/widgets/bg_editor/pick_image.dart';

class PickImageBox extends StatelessWidget {
  const PickImageBox({
    Key? key,
    required this.bgImage,
  }) : super(key: key);

  final String? bgImage;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        InkWell(
          onTap: () {
            Get.dialog(
              const PickImage(),
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
                color: bgImage != null ? Colors.green : Colors.transparent,
              ),
              image: bgImage != null
                  ? DecorationImage(
                      image: NetworkImage(bgImage!),
                      fit: BoxFit.cover,
                    )
                  : const DecorationImage(
                      image: AssetImage('assets/jar of hearts.jpeg'),
                      fit: BoxFit.cover,
                    ),
            ),
          ),
        ),
        const SizedBox(
          height: 5,
        ),
        const Text(
          'Image',
          style: TextStyle(color: Colors.white),
        ),
      ],
    );
  }
}
