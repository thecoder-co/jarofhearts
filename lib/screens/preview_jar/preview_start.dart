import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:gradient_borders/gradient_borders.dart';
import 'package:jar_of_hearts/controllers/audio_controller.dart';
import 'package:jar_of_hearts/controllers/jar_controller.dart';
import 'package:jar_of_hearts/screens/preview_jar/preview_second.dart';
import 'package:jar_of_hearts/utils/size.dart';

class PreviewStart extends StatefulWidget {
  const PreviewStart({Key? key}) : super(key: key);

  @override
  State<PreviewStart> createState() => _EditStartViewState();
}

class _EditStartViewState extends State<PreviewStart> {
  double chgval = 50.0;
  final jarController = Get.put(JarController());
  final _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    if (jarController.currentJar['sound'] != null) {
      AudioController.player.play(UrlSource(jarController.currentJar['sound']));
      print('playing');
    }
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      if (!WindowSize.isLandscape(context)) {
        paddingSize = WindowSize.width(context) * 0.5 - 70;
      } else {
        paddingSize = (WindowSize.width(context) -
                    ((JarController.editorKey.currentContext!.findRenderObject()
                            as RenderBox?)!
                        .size
                        .width)) *
                0.5 -
            70;
      }
      setState(() {});
    });
  }

  double paddingSize = 0;

  Color? bgColor;
  List<Color>? bgGradient;
  String? bgImage;

  Color? cardBgColor;
  List<Color>? cardBgGradient;
  String? cardBgImage;

  List<Color>? cardBorderBgGradient;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
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

        if (jarController.currentJar['cardBgImage'] != null) {
          cardBgImage = jarController.currentJar['cardBgImage'];
        } else {
          cardBgImage = null;
        }
        if (jarController.currentJar['bgCardBorderGradient'] != null) {
          List gradient = jarController.currentJar['bgCardBorderGradient'];
          cardBorderBgGradient = gradient.map((e) => Color(e)).toList();
        } else {
          cardBorderBgGradient = null;
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
          child: Padding(
            padding: const EdgeInsets.only(
                top: 50.0, bottom: 50.0, left: 20, right: 20),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Expanded(
                  child: Container(
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
                      gradient: cardBgGradient != null
                          ? LinearGradient(
                              begin: Alignment.topLeft,
                              end: Alignment.bottomRight,
                              colors: cardBgGradient!,
                            )
                          : null,
                      color: cardBgColor,
                      image: cardBgImage != null
                          ? DecorationImage(
                              image: NetworkImage(cardBgImage!),
                              fit: BoxFit.cover,
                            )
                          : null,
                    ),
                    child: Center(
                      child: Text(
                        '${jarController.currentJar['name'] ?? ''}',
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
                ),
                const SizedBox(
                  height: 30,
                ),
                InkWell(
                  onTap: () {
                    jarController.currentIndex.value = 0;
                    Get.to(() => const PreviewSecondScreen());
                  },
                  child: Container(
                    decoration: BoxDecoration(
                      gradient: cardBgGradient != null
                          ? LinearGradient(
                              begin: Alignment.topLeft,
                              end: Alignment.bottomRight,
                              colors: cardBgGradient!,
                            )
                          : null,
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
                      color: cardBgColor,
                      image: cardBgImage != null
                          ? DecorationImage(
                              image: NetworkImage(cardBgImage!),
                              fit: BoxFit.cover,
                            )
                          : null,
                      borderRadius: BorderRadius.circular(20),
                    ),
                    alignment: Alignment.center,
                    padding: EdgeInsets.only(left: paddingSize),
                    height: 50,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Text(
                          'Start',
                          style: jarController.currentJar['font'] == null
                              ? TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                  color: jarController
                                              .currentJar['textColor'] ==
                                          null
                                      ? const Color(0xffA1C6EA)
                                      : Color(
                                          jarController.currentJar['textColor'],
                                        ),
                                )
                              : GoogleFonts.getFont(
                                  jarController.currentJar['font'],
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                  color: jarController
                                              .currentJar['textColor'] ==
                                          null
                                      ? const Color(0xffA1C6EA)
                                      : Color(
                                          jarController.currentJar['textColor'],
                                        ),
                                ),
                        ),
                        TweenAnimationBuilder<double>(
                          tween: Tween<double>(begin: 20, end: chgval),
                          duration: const Duration(milliseconds: 1000),
                          onEnd: () => setState(
                            () {
                              chgval = chgval == 20.0 ? 50.0 : 20.0;
                            },
                          ),
                          builder: (BuildContext context, double size,
                              Widget? child) {
                            return SizedBox(
                              width: size,
                            );
                          },
                        ),
                        Icon(
                          Icons.arrow_forward_ios_rounded,
                          color: jarController.currentJar['textColor'] == null
                              ? const Color(0xffA1C6EA)
                              : Color(
                                  jarController.currentJar['textColor'],
                                ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      }),
    );
  }
}
