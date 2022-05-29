import 'dart:io';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter_image_compress/flutter_image_compress.dart';
import 'package:gomeat/models/businessLayer/apiHelper.dart';
import 'package:gomeat/models/businessLayer/global.dart' as global;
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:share_plus/share_plus.dart';
import 'package:shared_preferences/shared_preferences.dart';

class BusinessRule {
  APIHelper dbHelper;

  BusinessRule(APIHelper _dbHelper) {
    dbHelper = _dbHelper;
  }
  Future<bool> checkConnectivity() async {
    try {
      bool isConnected;
      var _connectivity = await (Connectivity().checkConnectivity());
      if (_connectivity == ConnectivityResult.mobile) {
        isConnected = true;
      } else if (_connectivity == ConnectivityResult.wifi) {
        isConnected = true;
      } else {
        isConnected = false;
      }

      if (isConnected) {
        try {
          final result = await InternetAddress.lookup('google.com');
          if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
            isConnected = true;
          }
        } on SocketException catch (_) {
          isConnected = false;
        }
      }

      return isConnected;
    } catch (e) {
      print('Exception - businessRule.dart - checkConnectivity(): ' + e.toString());
    }
    return false;
  }

  int convertYearTo4Digits(int year) {
    if (year < 100 && year >= 0) {
      var now = DateTime.now();
      String currentYear = now.year.toString();
      String prefix = currentYear.substring(0, currentYear.length - 2);
      year = int.parse('$prefix${year.toString().padLeft(2, '0')}');
    }
    return year;
  }

  String getCleanedNumber(String text) {
    RegExp regExp = new RegExp(r"[^0-9]");
    return text.replaceAll(regExp, '');
  }

  List<int> getExpiryDate(String value) {
    var split = value.split(new RegExp(r'(\/)'));
    return [int.parse(split[0]), int.parse(split[1])];
  }

  getSharedPreferences() async {
    try {
      global.sp = await SharedPreferences.getInstance();
    } catch (e) {
      print("Exception - businessRule.dart - _saveUser():" + e.toString());
    }
  }

  bool hasDateExpired(int month, int year) {
    return !(month == null || year == null) && isNotExpired(year, month);
  }

  bool hasMonthPassed(int year, int month) {
    var now = DateTime.now();
    // The month has passed if:
    // 1. The year is in the past. In that case, we just assume that the month
    // has passed
    // 2. Card's month (plus another month) is more than current month.
    return hasYearPassed(year) || convertYearTo4Digits(year) == now.year && (month < now.month + 1);
  }

  bool hasYearPassed(int year) {
    int fourDigitsYear = convertYearTo4Digits(year);
    var now = DateTime.now();
    // The year has passed if the year we are currently is more than card's
    // year
    return fourDigitsYear < now.year;
  }

  inviteFriendShareMessage() {
    try {
      String shareMessage = 'Hi! Use my refer code ${global.currentUser.referralCode} to signup in ${global.appInfo.appName} app. You will get some wallet points on successfull sign up.\nAndroid Play Store link - ${global.appInfo.androidAppLink}\n iOS App store link - ${global.appInfo.iosAppLink}';
      Share.share("$shareMessage");
    } catch (e) {
      print("Exception -  businessRule.dart - inviteFriendShareMessage():" + e.toString());
    }
  }

  bool isNotExpired(int year, int month) {
    // It has not expired if both the year and date has not passed
    return !hasYearPassed(year) && !hasMonthPassed(year, month);
  }

  Future<File> openCamera() async {
    try {
      PermissionStatus permissionStatus = await Permission.camera.status;
      if (permissionStatus.isLimited || permissionStatus.isDenied) {
        permissionStatus = await Permission.camera.request();
      }
      //File imageFile;
      XFile _selectedImage = await ImagePicker().pickImage(source: ImageSource.camera);
      File imageFile = File(_selectedImage.path);
      if (imageFile != null) {
        File _finalImage = await _cropImage(imageFile.path);

        _finalImage = await _imageCompress(_finalImage, imageFile.path);

        print("_byteData path ${_finalImage.path}");
        return _finalImage;
      }
    } catch (e) {
      print("Exception - businessRule.dart - openCamera():" + e.toString());
    }
    return null;
  }

  Future<File> selectImageFromGallery() async {
    try {
      PermissionStatus permissionStatus = await Permission.photos.status;
      if (permissionStatus.isLimited || permissionStatus.isDenied) {
        permissionStatus = await Permission.photos.request();
      }
      File imageFile;
      XFile _selectedImage = await ImagePicker().pickImage(source: ImageSource.gallery);
      imageFile = File(_selectedImage.path);
      if (imageFile != null) {
        File _byteData = await _cropImage(imageFile.path);
        _byteData = await _imageCompress(_byteData, imageFile.path);
        return _byteData;
      }
    } catch (e) {
      print("Exception - businessRule.dart - selectImageFromGallery()" + e.toString());
    }
    return null;
  }

  String timeString(DateTime time) {
    String _finalString;
    try {
      _finalString = '${DateTime.now().difference(time).inMinutes}m ago';
      if (DateTime.now().difference(time).inMinutes == 0) {
        _finalString = 'now';
      }
      if (DateTime.now().difference(time).inMinutes >= 60) {
        _finalString = '${DateTime.now().difference(time).inHours}h ago';
      }
      if (DateTime.now().difference(time).inHours > 23) {
        _finalString = '${DateTime.now().difference(time).inDays}day ago';
      }

      return _finalString;
    } catch (e) {
      print("Exception - businessRule.dart - timeString():" + e.toString());
      return _finalString;
    }
  }

  Future<File> _cropImage(String sourcePath) async {
    try {
      File _croppedFile = await ImageCropper.cropImage(
        sourcePath: sourcePath,
        aspectRatio: CropAspectRatio(ratioX: 1, ratioY: 1),
        androidUiSettings: AndroidUiSettings(
          initAspectRatio: CropAspectRatioPreset.original,
          backgroundColor: Colors.white,
          toolbarColor: Colors.black,
          dimmedLayerColor: Colors.white,
          toolbarWidgetColor: Colors.white,
          cropGridColor: Colors.white,
          activeControlsWidgetColor: Color(0xFF46A9FC),
          cropFrameColor: Color(0xFF46A9FC),
          lockAspectRatio: true,
        ),
      );
      if (_croppedFile != null) {
        return _croppedFile;
      }
    } catch (e) {
      print("Exception - businessRule.dart - _cropImage():" + e.toString());
    }
    return null;
  }

  Future<File> _imageCompress(File file, String targetPath) async {
    try {
      var result = await FlutterImageCompress.compressAndGetFile(
        file.path,
        targetPath,
        minHeight: 500,
        minWidth: 500,
        quality: 60,
      );
      print('file ${file.lengthSync()}');
      print(result.lengthSync());

      return result;
    } catch (e) {
      print("Exception - businessRule.dart - _cropImage():" + e.toString());
      return null;
    }
  }
}
