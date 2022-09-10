import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:jar_of_hearts/controllers/audio_controller.dart';
import 'package:jar_of_hearts/controllers/jar_controller.dart';

import 'package:jar_of_hearts/screens/edit_jar/widgets/bg_editor/pick_gradient.dart';
import 'package:jar_of_hearts/screens/edit_jar/widgets/sound_upload_box.dart';
import 'package:jar_of_hearts/screens/home/widgets/sizedboxes.dart';
import 'package:jar_of_hearts/utils/size.dart';
import 'package:loading_indicator/loading_indicator.dart';

class PickSound extends StatefulWidget {
  final Function? soundSwitchCallback;
  final Function(String) onTapCallback;
  final String? chosenUrl;
  final String? chosenName;
  const PickSound({
    Key? key,
    required this.onTapCallback,
    this.chosenUrl,
    this.chosenName,
    this.soundSwitchCallback,
  }) : super(key: key);

  @override
  State<PickSound> createState() => _PickColorState();
}

class _PickColorState extends State<PickSound> {
  final jarController = Get.put(JarController());
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
              Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    // crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Back(),
                      const SizedBox(
                        height: 10,
                      ),
                      if (widget.chosenUrl != null)
                        Column(
                          mainAxisSize: MainAxisSize.min,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text('Chosen sound',
                                style: TextStyle(color: Colors.white)),
                            Row(),
                            const Height(10),
                            SoundBox(
                              url: widget.chosenUrl!,
                              name: widget.chosenName,
                              callBack: () {},
                            )
                          ],
                        ),
                      const Height(10),
                      Row(
                        children: [
                          const Spacer(),
                          const Text(
                            'Your sounds',
                            style: TextStyle(color: Colors.white),
                          ),
                          const Spacer(),
                          if (widget.soundSwitchCallback != null)
                            Switch.adaptive(
                              value: true,
                              onChanged: (v) {
                                widget.soundSwitchCallback!();
                              },
                            ),
                        ],
                      ),
                      const Height(10),
                      Obx(() => GridView.count(
                            shrinkWrap: true,
                            physics: const NeverScrollableScrollPhysics(),
                            mainAxisSpacing: 20,
                            crossAxisSpacing: 20,
                            //childAspectRatio: 1,
                            crossAxisCount: 2,
                            children: [
                              SoundUploadBox(),
                              ...List.generate(
                                jarController
                                        .profile['body']?['audios']?.length ??
                                    0,
                                (index) {
                                  print(jarController.profile.value);

                                  return SoundBox(
                                    url: jarController.profile['body']['audios']
                                        [index]['url'],
                                    name: jarController.profile['body']
                                        ['audios'][index]['name'],
                                    callBack: () {
                                      print(jarController.profile['body']
                                              ['audios'][index]['url'] ==
                                          String);
                                      widget.onTapCallback(
                                          jarController.profile['body']
                                              ['audios'][index]['url']);
                                      AudioController.player.stop();
                                      AudioController.secondPlayer.stop();
                                    },
                                  );
                                },
                              ),
                            ],
                          )),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class SoundBox extends StatelessWidget {
  final String url;
  final String? name;
  final Function callBack;
  SoundBox({
    Key? key,
    required this.url,
    required this.callBack,
    this.name,
  }) : super(key: key);

  final jarController = Get.put(JarController());
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () async {
        AudioController.player.play(UrlSource(url));
        final bool? shouldChoose = await Get.dialog(
          AlertDialog(
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  name ?? '',
                  maxLines: 1,
                ),
                const Height(20),
                const Expanded(
                  child: LoadingIndicator(
                    indicatorType: Indicator.ballScaleMultiple,
                  ),
                ),
                const Height(10),
                const Text('Please wait for sound to load from network'),
                const Height(20),
                Row(
                  children: [
                    ElevatedButton(
                      onPressed: () {
                        Get.back(result: false);
                      },
                      child: const Text('Back'),
                    ),
                    const Spacer(),
                    ElevatedButton(
                      onPressed: () {
                        Get.back(result: true);
                      },
                      child: const Text('Choose'),
                    ),
                  ],
                )
              ],
            ),
          ),
        );
        AudioController.player.stop();
        AudioController.secondPlayer.stop();
        if (shouldChoose ?? false) {
          callBack();
        }
      },
      child: Column(
        children: [
          Container(
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
          /*  const Height(10),
          SizedBox(
            width: 110,
            child: Text(
              name ?? '',
              maxLines: 1,
            ),
          ) */
        ],
      ),
    );
  }
}
