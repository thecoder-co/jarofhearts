import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_swiper_plus/flutter_swiper_plus.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:gradient_borders/gradient_borders.dart';
import 'package:jar_of_hearts/controllers/audio_controller.dart';
import 'package:jar_of_hearts/controllers/jar_controller.dart';
import 'package:jar_of_hearts/screens/home/home.dart';
import 'package:jar_of_hearts/utils/dialogs.dart';

class PreviewSecondScreen extends StatefulWidget {
  const PreviewSecondScreen({Key? key}) : super(key: key);

  @override
  _TestPageState createState() => _TestPageState();
}

class _TestPageState extends State<PreviewSecondScreen> {
  final jarController = Get.put(JarController());

  Color? bgColor;
  List<Color>? bgGradient;
  String? bgImage;

  Color? cardBgColor;
  List<Color>? cardBgGradient;
  String? cardBgImage;

  List<Color>? cardBorderBgGradient;
  @override
  void initState() {
    try {
      if (jarController.currentJar['pages']?[0]?['sound'] != null) {
        AudioController.secondPlayer.stop();
        AudioController.secondPlayer
            .play(UrlSource(jarController.currentJar['pages']?[0]?['sound']));
      }
    } catch (e) {
      // TODO
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
      ),
      extendBodyBehindAppBar: true,
      body: Obx(() {
        if (jarController.currentJar['bgColor'] != null) {
          bgColor = Color(jarController.currentJar['bgColor']);
        } else {
          bgColor = null;
        }
        if (jarController.currentJar['bgGradient'] != null) {
          List gradient = jarController.currentJar['bgGradient'];
          bgGradient = gradient.map((e) => Color(e)).toList();
        } else {
          bgGradient = null;
        }
        if (jarController.currentJar['bgImage'] != null) {
          bgImage = jarController.currentJar['bgImage'];
        } else {
          bgImage = null;
        }

        /// CARD

        if (jarController.currentJar['cardBgColor'] != null) {
          cardBgColor = Color(jarController.currentJar['cardBgColor']);
        } else {
          cardBgColor = null;
        }

        if (jarController.currentJar['cardBgGradient'] != null) {
          ///  print('GRADEDDD');
          List gradient = jarController.currentJar['cardBgGradient'];
          cardBgGradient = gradient.map((e) => Color(e)).toList();
        } else {
          cardBgGradient = null;
        }

        if (jarController.currentJar['bgCardBorderGradient'] != null) {
          List gradient = jarController.currentJar['bgCardBorderGradient'];
          cardBorderBgGradient = gradient.map((e) => Color(e)).toList();
        } else {
          cardBorderBgGradient = null;
        }
        if (jarController.currentJar['cardBgImage'] != null) {
          cardBgImage = jarController.currentJar['cardBgImage'];
        } else {
          cardBgImage = null;
        }
        return Container(
          alignment: Alignment.center,
          decoration: BoxDecoration(
            gradient: bgGradient != null
                ? LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: bgGradient!,
                  )
                : null,
            color: bgColor,
            image: bgImage != null
                ? DecorationImage(
                    image: NetworkImage(bgImage!),
                    fit: BoxFit.cover,
                  )
                : null,
          ),
          child: Swiper(
            itemCount: jarController.currentJar['pages'].length + 1,
            autoplay: false,
            loop: false,
            control: const SwiperControl(),
            physics: const BouncingScrollPhysics(),
            scrollDirection: Axis.horizontal,
            viewportFraction: 0.8,
            index: jarController.currentIndex.value,
            onIndexChanged: (i) {
              jarController.currentIndex.value = i;

              try {
                AudioController.secondPlayer.stop();
                AudioController.secondPlayer.play(
                    UrlSource(jarController.currentJar['pages']?[i]?['sound']));
              } catch (e) {
                // TODO
              }
            },
            scale: 0.8,
            itemBuilder: (context, index) {
              if (index == (jarController.currentJar['pages'] as List).length) {
                return InkWell(
                  onTap: () async {
                    ClipboardData data =
                        ClipboardData(text: jarController.currentJar['_id']);
                    await Clipboard.setData(data);
                    Dialogs.showSnackBar('Link copied to clipboard');
                    AudioController.player.stop();
                    AudioController.secondPlayer.stop();
                    Get.offAll(() => const HomeScreen());
                  },
                  child: Container(
                    margin: EdgeInsets.only(
                      top: MediaQuery.of(context).size.height * 0.10,
                      bottom: MediaQuery.of(context).size.height * 0.10,
                    ),
                    padding: const EdgeInsets.all(30),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      border: cardBorderBgGradient != null
                          ? GradientBoxBorder(
                              gradient: LinearGradient(
                                begin: Alignment.topLeft,
                                end: Alignment.bottomRight,
                                colors: cardBorderBgGradient!,
                              ),
                              width: 3,
                            )
                          : null,
                      image: cardBgImage != null
                          ? DecorationImage(
                              image: NetworkImage(cardBgImage!),
                              fit: BoxFit.cover,
                            )
                          : null,
                      gradient: cardBgGradient != null
                          ? LinearGradient(
                              begin: Alignment.topLeft,
                              end: Alignment.bottomRight,
                              colors: cardBgGradient!,
                            )
                          : null,
                      color: cardBgColor,
                    ),
                    child: Center(
                      child: Text(
                        'Click to copy link and go back to home screen',
                        style: jarController.currentJar['font'] == null
                            ? TextStyle(
                                fontSize: 32.0,
                                fontWeight: FontWeight.bold,
                                color: jarController.currentJar['textColor'] ==
                                        null
                                    ? const Color(0xffA1C6EA)
                                    : Color(
                                        jarController.currentJar['textColor'],
                                      ),
                              )
                            : GoogleFonts.getFont(
                                jarController.currentJar['font'],
                                fontSize: 32.0,
                                fontWeight: FontWeight.bold,
                                color: jarController.currentJar['textColor'] ==
                                        null
                                    ? const Color(0xffA1C6EA)
                                    : Color(
                                        jarController.currentJar['textColor'],
                                      ),
                              ),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ),
                );
              } else {
                return Container(
                  padding: const EdgeInsets.all(30),
                  margin: EdgeInsets.only(
                    top: MediaQuery.of(context).size.height * 0.10,
                    bottom: MediaQuery.of(context).size.height * 0.10,
                  ),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    border: cardBorderBgGradient != null
                        ? GradientBoxBorder(
                            gradient: LinearGradient(
                              begin: Alignment.topLeft,
                              end: Alignment.bottomRight,
                              colors: cardBorderBgGradient!,
                            ),
                            width: 3,
                          )
                        : null,
                    gradient: cardBgGradient != null
                        ? LinearGradient(
                            begin: Alignment.topLeft,
                            end: Alignment.bottomRight,
                            colors: cardBgGradient!,
                          )
                        : null,
                    color: cardBgColor,
                    image: jarController.currentJar['pages']?[index]
                                ?['image'] !=
                            null
                        ? DecorationImage(
                            image: NetworkImage(jarController
                                .currentJar['pages'][index]['image']),
                            fit: BoxFit.cover,
                          )
                        : cardBgImage != null
                            ? DecorationImage(
                                image: NetworkImage(cardBgImage!),
                                fit: BoxFit.cover,
                              )
                            : null,
                  ),
                  child: Center(
                    child: Text(
                      '${jarController.currentJar['pages']?[index]?['text'] ?? ''}',
                      style: jarController.currentJar['font'] == null
                          ? TextStyle(
                              fontSize: 32.0,
                              fontWeight: FontWeight.bold,
                              color:
                                  jarController.currentJar['textColor'] == null
                                      ? const Color(0xffA1C6EA)
                                      : Color(
                                          jarController.currentJar['textColor'],
                                        ),
                            )
                          : GoogleFonts.getFont(
                              jarController.currentJar['font'],
                              fontSize: 32.0,
                              fontWeight: FontWeight.bold,
                              color:
                                  jarController.currentJar['textColor'] == null
                                      ? const Color(0xffA1C6EA)
                                      : Color(
                                          jarController.currentJar['textColor'],
                                        ),
                            ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                );
              }
            },
          ),
        );
      }),
    );
  }
}
