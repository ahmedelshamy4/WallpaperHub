import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:wallpaper_hup/data/data.dart';
import 'package:wallpaper_hup/model/category.dart';
import 'package:wallpaper_hup/model/wallpaper_model.dart';
import 'package:wallpaper_hup/views/search.dart';
import 'package:wallpaper_hup/widgets/widget.dart';
import 'package:http/http.dart' as https;

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  List<CategoriesModel> categories = [];
  List<WallPaperModel> wallpaper = [];
  TextEditingController searchController = TextEditingController();
  @override
  void initState() {
    super.initState();
    getTrendingWallPaper("curated");
    categories = getCategories();
  }

  getTrendingWallPaper(String query) async {
    var response = await https.get(
        Uri.parse("https://api.pexels.com/v1/$query?per_page=15&page=1"),
        headers: {
          'Authorization': apiKey,
        });
    //print(response.body.toString());
    Map<String, dynamic> jsonData = jsonDecode(response.body);
    jsonData['photos'].forEach((element) {
      // print(element);
      WallPaperModel wallPaperModel = new WallPaperModel();
      wallPaperModel = WallPaperModel.formMap(element);
      wallpaper.add(wallPaperModel);
    });
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: brandName(),
        elevation: 0.0,
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Container(
          child: Column(
            children: [
              Container(
                decoration: BoxDecoration(
                  color: Color(0xfff5f8fd),
                  borderRadius: BorderRadius.circular(30),
                ),
                padding: EdgeInsets.symmetric(horizontal: 20),
                margin: EdgeInsets.symmetric(horizontal: 24),
                child: Row(
                  children: [
                    Expanded(
                      child: TextField(
                        controller: searchController,
                        decoration: InputDecoration(
                          hintText: 'Search',
                          border: InputBorder.none,
                        ),
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => Search(
                                searchQury: searchController.text,
                              ),
                            ));
                      },
                      child: Container(
                        child: Icon(Icons.search),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 16),
              Container(
                height: 80,
                padding: EdgeInsets.symmetric(horizontal: 24),
                child: ListView.builder(
                  itemCount: categories.length,
                  shrinkWrap: true,
                  scrollDirection: Axis.horizontal,
                  itemBuilder: (context, index) {
                    return CategorisTile(
                      imageurl: categories[index].imageAssetUrl,
                      title: categories[index].categorieName,
                    );
                  },
                ),
              ),
              wallpaperList(
                wallpapers: wallpaper,
                context: context,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
