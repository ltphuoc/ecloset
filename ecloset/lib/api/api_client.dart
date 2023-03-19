import 'dart:typed_data';
import 'package:http/http.dart' as http;

List<String> apiKeys = [];

class ApiCLient {
  Future<Uint8List> removeBgApi(String imagePath) async {
    var request = http.MultipartRequest(
        "POST", Uri.parse("https://api.remove.bg/v1.0/removebg"));
    request.files
        .add(await http.MultipartFile.fromPath("image_file", imagePath));
    request.headers.addAll(
        {"X-API-Key": apiKeys.first}); // Use the first API key in the list
    final response = await request.send();

    if (response.statusCode != 200) {
      for (int i = 1; i < apiKeys.length; i++) {
        request.headers.remove("X-API-Key");
        request.headers.addAll({"X-API-Key": apiKeys[i]});
        final response = await request.send();
        if (response.statusCode == 200) {
          break;
        }
      }
    }

    if (response.statusCode == 200) {
      http.Response imgRes = await http.Response.fromStream(response);
      return imgRes.bodyBytes;
    } else {
      throw Exception("Error occurred with response ${response.statusCode}");
    }
  }
}

const baseUrl = "https://ecloset.api.smjle.vn/";
