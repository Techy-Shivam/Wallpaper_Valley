// ignore_for_file: avoid_unnecessary_containers

import 'package:flutter/material.dart';
import 'package:wallpaper_app/views/screens/SearchScreen.dart';

// ignore: must_be_immutable
class Searchbar extends StatelessWidget {
  Searchbar({super.key});

  TextEditingController search = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      margin: const EdgeInsets.all(10),
      decoration: BoxDecoration(
          color: const Color.fromARGB(66, 192, 192, 192),
          border: Border.all(color: Colors.black),
          borderRadius: BorderRadius.circular(25)),
      child: TextFormField(
        controller: search,
        style: const TextStyle(color: Colors.black, fontSize: 19),
        decoration: InputDecoration(
            errorBorder: InputBorder.none,
            focusedBorder: InputBorder.none,
            focusedErrorBorder: InputBorder.none,
            disabledBorder: InputBorder.none,
            enabledBorder: InputBorder.none,
            border: InputBorder.none,
            hintText: 'Search Wallpapers',
            hintStyle: const TextStyle(
                fontSize: 19, color: Color.fromARGB(255, 121, 121, 121)),
            suffixIcon: IconButton(
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => SearchScreen(query: search.text)));
              },
              icon: const Icon(Icons.search),
              iconSize: 24,
              color: Colors.black,
            )),
      ),
    );
  }
}
