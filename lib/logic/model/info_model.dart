class InfoModel {
  late final String title;
  late final String image;
  late final String longDescription;

  InfoModel({
    required this.title,
    required this.image,
    required this.longDescription,
  });

  InfoModel.fromJson(Map<dynamic, dynamic> json) {
    title = json['title'];
    image = json['image'];
    longDescription = json['long_description'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['title'] = title;
    data['image'] = image;
    data['long_description'] = longDescription;
    return data;
  }
}
