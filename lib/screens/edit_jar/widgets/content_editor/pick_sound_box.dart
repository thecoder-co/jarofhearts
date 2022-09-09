import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:jar_of_hearts/controllers/jar_controller.dart';
import 'package:jar_of_hearts/screens/edit_jar/widgets/content_editor/pick_sound.dart';

class PickSoundBox extends StatelessWidget {
  PickSoundBox({
    Key? key,
  }) : super(key: key);
  final jarController = Get.put(JarController());
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        InkWell(
          onTap: () {
            Get.dialog(
              PickSound(
                onTapCallback: (url) {
                  jarController.currentJar['sound'] = url;
                  jarController.currentJar.refresh();
                  Get.back();
                },
                chosenUrl: jarController.currentJar['sound'],
                soundSwitchCallback: jarController.currentJar['sound'] != null
                    ? () {
                        jarController.currentJar['sound'] = null;
                        jarController.currentJar.remove('sound');
                        //  jarController.currentJar.refresh();
                        Get.back();
                      }
                    : null,
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
              color: Colors.yellow[900],
            ),
            alignment: Alignment.center,
            child: const Icon(
              Icons.music_note_rounded,
              color: Colors.white,
              size: 35,
            ),
          ),
        ),
        const SizedBox(
          height: 5,
        ),
        const Text(
          'Pick sound',
          style: TextStyle(color: Colors.white),
        ),
      ],
    );
  }
}
