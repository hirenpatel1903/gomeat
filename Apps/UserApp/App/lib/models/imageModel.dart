class ImageModel {
  String image;

  ImageModel({
    this.image,
  });

  factory ImageModel.fromJson(Map<String, dynamic> json) => ImageModel(
        image: json["image"],
      );

  Map<String, dynamic> toJson() => {
        "image": image,
      };
}
