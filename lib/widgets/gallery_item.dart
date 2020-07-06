import 'package:flutter/material.dart';
import 'package:unsplash_gallery/models/unsplash_image.dart';

class GalleryItem extends StatelessWidget {
  final String link;
  final String imageName;
  final String author;
  final int width;
  final int height;
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
  /// [width] - https://docs.imgix.com/apis/url/size/w
  /// [height] - https://docs.imgix.com/apis/url/size/h
  /// [format] - https://docs.imgix.com/apis/url/format/fm
  /// [fit] - https://docs.imgix.com/apis/url/size/fit
  const GalleryItem(
      {Key key,
      @required this.link,
      this.author,
      this.imageName,
      this.width,
      this.height,
      this.format = 'jpg',
      this.fit = 'max',
      this.margin})
      : super(key: key);

  /// Creates a widget that displays an image with [author] and [imageName]
  /// from [UnsplashImage]
  /// and obtained from the Unsplash website (https://unsplash.com).
  ///
  /// The [unsplashImage] argument must not be null.
  /// The [margin] is empty space to surround the [Container]
  ///
  /// Details about other parameters can be read at:
  /// [width] - https://docs.imgix.com/apis/url/size/w
  /// [height] - https://docs.imgix.com/apis/url/size/h
  /// [format] - https://docs.imgix.com/apis/url/format/fm
  /// [fit] - https://docs.imgix.com/apis/url/size/fit

  factory GalleryItem.fromUnsplashImage(
      {@required UnsplashImage unsplashImage,
      int width,
      int height,
      String format,
      String fit,
      EdgeInsetsGeometry margin}) {
    return GalleryItem(
      link: unsplashImage.imageSource,
      author: unsplashImage.author,
      imageName: unsplashImage.title,
      width: width,
      height: height,
      fit: fit,
      format: format,
      margin: margin,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: margin,
      child: Row(
        children: [
          Image.network(
            link + "&w=$width&h=$height&fm=$format&fit=$fit",
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
          ),
          Expanded(
              child: Container(
                padding: EdgeInsets.only(left: 10),
            child:
                Column(
                    crossAxisAlignment: CrossAxisAlignment.start, children: [
              Text("Author: $author",
                  style: TextStyle(fontSize: 20, color: Colors.grey)),
              Text(
                imageName,
                style: TextStyle(fontSize: 10),
              ),
            ]),
          ))
        ],
      ),
    );
  }
}
