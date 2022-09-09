import 'package:flutter/material.dart';
import 'package:jar_of_hearts/controllers/audio_controller.dart';
import 'package:jar_of_hearts/screens/edit_jar/start_view_screen.dart';
import 'package:jar_of_hearts/screens/edit_jar/widgets/landscape_start_editor.dart';
import 'package:jar_of_hearts/screens/edit_jar/widgets/portrait_start_editor.dart';
import 'package:jar_of_hearts/utils/size.dart';

class EditJarViewScreenStart extends StatefulWidget {
  const EditJarViewScreenStart({Key? key}) : super(key: key);

  @override
  State<EditJarViewScreenStart> createState() => _EditJarViewScreenStartState();
}

class _EditJarViewScreenStartState extends State<EditJarViewScreenStart> {
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
            LandScapeJarEditor(),
            const Expanded(child: EditStartView()),
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
            const Expanded(child: EditStartView()),
            PortraitJarEditor(),
          ],
        ),
      );
    }
  }
}
