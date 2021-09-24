import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:wallpaper_hup/data/data.dart';
import 'package:wallpaper_hup/model/wallpaper_model.dart';
import 'package:wallpaper_hup/widgets/widget.dart';
import 'package:http/http.dart' as https;

class Category extends StatefulWidget {
  final String categoryname;
  Category({required this.categoryname});

  @override
  _CategoryState createState() => _CategoryState();
}

class _CategoryState extends State<Category> {
  List<WallPaperModel> wallpaper = [];
  categoryWallPaper(String query) async {
    var response = await https.get(
        Uri.parse(
            "https://api.pexels.com/v1/search?query=$query&per_page=15&page=1"),
        headers: {
          'Authorization': apiKey,
        });

    Map<String, dynamic> jsonData = jsonDecode(response.body);
    jsonData['photos'].forEach((element) {
      WallPaperModel wallPaperModel = new WallPaperModel();
      wallPaperModel = WallPaperModel.formMap(element);
      wallpaper.add(wallPaperModel);
    });
    setState(() {});
  }

  @override
  void initState() {
    super.initState();
    categoryWallPaper(widget.categoryname);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: brandName(),
        elevation: 0.0,
      ),
      body: SingleChildScrollView(
        child: Container(
          child: Column(
            children: [
              SizedBox(
                height: 20,
              ),
              wallpaperList(wallpapers: wallpaper, context: context),
            ],
          ),
        ),
      ),
    );
  }
}
