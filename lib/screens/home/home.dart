import 'package:flutter/material.dart';
import 'package:jar_of_hearts/controllers/audio_controller.dart';
import 'package:jar_of_hearts/controllers/auth.dart';
import 'package:jar_of_hearts/controllers/jar_controller.dart';
import 'package:jar_of_hearts/screens/auth/login_screen.dart';
import 'package:jar_of_hearts/screens/home/widgets/add_jar_box.dart';
import 'package:jar_of_hearts/screens/home/widgets/invisible_expanded.dart';
import 'package:jar_of_hearts/screens/home/widgets/jar_box.dart';
import 'package:jar_of_hearts/utils/app_colors.dart';
import 'package:jar_of_hearts/utils/size.dart';
import 'package:get/get.dart';
import 'package:jar_of_hearts/utils/user_preference.dart';
import 'package:shimmer/shimmer.dart';

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
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            expandedHeight: WindowSize.height(context),
            title: Row(
              children: [
                const InvisibleExpandedHeader(
                  child: Text('Jar of Hearts!💜'),
                ),
                const Spacer(),
                InkWell(
                  onTap: () {
                    UserPreferences.clearData();
                    Get.offAll(() => const LoginScreen());
                  },
                  child: const Icon(Icons.person_off_sharp),
                ),
              ],
            ),
            automaticallyImplyLeading: false,
            centerTitle: false,
            flexibleSpace: FlexibleSpaceBar(
              //title: const Text('Available seats'),
              background: Container(
                padding: EdgeInsets.all(
                  MediaQuery.of(context).orientation == Orientation.portrait
                      ? 30
                      : 0,
                ),
                alignment: Alignment.center,
                decoration: const BoxDecoration(
                  gradient: AppColors.gradient,
                ),
                child: LayoutBuilder(builder: (context, constraints) {
                  String text = 'Jar of Hearts!💜';
                  var style = Theme.of(context).textTheme.headline1!;
                  return FittedBox(
                    fit: BoxFit.cover,
                    child: Text(
                      text,
                      style: style.copyWith(
                        fontSize: calculateAutoscaleFontSize(
                          text,
                          style,
                          30.0,
                          constraints.maxWidth,
                        ),
                      ),
                    ),
                  );
                }),
              ),
            ),
            pinned: true,
          ),
          Obx((() {
            if (jarController.profile['body'] == null) {
              return SliverToBoxAdapter(
                child: Wrap(
                  alignment: WrapAlignment.spaceEvenly,
                  children: List.generate(
                    100,
                    (index) => Shimmer.fromColors(
                      baseColor: Colors.grey,
                      highlightColor: Colors.grey[800]!,
                      child: Container(
                        height: 200,
                        width: 300,
                        decoration: BoxDecoration(
                          color: Colors.grey,
                          borderRadius: BorderRadius.circular(25),
                        ),
                      ),
                    ),
                  ),
                ),
              );
            } else {
              List? jars = jarController.profile['body']['jars'];

              return SliverToBoxAdapter(
                child: Wrap(
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
                ),
              );
            }
          })),
          SliverList(
            delegate: SliverChildBuilderDelegate(
              (ctx, i) {
                return const SizedBox(height: 10);
              },
            ),
          )
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
