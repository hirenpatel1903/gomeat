
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LanguageCubit extends Cubit<Locale> {
  LanguageCubit() : super(Locale('en')){
setLanguage();
  }

  void setLanguage() async{
    SharedPreferences preferences = await SharedPreferences.getInstance();
    if(preferences.containsKey('language') && preferences.getString('language').length>0){
      emit(Locale(preferences.getString('language')));
    }else{
      emit(Locale('en'));
    }
  }

  void selectEngLanguage() async{
    SharedPreferences preferences = await SharedPreferences.getInstance();
    preferences.setString('language', 'en');
    emit(Locale('en'));
  }

  void selectArabicLanguage() async{
    SharedPreferences preferences = await SharedPreferences.getInstance();
    preferences.setString('language', 'ar');
    emit(Locale('ar'));
  }
  void selectPortugueseLanguage() async{
    SharedPreferences preferences = await SharedPreferences.getInstance();
    preferences.setString('language', 'pt');
    emit(Locale('pt'));
  }

  void selectFrenchLanguage() async{
    SharedPreferences preferences = await SharedPreferences.getInstance();
    preferences.setString('language', 'fr');
    emit(Locale('fr'));
  }
  void selectIndonesianLanguage() async{
    SharedPreferences preferences = await SharedPreferences.getInstance();
    preferences.setString('language', 'id');
    emit(Locale('id'));
  }

  void selectSpanishLanguage() async{
    SharedPreferences preferences = await SharedPreferences.getInstance();
    preferences.setString('language', 'es');
    emit(Locale('es'));
  }

  void selectBulgarianLanguage() async{
    SharedPreferences preferences = await SharedPreferences.getInstance();
    preferences.setString('language', 'bg');
    emit(Locale('bg'));
  }
}
