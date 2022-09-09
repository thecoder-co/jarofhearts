import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:jar_of_hearts/controllers/jar_controller.dart';
import 'package:jar_of_hearts/screens/edit_jar/widgets/bg_editor/pick_gradient.dart';
import 'package:jar_of_hearts/screens/home/widgets/sizedboxes.dart';
import 'package:jar_of_hearts/utils/size.dart';

class PickFont extends StatefulWidget {
  const PickFont({Key? key}) : super(key: key);

  @override
  State<PickFont> createState() => _EditTextState();
}

class _EditTextState extends State<PickFont> {
  final fonts = GoogleFonts.asMap().keys.toList();
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
              const Back(),
              const Height(10),
              const Text(
                'Pick font',
                style: TextStyle(color: Colors.white),
              ),
              const SizedBox(
                height: 20,
              ),
              Expanded(
                child: ListView.separated(
                  itemCount: fonts.length,
                  separatorBuilder: (ctx, _) {
                    return const Divider(
                      color: Colors.grey,
                      height: 1,
                    );
                  },
                  itemBuilder: (ctx, i) {
                    return ListTile(
                      title: Text(
                        fonts[i],
                        style: GoogleFonts.getFont(
                          fonts[i],
                          color: Colors.grey[300],
                        ),
                      ),
                      onTap: () {
                        jarController.currentJar['font'] = fonts[i];

                        jarController.currentJar.refresh();
                        Get.back();
                      },
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
