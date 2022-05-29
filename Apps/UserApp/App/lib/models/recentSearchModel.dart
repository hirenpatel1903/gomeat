class RecentSearch {
  int id;
  String keyword;
  int userId;

  RecentSearch();
  RecentSearch.fromJson(Map<String, dynamic> json) {
    try {
      id = json['id'] != null ? int.parse(json['id'].toString()) : null;
      keyword = json['keyword'] != null ? json['keyword'] : null;
      userId = json['user_id'] != null ? int.parse(json['user_id'].toString()) : null;
    } catch (e) {
      print("Exception - RecentSearchModel.dart - RecentSearch.fromJson():" + e.toString());
    }
  }
}
