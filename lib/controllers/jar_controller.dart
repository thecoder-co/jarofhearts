import 'package:cloudinary_public/cloudinary_public.dart';
import 'package:file_picker/file_picker.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:jar_of_hearts/apis/create_jar.dart';
import 'package:jar_of_hearts/apis/edit_jar.dart';
import 'package:jar_of_hearts/apis/get_jar.dart';
import 'package:jar_of_hearts/apis/get_profile.dart';
import 'package:jar_of_hearts/apis/upload_image.dart';
import 'package:jar_of_hearts/apis/upload_sound.dart';
import 'package:jar_of_hearts/screens/edit_jar/edit_jar_page.dart';
import 'package:jar_of_hearts/utils/dialogs.dart';
import 'package:jar_of_hearts/utils/string_exception.dart';
import 'package:flutter/material.dart';
import 'package:collection/collection.dart';

class JarController extends GetxController {
  var profile = {}.obs;
  var currentJar = {}.obs;
  var currentIndex = 0.obs;
  static final editorKey = GlobalKey();
  static final editorSecondKey = GlobalKey();

  final cloudinary = CloudinaryPublic('dahba1joi', 'hsxp50rg', cache: false);
  final ImagePicker _picker = ImagePicker();

  @override
  void onInit() {
    // TODO: implement onInit
    fetchProfile();
    ever(currentJar, (_) {
      print(currentJar);

      editJarDb(jarId: currentJar["_id"], jar: currentJar);
    });
  }

  Future<void> saveEdit() async {
    await editJarDb(jarId: currentJar["_id"], jar: currentJar);
  }

  Future finishImage({String? url}) async {
    Dialogs.loadDialog();

    try {
      if (url == null) {
        List<String?>? path = await selectFromGallery();

        if (path == null) {
          return;
        }

        for (var i in path) {
          if (i != null) {
            CloudinaryResponse response = await cloudinary.uploadFile(
              CloudinaryFile.fromFile(
                i,
                resourceType: CloudinaryResourceType.Image,
              ),
            );
            await createImage(imageUrl: response.secureUrl);
          }
        }
      } else {
        await createImage(imageUrl: url);
      }

      await fetchProfile();
      Get.back();
    } on Exception {
      Get.back();
      Dialogs.showErrorSnackBar('Could not upload image');
    }
  }

  finishSound() async {
    Dialogs.loadDialog();

    try {
      String? path = await selectSound();

      if (path == null) {
        return;
      }
      CloudinaryResponse response = await cloudinary.uploadFile(
        CloudinaryFile.fromFile(
          path,
          resourceType: CloudinaryResourceType.Auto,
        ),
      );
      await createAudio(
        audioUrl: response.secureUrl,
        name: path.split('/').last.split('.').first,
      );
      await fetchProfile();
      Get.back();
    } on Exception {
      Get.back();
      Dialogs.showErrorSnackBar('Could not upload sound');
    }
  }

  Future<String?> selectSound() async {
    FilePickerResult? xImageFile = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['aac', 'mp3', 'wav', 'wma', 'ogg'],
    );
    return xImageFile?.files.firstOrNull?.path;
  }

  Future<List<String?>?> selectFromGallery() async {
    if (GetPlatform.isIOS || GetPlatform.isWeb) {
      final xImageFile = await _picker.pickImage(
        source: ImageSource.gallery,
        maxHeight: 400,
        maxWidth: 400,
      );
      return [if (xImageFile?.path != null) xImageFile!.path];
    } else {
      FilePickerResult? xImageFile = await FilePicker.platform.pickFiles(
        type: FileType.custom,
        allowMultiple: true,
        allowedExtensions: ['jpg', 'png', 'gif'],
      );
      return xImageFile?.files.map<String?>((e) => e.path).toList();
    }
  }

  void editJar(String id) async {
    Dialogs.loadDialog();

    try {
      currentJar.value = (await getJar(id: id))['jar'];
      // print("GRADIENTT: ${currentJar['bgGradient']} ");
      // fetchProfile();
      Get.back();
      Get.to(() => const EditJarViewScreenStart());
    } on StringException catch (e) {
      Get.back();
      Dialogs.showErrorSnackBar(e.toString());
      //rethrow;
    } catch (e) {
      Get.back();
      rethrow;
    }
  }

  Future<void> createJarAndEnter() async {
    Dialogs.loadDialog();
    try {
      currentJar.value = (await createJar())['jar'];
      fetchProfile();
      Get.back();
      Get.to(() => const EditJarViewScreenStart());
    } on StringException catch (e) {
      Get.back();
      Dialogs.showErrorSnackBar(e.toString());
      //rethrow;
    } catch (e) {
      Get.back();
      rethrow;
    }
  }

  Future<void> fetchProfile() async {
    profile.value = await getProfile();
    profile.refresh();
  }
}
