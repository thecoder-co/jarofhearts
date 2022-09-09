import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as http;
import 'package:jar_of_hearts/utils/pretty_print.dart';
import 'package:jar_of_hearts/utils/string_exception.dart';
import 'package:jar_of_hearts/utils/urls.dart';
import 'package:jar_of_hearts/utils/user_preference.dart';

Future<Map> getJar({required String id}) async {
  try {
    Uri url = Uri.parse("${AppUrls.baseUrl}/retrieve_jar");

    http.Response response = await http
        .post(
          url,
          headers: {
            "Content-Type": "application/json",
            "Authorization": "Bearer ${UserPreferences.getToken()}"
          },
          body: json.encode({"jar_id": id}),
        )
        .timeout(const Duration(seconds: 60));

    prettyPrintJson(response.body);
    Map data = json.decode(response.body);

    if (response.statusCode == 200) {
      return data;
    } else {
      throw StringException(data['message']);
    }
  } on TimeoutException {
    throw StringException('Request timed out. Please try again');
  } on SocketException {
    throw StringException('Please check your internet connection');
  }
}
