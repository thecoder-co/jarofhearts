import 'package:flutter/material.dart';
import 'package:jar_of_hearts/controllers/audio_controller.dart';
import 'package:jar_of_hearts/screens/edit_jar/page_view_screen.dart';
import 'package:jar_of_hearts/screens/edit_jar/widgets/second_editor.dart';
import 'package:jar_of_hearts/utils/size.dart';

class EditJarSecondPage extends StatefulWidget {
  const EditJarSecondPage({Key? key}) : super(key: key);

  @override
  State<EditJarSecondPage> createState() => _EditJarViewScreenStartState();
}

class _EditJarViewScreenStartState extends State<EditJarSecondPage> {
  @override
  void initState() {
    // TODO: implement initState
    AudioController.player.stop();
    AudioController.secondPlayer.stop();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    if (WindowSize.isLandscape(context)) {
      return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
        ),
        extendBodyBehindAppBar: true,
        body: Row(
          children: [
            SecondEditor(),
            const Expanded(child: SecondPageViewScreen()),
          ],
        ),
      );
    } else {
      return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
        ),
        extendBodyBehindAppBar: true,
        body: Column(
          children: [
            const Expanded(child: SecondPageViewScreen()),
            SecondEditor(),
          ],
        ),
      );
    }
  }
}
