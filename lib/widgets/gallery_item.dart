import 'package:flutter/material.dart';
import 'package:unsplash_gallery/models/unsplash_image.dart';
import 'package:unsplash_gallery/config/constants.dart' as Constants;


class GalleryItem extends StatelessWidget {
  final String link;
  final String imageName;
  final String author;
  final int imageWidth;
  final int imageHeight;
  final String format;
  final String fit;
  final EdgeInsetsGeometry margin;

  /// Creates a widget that displays an image with [author] and [imageName]
  /// and obtained from the Unsplash website (https://unsplash.com).
  ///
  /// The [link] argument must not be null.
  /// The [margin] is empty space to surround the [Container]
  ///
  /// Details about other parameters can be read on:
  /// [imageWidth] - https://docs.imgix.com/apis/url/size/w
  /// [imageHeight] - https://docs.imgix.com/apis/url/size/h
  /// [format] - https://docs.imgix.com/apis/url/format/fm
  /// [fit] - https://docs.imgix.com/apis/url/size/fit
  const GalleryItem(
      {Key key,
      @required this.link,
      this.author,
      this.imageName,
      this.imageWidth,
      this.imageHeight,
      this.format = 'jpg',
      this.fit = 'max',
      this.margin})
      : assert(imageWidth != null || imageWidth != 0),
        assert(imageHeight != null || imageHeight != 0),
        assert(link != null),
        super(key: key);

  /// Creates a widget that displays an image with [author] and [imageName]
  /// from [UnsplashImage]
  /// and obtained from the Unsplash website (https://unsplash.com).
  ///
  /// The [unsplashImage] argument must not be null.
  /// The [margin] is empty space to surround the [Container]
  ///
  /// Details about other parameters can be read at:
  /// [imageWidth] - https://docs.imgix.com/apis/url/size/w
  /// [imageHeight] - https://docs.imgix.com/apis/url/size/h
  /// [format] - https://docs.imgix.com/apis/url/format/fm
  /// [fit] - https://docs.imgix.com/apis/url/size/fit

  factory GalleryItem.fromUnsplashImage(
      {@required UnsplashImage unsplashImage,
      int imageWidth,
      int imageHeight,
      String format,
      String fit,
      EdgeInsetsGeometry margin}) {
    return GalleryItem(
      link: unsplashImage.imageSource,
      author: unsplashImage.author,
      imageName: unsplashImage.title,
      imageWidth: imageWidth,
      imageHeight: imageHeight,
      fit: fit,
      format: format,
      margin: margin,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: margin,
      padding: EdgeInsets.all(5),
      child: Material(
        borderRadius: BorderRadius.all(Radius.circular(5)),
        child: InkWell(
          onTap: () => _navigateToImage(context),
          child: Row(
            children: [
              _openImageWithLoader(
                  link + "&w=$imageWidth&h=$imageHeight&fm=$format&fit=$fit"),
              Expanded(
                  child: Container(
                padding: EdgeInsets.only(left: 10),
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("Author: $author",
                          style: TextStyle(fontSize: Constants.authorFontSize, color: Constants.mainColor)),
                      if (imageName != null)
                        Text(
                          imageName,
                          style: TextStyle(fontSize: Constants.imageNameFontSize),
                        ),
                    ]),
              ))
            ],
          ),
        ),
      ),
    );
  }

  Image _openImageWithLoader(String link) {
    return Image.network(
      link,
      loadingBuilder: (BuildContext context, Widget child,
          ImageChunkEvent loadingProgress) {
        if (loadingProgress == null) return child;
        return Center(
          child: CircularProgressIndicator(
            value: loadingProgress.expectedTotalBytes != null
                ? loadingProgress.cumulativeBytesLoaded /
                    loadingProgress.expectedTotalBytes
                : null,
          ),
        );
      },
    );
  }

  void _navigateToImage(BuildContext context) {
    print("Open image screen");
    Navigator.of(context).push(MaterialPageRoute(
      builder: (BuildContext context) {
        return Scaffold(
            appBar: AppBar(),
            body: Center(
                child: _openImageWithLoader(
                    "$link&w=${MediaQuery.of(context).size.width}"
                        "&h=${MediaQuery.of(context).size.height}")));
      },
    ));
  }
}
