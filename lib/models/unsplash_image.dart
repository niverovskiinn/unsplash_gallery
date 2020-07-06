class UnsplashImage {
  final String author;
  final String title;
  final String imageSource;

  UnsplashImage({this.author, this.title, this.imageSource});

  factory UnsplashImage.fromJson(Map<String, dynamic> json) {
    return UnsplashImage(
      author: json['user']['name'],
      title: json['description'],
      imageSource: json['urls']['raw'],
    );
  }

  @override
  String toString() {
    return 'UnsplashImage{author: $author, title: $title, imageSource: $imageSource}';
  }


}
