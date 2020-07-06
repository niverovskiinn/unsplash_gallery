import 'dart:convert' as convert;
import 'dart:io';

import 'package:http/http.dart' as http;
import 'package:unsplash_gallery/config/constants.dart' as Constants;
import 'package:unsplash_gallery/models/unsplash_image.dart';

class DataService {
  Future<List<UnsplashImage>> fetchUnsplashImages() async {
    print("Images request sent");
    final response = await http.get(Constants.apiUrl);
    if (response.statusCode == 200) {
      List<dynamic> jsonList = convert.jsonDecode(response.body);
      return jsonList.map((image) => UnsplashImage.fromJson(image)).toList();
    } else {
      print(response);
      throw HttpException('Failed to load images.');
    }
  }
}
