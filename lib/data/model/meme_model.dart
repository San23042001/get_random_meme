class Meme {
  final int id;
  final String image;
  final String caption;
  final String category;

  Meme({
    required this.id,
    required this.image,
    required this.caption,
    required this.category,
  });

  factory Meme.fromJson(Map<String, dynamic> json) {
    return Meme(
      id: json['id'],
      image: json['image'],
      caption: json['caption'],
      category: json['category'],
    );
  }
}
