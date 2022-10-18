class SisfoSlider {
  final String id;
  final String title;
  final String image;
  final String link;

  SisfoSlider({
    required this.id,
    required this.title,
    required this.image,
    required this.link,
  });

  factory SisfoSlider.fromJson(Map<String, dynamic> json) {
    return SisfoSlider(
      id: json['id'],
      title: json['title'],
      image: json['image'],
      link: json['link'],
    );
  }
}
