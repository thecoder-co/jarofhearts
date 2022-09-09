import 'package:flutter/material.dart';
import 'package:jar_of_hearts/apis/get_jar.dart';
import 'package:jar_of_hearts/controllers/jar_controller.dart';
import 'package:get/get.dart';

class JarBox extends StatelessWidget {
  final String id;
  JarBox({
    Key? key,
    required this.id,
  }) : super(key: key);
  final jarController = Get.put(JarController());
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        jarController.editJar(id);
      },
      child: FutureBuilder(
        future: getJar(id: id),
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          if (snapshot.hasData) {
            Color? bgColor;
            List<Color>? bgGradient;
            String? bgImage;
            Map jar = snapshot.data['jar'];
            if (jar['bgColor'] != null) {
              bgColor = Color(jar['bgColor']);
            } else {
              bgColor = null;
            }
            if (jar['bgGradient'] != null) {
              List gradient = jar['bgGradient'];
              bgGradient = gradient.map((e) => Color(e)).toList();
            } else {
              bgGradient = null;
            }
            if (jar['bgImage'] != null) {
              bgImage = jar['bgImage'];
            } else {
              bgImage = null;
            }
            return Container(
              height: 200,
              width: 300,
              decoration: BoxDecoration(
                gradient: bgGradient != null
                    ? LinearGradient(
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                        colors: bgGradient,
                      )
                    : null,
                color: bgColor ?? const Color.fromARGB(255, 10, 4, 46),
                image: bgImage != null
                    ? DecorationImage(
                        image: NetworkImage(bgImage),
                        fit: BoxFit.cover,
                      )
                    : null,
                borderRadius: BorderRadius.circular(25),
              ),
              child: Center(
                child: Text(jar['name'] ?? '',
                    style: TextStyle(
                      fontSize: 20,
                      color: jar['textColor'] == null
                          ? const Color.fromARGB(255, 255, 255, 255)
                          : Color(
                              jar['textColor'],
                            ),
                    )),
              ),
            );
          } else {
            return Container(
              height: 200,
              width: 300,
              decoration: BoxDecoration(
                color: Colors.grey[300],
                borderRadius: BorderRadius.circular(25),
              ),
              child: const CircularProgressIndicator.adaptive(),
            );
          }
        },
      ),
    );
  }
}
