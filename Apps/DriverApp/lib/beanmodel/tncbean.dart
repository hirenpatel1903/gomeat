class TermsConditionMain{
  dynamic status;
  dynamic message;
  TermsConditionMainData data;

  TermsConditionMain(this.status, this.message, this.data);

  factory TermsConditionMain.fromJsom(dynamic json){
    TermsConditionMainData d = TermsConditionMainData.fromJson(json['data']);
    return TermsConditionMain(json['status'], json['message'], d);
  }

  @override
  String toString() {
    return '{status: $status, message: $message, data: $data}';
  }
}

class TermsConditionMainData{
  dynamic about_id;
  dynamic title;
  dynamic description;

  TermsConditionMainData(this.about_id, this.title, this.description);

  factory TermsConditionMainData.fromJson(dynamic json){
    return TermsConditionMainData(json['terms_id'], json['title'], json['description']);
  }

  @override
  String toString() {
    return '{terms_id: $about_id, title: $title, description: $description}';
  }
}