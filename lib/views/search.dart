import 'package:flutter/material.dart';
import 'package:wallpaper_hup/data/data.dart';
import 'package:wallpaper_hup/model/wallpaper_model.dart';
import 'package:wallpaper_hup/widgets/widget.dart';
import 'package:http/http.dart' as https;
import 'dart:convert';
import 'package:wallpaper_hup/widgets/widget.dart';

class Search extends StatefulWidget {
  final searchQury;
  Search({this.searchQury});

  @override
  _SearchState createState() => _SearchState();
}

class _SearchState extends State<Search> {
  List<WallPaperModel> wallpaper = [];
  TextEditingController searchController = TextEditingController();
  searchWallPaper(String query) async {
    var response = await https.get(
        Uri.parse(
            "https://api.pexels.com/v1/search?query=$query&per_page=15&page=1"),
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
  void initState() {
    super.initState();
    searchWallPaper(widget.searchQury);
    searchController.text = widget.searchQury;
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
              Container(
                decoration: BoxDecoration(
                  color: Color(0xfff5f8fd),
                  borderRadius: BorderRadius.circular(30),
                ),
                margin: EdgeInsets.symmetric(horizontal: 24),
                padding: EdgeInsets.symmetric(horizontal: 20),
                child: Row(
                  children: [
                    Expanded(
                      child: TextField(
                        controller: searchController,
                        decoration: InputDecoration(
                          hintText: 'Search',
                        ),
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        searchWallPaper(searchController.text);
                      },
                      child: Container(
                        child: Icon(Icons.search),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 20,
              ),
              wallpaperList(context: context, wallpapers: wallpaper),
            ],
          ),
        ),
      ),
    );
  }
}
