import 'package:unsplash_client/unsplash_client.dart';

class Upsplash {
  static final client = UnsplashClient(
    settings: const ClientSettings(
        credentials: AppCredentials(
      accessKey: String.fromEnvironment('UPSPLASH_ACCESS_KEY'),
      secretKey: String.fromEnvironment('UPSPLASH_SECRET_KEY'),
    )),
  );
}
