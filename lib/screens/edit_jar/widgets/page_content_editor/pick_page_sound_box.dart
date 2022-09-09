import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:jar_of_hearts/controllers/jar_controller.dart';
import 'package:jar_of_hearts/screens/edit_jar/widgets/content_editor/pick_sound.dart';

class PickPageSoundBox extends StatelessWidget {
  PickPageSoundBox({
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
                  jarController.currentJar['pages']
                      [jarController.currentIndex.value]['sound'] = url;
                  jarController.currentJar.refresh();
                  Get.back();
                },
                chosenUrl: jarController.currentJar['pages']
                    ?[jarController.currentIndex.value]?['sound'],
                soundSwitchCallback: jarController.currentJar['pages']
                            ?[jarController.currentIndex.value]?['sound'] !=
                        null
                    ? () {
                        /* jarController.currentJar['pages']
                            [jarController.currentIndex.value]['sound'] = null; */
                        jarController.currentJar['pages']
                                [jarController.currentIndex.value]
                            .remove('sound');
                        jarController.currentJar.refresh();
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
