import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as http;
import 'package:jar_of_hearts/utils/pretty_print.dart';
import 'package:jar_of_hearts/utils/string_exception.dart';
import 'package:jar_of_hearts/utils/urls.dart';

Future<Map> loginUserApi({
  required String username,
  required String password,
}) async {
  try {
    Uri url = Uri.parse("${AppUrls.baseUrl}/login");

    http.Response response = await http
        .post(
          url,
          headers: {"Content-Type": "application/json"},
          body: json.encode({"username": username, "password": password}),
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
