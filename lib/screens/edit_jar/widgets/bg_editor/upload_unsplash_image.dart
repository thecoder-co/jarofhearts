import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:jar_of_hearts/controllers/jar_controller.dart';
import 'package:jar_of_hearts/screens/edit_jar/widgets/bg_editor/pick_gradient.dart';
import 'package:jar_of_hearts/screens/home/widgets/sizedboxes.dart';
import 'package:jar_of_hearts/utils/size.dart';
import 'package:jar_of_hearts/utils/upsplash.dart';
import 'package:unsplash_client/unsplash_client.dart';

class PickUpsplashImage extends StatefulWidget {
  const PickUpsplashImage({Key? key}) : super(key: key);

  @override
  State<PickUpsplashImage> createState() => _PickColorState();
}

class _PickColorState extends State<PickUpsplashImage> {
  final jarController = Get.put(JarController());
  final text = TextEditingController();
  @override
  void initState() {
    // TODO: implement initState
    scrollController.addListener(() async {
      if (scrollController.offset >=
              scrollController.position.maxScrollExtent &&
          !scrollController.position.outOfRange) {
        print('extent');
        page++;
        final imagesResponse = await Upsplash.client.search
            .photos(text.text, page: page, perPage: 30)
            .go();
        final images = <Photo>[];
        for (Photo i in imagesResponse.data?.results ?? []) {
          images.add(i);
        }
        setState(() {
          urls.addAll(images);
        });
      }
    });
  }

  int page = 1;

  final scrollController = ScrollController();

  List<Photo> urls = [];

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
                  controller: scrollController,
                  child: Column(
                    // crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Back(),
                      const Height(10),
                      TextFormField(
                        controller: text,
                        decoration: const InputDecoration(
                          labelText: 'Search',
                          icon: Icon(Icons.search),
                        ),
                        onFieldSubmitted: (v) async {
                          final imagesResponse = await Upsplash.client.search
                              .photos(v, perPage: 30)
                              .go();
                          final images = <Photo>[];
                          for (Photo i in imagesResponse.data?.results ?? []) {
                            images.add(i);
                          }
                          setState(() {
                            urls = images;
                          });
                        },
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      //GridView.builder(gridDelegate: gridDelegate, itemBuilder: itemBuilder)
                      GridView.count(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        mainAxisSpacing: 20,
                        crossAxisSpacing: 20,
                        childAspectRatio: 1,
                        crossAxisCount: 2,
                        children: List.generate(
                          urls.length,
                          (index) => InkWell(
                            onTap: () async {
                              await jarController.finishImage(
                                  url: urls[index].urls.regular.toString());
                              Upsplash.client.photos.download(urls[index].id);
                              Get.back();
                            },
                            child: Container(
                              height: 110,
                              width: 110,
                              alignment: Alignment.center,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(15),
                                border: Border.all(
                                  width: 2,
                                  color: Colors.transparent,
                                ),
                                image: DecorationImage(
                                  image: NetworkImage(
                                    urls[index].urls.small.toString(),
                                  ),
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
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
