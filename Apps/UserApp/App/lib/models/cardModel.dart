class CardModel {
  int id;
  String name;
  String number;
  int expiryMonth;
  int expiryYear;
  String cvv;

  CardModel({this.id, this.number, this.name, this.expiryMonth, this.expiryYear, this.cvv});

  CardModel.fromjson(Map<String, dynamic> json) {
    id = int.parse(json['id'].toString());
    name = json['name'] != null ? json['name'] : '';
    number = json['last4'] != null ? json['last4'] : '';
    expiryMonth = json['exp_month'] != null ? int.parse(json['exp_month'].toString()) : null;
    expiryYear = json['exp_year'] != null ? int.parse(json['exp_year'].toString()) : null;
  }

  Map<String, dynamic> tojson() {
    return {
      'id': id,
      'name': name,
      'expiryMonth': expiryMonth,
      'expiryYear': expiryYear,
    };
  }
}
