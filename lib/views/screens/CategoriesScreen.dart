import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:wallpaper_app/controller/apiOperation.dart';
import 'package:wallpaper_app/model/PhotosModel.dart';
import 'package:wallpaper_app/views/screens/fullScreen.dart';
import 'package:wallpaper_app/views/widgets/customAppBar.dart';

// ignore: must_be_immutable
class CategoriesScreen extends StatefulWidget {
  String catName;
  String catImgUrl;

  CategoriesScreen({
    super.key,
    required this.catName,
    required this.catImgUrl,
  });

  @override
  State<CategoriesScreen> createState() => _CategoriesScreenState();
}

class _CategoriesScreenState extends State<CategoriesScreen> {
  List<Photosmodel> categoryResults = [];
  bool isLoading = true;

  GetCatRelWall() async {
    categoryResults = await ApiOperations.searchWallpapers(widget.catName);

    setState(() {
      isLoading = false;
    });
  }

  @override
  void initState() {
    GetCatRelWall();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        flexibleSpace: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              colors: [
                Color.fromARGB(255, 77, 77, 77),
                Color.fromARGB(255, 9, 9, 9),
              ],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          ),
        ),
        title: const Customappbar(),
        centerTitle: true,
      ),
      body: Column(
        children: [
          const SizedBox(height: 10),
          ZoomIn(
            child: Stack(
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: Image.network(
                    height: 120,
                    width: MediaQuery.of(context).size.width,
                    fit: BoxFit.cover,
                    widget.catImgUrl,
                  ),
                ),
                Container(
                  height: 120,
                  width: MediaQuery.of(context).size.width,
                  color: const Color.fromARGB(51, 0, 0, 0),
                ),
                Positioned(
                  left: 155,
                  top: 15,
                  child: Column(
                    children: [
                      const Text(
                        "Categories",
                        style: TextStyle(
                            fontSize: 20,
                            color: Colors.white,
                            fontWeight: FontWeight.w500),
                      ),
                      Text(
                        widget.catName,
                        style: const TextStyle(
                            fontSize: 30,
                            color: Colors.white,
                            fontWeight: FontWeight.w700),
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
          const SizedBox(height: 10),
          Expanded(
            // Expanded to allow GridView to take available space
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: SlideInUp(
                child: GridView.builder(
                  physics: const BouncingScrollPhysics(),
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    mainAxisExtent: 400,
                    crossAxisCount: 2,
                    crossAxisSpacing: 15,
                    mainAxisSpacing: 10,
                  ),
                  itemCount: categoryResults.length,
                  itemBuilder: (context, index) {
                    return InkWell(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => Fullscreen(
                                imgUrl: categoryResults[index].imgSrc),
                          ),
                        );
                      },
                      child: Hero(
                        tag: categoryResults[index].imgSrc,
                        child: Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20),
                            color: Colors.blue,
                          ),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(20),
                            child: Image.network(
                              fit: BoxFit.cover,
                              categoryResults[index].imgSrc,
                            ),
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
