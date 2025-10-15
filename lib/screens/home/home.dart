import 'package:flutter/material.dart';
import 'package:jar_of_hearts/controllers/audio_controller.dart';
import 'package:jar_of_hearts/controllers/auth.dart';
import 'package:jar_of_hearts/controllers/jar_controller.dart';
import 'package:jar_of_hearts/screens/auth/login_screen.dart';
import 'package:jar_of_hearts/screens/home/widgets/add_jar_box.dart';
import 'package:jar_of_hearts/screens/home/widgets/jar_box.dart';
import 'package:jar_of_hearts/screens/home/widgets/sizedboxes.dart';
import 'package:jar_of_hearts/utils/app_colors.dart';
import 'package:jar_of_hearts/utils/size.dart';
import 'package:get/get.dart';
import 'package:jar_of_hearts/utils/user_preference.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final jarController = Get.put(JarController());
  final authController = Get.put(AuthController());

  @override
  void initState() {
    jarController.fetchProfile();
    AudioController.player.stop();
    //UserPreferences.clearData();
    AudioController.secondPlayer.stop();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        children: [
          Stack(
            alignment: Alignment.topRight,
            children: [
              Container(
                width: WindowSize.width(context),
                height: WindowSize.height(context),
                padding: EdgeInsets.all(
                  MediaQuery.of(context).orientation == Orientation.portrait
                      ? 30
                      : 0,
                ),
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  gradient: AppColors.gradient,
                ),
                child: LayoutBuilder(builder: (context, constraints) {
                  String text = 'Jar of Hearts!💜';
                  var style = Theme.of(context).textTheme.headlineLarge!;
                  return FittedBox(
                    fit: BoxFit.cover,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          text,
                          style: style.copyWith(
                            fontSize: calculateAutoscaleFontSize(
                              text,
                              style,
                              30.0,
                              constraints.maxWidth - 60,
                            ),
                          ),
                        ),
                        //const Height(20),
                        SizedBox(
                          width: WindowSize.width(context) / 1.5,
                          child: const Text(
                            'Create online greeting cards for your loved ones with dynamic images, audio and colourful backgrounds.',
                            textAlign: TextAlign.center,
                          ),
                        )
                      ],
                    ),
                  );
                }),
              ),
              InkWell(
                onTap: () {
                  UserPreferences.clearData();
                  Get.offAll(() => const LoginScreen());
                },
                child: const Padding(
                  padding: EdgeInsets.all(10.0),
                  child: Icon(Icons.person_off_sharp),
                ),
              ),
            ],
          ),
          const Height(20),
          Obx((() {
            if (jarController.profile['body'] == null) {
              return Wrap(
                alignment: WrapAlignment.spaceEvenly,
                children: List.generate(
                  4,
                  (index) => Container(
                    height: 200,
                    width: 300,
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      color: Colors.grey,
                      borderRadius: BorderRadius.circular(25),
                    ),
                    child: const CircularProgressIndicator.adaptive(),
                  ),
                ),
              );
            } else {
              List? jars = jarController.profile['body']['jars'];

              return Wrap(
                runSpacing: 25,
                alignment: WrapAlignment.spaceEvenly,
                children: List.generate(
                  (jars?.length ?? 0) + 1,
                  (index) {
                    if (index == 0) {
                      return AddJarBox();
                    }
                    return JarBox(id: jars![index - 1]['_id']);
                  },
                ),
              );
            }
          })),
        ],
      ),
    );
  }
}

double calculateAutoscaleFontSize(
    String text, TextStyle style, double startFontSize, double maxWidth) {
  final textPainter = TextPainter(textDirection: TextDirection.ltr);
  var currentFontSize = startFontSize;
  for (var i = 0; i < 100; i++) {
    // limit max iterations to 100
    final nextFontSize = currentFontSize + 1;
    final nextTextStyle = style.copyWith(fontSize: nextFontSize);
    textPainter.text = TextSpan(text: text, style: nextTextStyle);
    textPainter.layout();
    if (textPainter.width >= maxWidth) {
      break;
    } else {
      currentFontSize = nextFontSize;
      // continue iteration
    }
  }
  return currentFontSize;
}
