// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:wallpaper_app/views/screens/CategoriesScreen.dart';

// ignore: must_be_immutable
class Categoriesblock extends StatelessWidget {
  String categoryName;
  String categoryImgSrc;
  Categoriesblock({
    super.key,
    required this.categoryName,
    required this.categoryImgSrc,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => CategoriesScreen(
                    catImgUrl: categoryImgSrc, catName: categoryName)));
      },
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 7),
        child: Stack(children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(12),
            child: Image.network(
                height: 52, width: 100, fit: BoxFit.cover, categoryImgSrc),
          ),
          Container(
            height: 50,
            width: 100,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12),
              color: const Color.fromARGB(28, 0, 0, 0),
            ),
          ),
          Positioned(
            left: 22,
            top: 10,
            child: Text(
              categoryName,
              style: const TextStyle(
                  fontSize: 17,
                  color: Colors.white,
                  fontWeight: FontWeight.w700),
            ),
          )
        ]),
      ),
    );
  }
}
