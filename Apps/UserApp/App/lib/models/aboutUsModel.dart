class AboutUs {
  int aboutId;

  String title;
  String description;
  AboutUs({
    this.aboutId,
    this.title,
    this.description,
  });

  factory AboutUs.fromJson(Map<String, dynamic> json) => AboutUs(
        aboutId: int.parse(json["about_id"].toString()),
        title: json["title"],
        description: json["description"],
      );

  Map<String, dynamic> toJson() => {
        "about_id": aboutId,
        "title": title,
        "description": description,
      };
}
