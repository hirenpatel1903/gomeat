class LanguageBean{
  String langString;
  String langCode;

  LanguageBean(this.langString, this.langCode);

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is LanguageBean &&
          runtimeType == other.runtimeType &&
          (langString == other.langString || langCode == other.langCode);


  @override
  int get hashCode => langString.hashCode ^ langCode.hashCode;
}