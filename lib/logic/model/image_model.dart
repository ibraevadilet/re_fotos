class ImageModel {
  late final String image;
  late final String uid;

  ImageModel({
    required this.image,
    required this.uid,
  });

  ImageModel.fromJson(Map<dynamic, dynamic> json) {
    image = json['image'];
    uid = json['uid'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['image'] = image;
    data['uid'] = uid;
    return data;
  }
}
