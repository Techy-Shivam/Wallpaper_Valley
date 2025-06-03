// ignore_for_file: file_names, avoid_function_literals_in_foreach_calls
import 'dart:convert';
import 'dart:math';
import 'package:http/http.dart' as http;
import 'package:wallpaper_app/model/CategoryModel.dart';
import 'package:wallpaper_app/model/PhotosModel.dart';

class ApiOperations {
  static List<Photosmodel> trendingWallpapers = [];
  static List<Photosmodel> searchWallpapersList = [];
  static List<CategoryModel> categoryModelList = [];
  static Future<List<Photosmodel>> getTrendingWallpapers() async {
    await http.get(Uri.parse('https://api.pexels.com/v1/curated'), headers: {
      "Authorization":
          "qjoSzIlvJ81LVvyp3bJWMycvs9iwufYPk12uJVzIxvhqVdHBrnZcEpKT"
    }).then((value) {
      Map<String, dynamic> jsonData = jsonDecode(value.body);
      List photos = jsonData['photos'];
      photos.forEach((element) {
        trendingWallpapers.add(Photosmodel.fromApi2App(element));
      });
    });
    return trendingWallpapers;
  }

  static Future<List<Photosmodel>> searchWallpapers(String query) async {
    await http.get(Uri.parse("https://api.pexels.com/v1/search?query=$query&per_page=30&page=1"),
        headers: {
          "Authorization": "qjoSzIlvJ81LVvyp3bJWMycvs9iwufYPk12uJVzIxvhqVdHBrnZcEpKT"  
        }).then((value) {
      Map<String, dynamic> jsonData = jsonDecode(value.body);
      List photos = jsonData['photos'];
      searchWallpapersList.clear();
      photos.forEach((element) {
        searchWallpapersList.add(Photosmodel.fromApi2App(element));
      });
    });
    return searchWallpapersList;
  }

  static List<CategoryModel> getCategoriesList() {
    List cateogryName = ["Cars", "Nature", "Bikes", "Neon", "City", "Flowers"];
    categoryModelList.clear();
    cateogryName.forEach((catName) async {
      final random = Random();

      Photosmodel photoModel =
          (await searchWallpapers(catName))[0 + random.nextInt(11 - 0)];
      print("IMG SRC IS HERE");
      print(photoModel.imgSrc);
      categoryModelList
          .add(CategoryModel(catImgUrl: photoModel.imgSrc, catName: catName));
    });

    return categoryModelList;
  }
}
