import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:wallpaper_app/controller/apiOperation.dart';
import 'package:wallpaper_app/controller/permissionhandler.dart';
import 'package:wallpaper_app/model/CategoryModel.dart';
import 'package:wallpaper_app/model/PhotosModel.dart';
import 'package:wallpaper_app/views/screens/fullScreen.dart';
import 'package:wallpaper_app/views/widgets/categoriesBlock.dart';
import 'package:wallpaper_app/views/widgets/customAppBar.dart';
import 'package:wallpaper_app/views/widgets/searchbar.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  List<Photosmodel> photosList = [];

  List<CategoryModel> CatModList = [];
  bool isLoading = true;

  GetCatDetails() async {
    CatModList = await ApiOperations.getCategoriesList();
    setState(() {
      CatModList = CatModList;
    });
  }

  getTrendingWallpaper() async {
    photosList = await ApiOperations.getTrendingWallpapers();
    setState(() {});
  }

  @override
  void initState() {
    super.initState();
    GetCatDetails();
    getTrendingWallpaper();
    requestStoragePermission();
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
          ZoomIn(child: Searchbar()),
          FadeInLeft(
            child: Container(
              margin: const EdgeInsets.symmetric(vertical: 10),
              child: SizedBox(
                height: 60,
                width: MediaQuery.of(context).size.width,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: CatModList.length,
                  itemBuilder: (context, index) => Categoriesblock(
                    categoryImgSrc: CatModList[index].catImgUrl,
                    categoryName: CatModList[index].catName,
                  ),
                ),
              ),
            ),
          ),
          Expanded(
            // Use Expanded to make sure GridView takes up remaining space
            child: SlideInDown(
              child: Container(
                margin: const EdgeInsets.symmetric(horizontal: 10),
                child: GridView.builder(
                  physics: const BouncingScrollPhysics(),
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      mainAxisExtent: 400,
                      crossAxisCount: 2,
                      crossAxisSpacing: 15,
                      mainAxisSpacing: 10),
                  itemCount: photosList.length,
                  itemBuilder: (context, index) {
                    return InkWell(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => Fullscreen(
                              imgUrl: photosList[index].imgSrc,
                            ),
                          ),
                        );
                      },
                      child: Hero(
                        tag: photosList[index].imgSrc,
                        child: Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20),
                            color: Colors.blue,
                          ),
                          height: 500,
                          width: 60,
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(20),
                            child: Image.network(
                              fit: BoxFit.cover,
                              photosList[index].imgSrc,
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
