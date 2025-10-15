import 'dart:typed_data';

import 'package:cloudinary_sdk/cloudinary_sdk.dart';

class CloudinarySdk {
  static final cloudinary = Cloudinary.full(
    apiKey: const String.fromEnvironment('CLOUDINARY_API_KEY'),
    apiSecret: const String.fromEnvironment('CLOUDINARY_API_SECRET'),
    cloudName: const String.fromEnvironment('CLOUDINARY_API_CLOUDNAME'),
  );

  static Future<String?> uploadFile({required Uint8List fileBytes}) async {
    final response =
        await cloudinary.unsignedUploadResource(CloudinaryUploadResource(
      uploadPreset:
          const String.fromEnvironment('CLOUDINARY_API_UPLOAD_PRESET'),
      fileBytes: fileBytes,
      resourceType: CloudinaryResourceType.raw,
    ));

    return response.secureUrl;
  }
}
