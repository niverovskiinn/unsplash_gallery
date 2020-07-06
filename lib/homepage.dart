import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:unsplash_gallery/config/constants.dart' as Constants;
import 'package:unsplash_gallery/models/unsplash_image.dart';
import 'package:unsplash_gallery/services/data_service.dart';
import 'package:unsplash_gallery/widgets/gallery_item.dart';

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);
  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final DataService _dataService = DataService();
  Future<List<UnsplashImage>> futureImagesList;

  @override
  void initState() {
    super.initState();
    futureImagesList = _dataService.fetchUnsplashImages();
  }

  void refresh() {
    setState(() {
      futureImagesList = _dataService.fetchUnsplashImages();
    });
  }

  @override
  Widget build(BuildContext context) {
    print("Build homepage");
    return Scaffold(
      appBar: AppBar(title: Text(widget.title)),
      body: FutureBuilder<List<UnsplashImage>>(
          future: futureImagesList,
          builder: (_, snapshot) {
            if (snapshot.hasData) {
              return ListView.builder(
                  padding: EdgeInsets.all(5),
                  itemCount: snapshot.data.length,
                  itemBuilder: (_, int index) {
                    return GalleryItem.fromUnsplashImage(
                      unsplashImage: snapshot.data[index],
                      imageWidth: MediaQuery.of(context).orientation ==
                              Orientation.portrait
                          ? Constants.portraitImageWidth
                          : Constants.landscapeImageWidth,
                      margin: EdgeInsets.all(5),
                    );
                  });
            } else if (snapshot.hasError) {
              return Center(child: Text("${snapshot.error}"));
            }
            return Center(
              child: CircularProgressIndicator(),
            );
          }),
    );
  }
}
