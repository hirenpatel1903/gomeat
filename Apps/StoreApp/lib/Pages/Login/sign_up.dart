import 'dart:convert';
import 'dart:io';

import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_image_compress/flutter_image_compress.dart';
import 'package:http/http.dart' as http;
import 'package:http/http.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';
import 'package:toast/toast.dart';
import 'package:vendor/Components/custom_button.dart';
import 'package:vendor/Components/entry_field.dart';
import 'package:vendor/Locale/locales.dart';
import 'package:vendor/Routes/routes.dart';
import 'package:vendor/Theme/colors.dart';
import 'package:vendor/baseurl/baseurlg.dart';
import 'package:vendor/beanmodel/appinfomodel.dart';
import 'package:vendor/beanmodel/citybean/citybean.dart';
import 'package:vendor/beanmodel/idList.dart';
import 'package:vendor/beanmodel/mapsection/latlng.dart';
import 'package:vendor/beanmodel/registrationmodel/registrationmodel.dart';

class SignUp extends StatefulWidget {
  // final VoidCallback onVerificationDone;
  // SignUp(this.onVerificationDone);
  @override
  _SignUpState createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  bool showDialogBox = false;
  bool enteredFirst = false;
  int numberLimit = 10;
  dynamic mobileNumber;
  dynamic emailId;
  dynamic fb_id;
  TextEditingController sellerNameC = TextEditingController();
  TextEditingController storeNameC = TextEditingController();
  TextEditingController emailAddressC = TextEditingController();
  TextEditingController phoneNumberC = TextEditingController();
  TextEditingController passwordC = TextEditingController();
  TextEditingController adminShareC = TextEditingController();
  TextEditingController deliveryRangeC = TextEditingController();
  TextEditingController idNumberC = TextEditingController();
  TextEditingController addressC = TextEditingController();
  TextEditingController codeController = TextEditingController();
  String selectCity = 'Select city';
  String selectId = 'Select Id';
  List<CityDataBean> cityList = [];
  IdListData idValue;
  List<IdListData> idList = [];
  CityDataBean cityData;
  AppInfoModel appinfo;
  FirebaseMessaging messaging;
  dynamic token;
  File _image;
  File idPhoto;
  final picker = ImagePicker();
  int count = 0;

  dynamic lat;
  dynamic lng;

  @override
  void initState() {
    super.initState();
    // addressC.text = 'sonipat';
    hitAsyncInit();
    hitCityData();
    hitIdData();
  }

  void hitAsyncInit() async {
    try {
      await Firebase.initializeApp();
      messaging = FirebaseMessaging.instance;
      messaging.getToken().then((value) {
        token = value;
      });
    } catch (e) {}
  }

  void hitCityData() {
    setState(() {
      showDialogBox = true;
    });
    var http = Client();
    http.get(cityUri).then((value) {
      if (value.statusCode == 200) {
        CityBeanModel data1 = CityBeanModel.fromJson(jsonDecode(value.body));
        print('${data1.data.toString()}');
        if (data1.status == "1" || data1.status == 1) {
          setState(() {
            cityList.clear();
            cityList = List.from(data1.data);
            selectCity = cityList[0].city_name;
            cityData = cityList[0];
          });
        } else {
          setState(() {
            selectCity = 'Select your city';
            cityData = null;
          });
        }
      } else {
        setState(() {
          selectCity = 'Select your city';
          cityData = null;
        });
      }
      setState(() {
        showDialogBox = false;
      });
    }).catchError((e) {
      setState(() {
        selectCity = 'Select your city';
        cityData = null;
        showDialogBox = false;
      });
      print(e);
    });
  }

  void hitIdData() {
    setState(() {
      showDialogBox = true;
    });
    var http = Client();
    http.get(storeIdList).then((value) {
      if (value.statusCode == 200) {
        IdListModel data1 = IdListModel.fromJson(jsonDecode(value.body));
        print('${data1.data.toString()}');
        if (data1.status == "1" || data1.status == 1) {
          setState(() {
            idList.clear();
            idList = List.from(data1.data);
            selectId = 'Select Id';
            // selectId = idList[0];
          });
        } else {
          setState(() {
            selectId = 'Select Id';
            // cityData = null;
          });
        }
      } else {
        setState(() {
          selectId = 'Select Id';
          // cityData = null;
        });
      }
      setState(() {
        showDialogBox = false;
      });
    }).catchError((e) {
      setState(() {
        selectId = 'Select Id';
        // cityData = null;
        showDialogBox = false;
      });
      print(e);
    });
  }

  // _imgFromCamera() async {
  //   final pickedFile = await picker.getImage(source: ImageSource.camera);
  //
  //   setState(() {
  //     if (pickedFile != null) {
  //       _image = File(pickedFile.path);
  //     } else {
  //       print('No image selected.');
  //     }
  //   });
  // }
  //
  // _imgFromGallery() async {
  //   picker.getImage(source: ImageSource.gallery).then((pickedFile) {
  //     setState(() {
  //       if (pickedFile != null) {
  //         _image = File(pickedFile.path);
  //       } else {
  //         print('No image selected.');
  //       }
  //     });
  //   }).catchError((e) => print(e));
  // }
  _imgFromCamera() async {
    var pathd = await getApplicationDocumentsDirectory();
    final pickedFile = await picker.pickImage(source: ImageSource.camera);
    if (pickedFile != null) {
      _image = File(pickedFile.path);
      compressImageFile(_image, '${pathd.path}/${DateTime.now()}.jpg');
    } else {
      print('No image selected.');
    }
  }

  _imgFromGallery() async {
    var pathd = await getApplicationDocumentsDirectory();
    // var pathd2 = await getApplicationDocumentsDirectory();
    // final dir = Directory(pathd2.path);
    // dir.deleteSync(recursive: true);
    // pathd2 = await getApplicationDocumentsDirectory();

    picker.pickImage(source: ImageSource.gallery).then((pickedFile) {
      if (pickedFile != null) {
        setState(() {
          _image = File(pickedFile.path);
        });
        compressImageFile(_image, '${pathd.path}/${DateTime.now()}.jpg');
      } else {
        print('No image selected.');
      }
    }).catchError((e) => print(e));
  }

  void compressImageFile(File file, String targetPath) async {
    try {
      print("testCompressAndGetFile");
      final result = await FlutterImageCompress.compressAndGetFile(
        file.absolute.path,
        targetPath,
        quality: 90,
      );
      print(file.lengthSync());
      print(result?.lengthSync());
      // final newOneKb = _image.lengthSync();
      // final newOnekb2 = newOneKb / 1024;
      // print('newOneKb2' + newOnekb2.toString());
      final bytes = result.readAsBytesSync().lengthInBytes;
      final kb = bytes / 1024;
      print('kb ' + kb.toString());
      // String updatedKb = getFileSizeString(bytes: result.lengthSync());
      if (kb > 1000) {
        setState(() {
          _image = null;
        });
        Toast.show('upload image less then 1000 kb', context, gravity: Toast.CENTER, duration: Toast.LENGTH_SHORT);
      } else {
        setState(() {
          _image = result;
        });
      }
    } catch (e) {
      print('');
    }
  }

  // static String getFileSizeString({@required int bytes, int decimals = 0}) {
  //   if (bytes <= 0) return "0 Bytes";
  //   const suffixes = [" Bytes", "KB", "MB", "GB", "TB"];
  //   var i = (log(bytes) / log(1024)).floor();
  //   return ((bytes / pow(1024, i)).toStringAsFixed(decimals)) + suffixes[i];
  // }

  _imgFromCameraForId() async {
    var pathd = await getApplicationDocumentsDirectory();
    final pickedFile = await picker.pickImage(source: ImageSource.camera);
    if (pickedFile != null) {
      setState(() {
        idPhoto = File(pickedFile.path);
      });

      compressImageFileForId(idPhoto, '${pathd.path}/${DateTime.now()}.jpg');
    } else {
      print('No image selected.');
    }
  }

  _imgFromGalleryForId() async {
    var pathd = await getApplicationDocumentsDirectory();
    picker.pickImage(source: ImageSource.gallery).then((pickedFile) {
      if (pickedFile != null) {
        setState(() {
          idPhoto = File(pickedFile.path);
        });
        compressImageFileForId(idPhoto, '${pathd.path}/${DateTime.now()}.jpg');
      } else {
        print('No image selected.');
      }
    }).catchError((e) => print(e));
  }

  void compressImageFileForId(File file, String targetPath) async {
    try {
      print("testCompressAndGetFile");
      final result = await FlutterImageCompress.compressAndGetFile(
        file.absolute.path,
        targetPath,
        quality: 90,
      );
      print(file.lengthSync());
      print(result?.lengthSync());
      // final newOneKb = _image.lengthSync();
      // final newOnekb2 = newOneKb / 1024;
      // print('newOneKb2' + newOnekb2.toString());
      final bytes = result.readAsBytesSync().lengthInBytes;
      final kb = bytes / 1024;
      print('kb ' + kb.toString());
      // String updatedKb = getFileSizeString(bytes: result.lengthSync());
      if (kb > 1000) {
        setState(() {
          idPhoto = null;
        });
        Toast.show('upload image less then 1000 kb', context, gravity: Toast.CENTER, duration: Toast.LENGTH_SHORT);
      } else {
        setState(() {
          idPhoto = result;
        });
      }
    } catch (e) {
      print('');
    }
  }

  void _showPicker(context) {
    var locale = AppLocalizations.of(context);
    showModalBottomSheet(
        context: context,
        builder: (BuildContext bc) {
          return SafeArea(
            child: Container(
              child: new Wrap(
                children: <Widget>[
                  new ListTile(
                      leading: new Icon(Icons.photo_library),
                      title: new Text(locale.photolib),
                      onTap: () {
                        _imgFromGallery();
                        Navigator.of(context).pop();
                      }),
                  new ListTile(
                    leading: new Icon(Icons.photo_camera),
                    title: new Text(locale.camera),
                    onTap: () {
                      _imgFromCamera();
                      Navigator.of(context).pop();
                    },
                  ),
                ],
              ),
            ),
          );
        });
  }

  void _showPickerForId(context) {
    var locale = AppLocalizations.of(context);
    showModalBottomSheet(
        context: context,
        builder: (BuildContext bc) {
          return SafeArea(
            child: Container(
              child: new Wrap(
                children: <Widget>[
                  new ListTile(
                      leading: new Icon(Icons.photo_library),
                      title: new Text(locale.photolib),
                      onTap: () {
                        _imgFromGalleryForId();
                        Navigator.of(context).pop();
                      }),
                  new ListTile(
                    leading: new Icon(Icons.photo_camera),
                    title: new Text(locale.camera),
                    onTap: () {
                      _imgFromCameraForId();
                      Navigator.of(context).pop();
                    },
                  ),
                ],
              ),
            ),
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    var locale = AppLocalizations.of(context);
    if (!enteredFirst) {
      final Map<String, Object> rcvdData = ModalRoute.of(context).settings.arguments;
      enteredFirst = true;
      appinfo = rcvdData['appinfo'];
      numberLimit = int.parse('${appinfo.phoneNumberLength}');
      codeController.text = '+${appinfo.countryCode}';
    }
    return Scaffold(
      appBar: AppBar(
        title: Text(
          locale.register,
          style: TextStyle(
            color: Theme.of(context).backgroundColor,
          ),
        ),
        centerTitle: true,
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  SizedBox(height: 10.0),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10.0),
                    child: GestureDetector(
                      behavior: HitTestBehavior.opaque,
                      onTap: () {
                        _showPicker(context);
                      },
                      child: Container(
                        width: MediaQuery.of(context).size.width,
                        height: 90,
                        decoration: BoxDecoration(border: Border.all(color: kMainColor), borderRadius: BorderRadius.circular(5.0)),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Image(
                              image: (_image != null) ? FileImage(_image) : AssetImage('assets/icon.png'),
                              height: 80,
                              width: 80,
                            ),
                            SizedBox(
                              width: 20.0,
                            ),
                            Text(
                              locale.uploadpictext,
                              style: Theme.of(context).textTheme.headline6.copyWith(color: kMainTextColor, fontWeight: FontWeight.bold, fontSize: 18),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 10.0),
                  EntryField(
                    label: locale.sellerName,
                    hint: locale.sellerName1,
                    controller: sellerNameC,
                  ),
                  EntryField(
                    label: locale.storename1,
                    hint: locale.storename2,
                    controller: storeNameC,
                  ),
                  EntryField(
                    label: locale.storenumber1,
                    hint: locale.storenumber2,
                    controller: phoneNumberC,
                    keyboardType: TextInputType.phone,
                    maxLength: int.parse('${appinfo.phoneNumberLength}'),
                    contentPading: EdgeInsets.symmetric(horizontal: 0, vertical: 20),
                    preFixIcon: Container(
                      alignment: Alignment.center,
                      width: 40,
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(
                            '+${appinfo.countryCode}',
                            textAlign: TextAlign.center,
                            style: TextStyle(color: kMainTextColor, fontSize: 18.3),
                          ),
                          Container(
                            width: 2,
                            color: kIconColor,
                            height: 30,
                            margin: EdgeInsets.only(left: 5),
                          )
                        ],
                      ),
                    ),
                  ),
                  // Row(
                  //   crossAxisAlignment: CrossAxisAlignment.stretch,
                  //   children: [
                  //     SizedBox(
                  //       height:60,
                  //       width: 60,
                  //       child: EntryField(
                  //         label: 'C Code',
                  //         hint: '--',
                  //         readOnly: true,
                  //         controller: codeController,
                  //         horizontalPadding: 3,
                  //         verticalPadding: 1,
                  //       ),
                  //     ),
                  //     Expanded(child: ,)
                  //   ],
                  // ),
                  // Padding(
                  //   padding: EdgeInsets.symmetric(
                  //       horizontal: 10.0,
                  //       vertical: 1.0),
                  //   child: Column(
                  //     crossAxisAlignment: CrossAxisAlignment.stretch,
                  //     children: <Widget>[
                  //       Text(locale.storenumber1,
                  //           style: Theme.of(context).textTheme.headline6.copyWith(
                  //               color: kMainTextColor,
                  //               fontWeight: FontWeight.bold,
                  //               fontSize: 21.7)),
                  //       TextField(
                  //         textCapitalization:
                  //         TextCapitalization.sentences,
                  //         cursorColor: kMainColor,
                  //         autofocus: false,
                  //         controller: phoneNumberC,
                  //         readOnly: false,
                  //         keyboardType: TextInputType.phone,
                  //         textInputAction: TextInputAction.done,
                  //         minLines: 1,
                  //         maxLength: widget.maxLength,
                  //         maxLines: widget.maxLines ?? 1,
                  //         decoration: InputDecoration(
                  //             enabledBorder: UnderlineInputBorder(
                  //               borderSide: BorderSide(
                  //                   color: widget.underlineColor ?? Colors.grey[200]),
                  //             ),
                  //             suffixIcon: IconButton(
                  //               icon: Icon(
                  //                 widget.suffixIcon,
                  //                 size: 40.0,
                  //                 color: Theme.of(context).backgroundColor,
                  //               ),
                  //               onPressed: widget.onSuffixPressed ?? null,
                  //             ),
                  //             counterText: "",
                  //             hintText: widget.hint,
                  //             hintStyle: widget.hintStyle ??
                  //                 Theme.of(context)
                  //                     .textTheme
                  //                     .subtitle1
                  //                     .copyWith(color: kHintColor, fontSize: 18.3)),
                  //       ),
                  //       SizedBox(height: 20.0),
                  //     ],
                  //   ),
                  // ),
                  EntryField(
                    label: locale.emailAddress,
                    hint: locale.enterEmailAddress,
                    controller: emailAddressC,
                  ),
                  EntryField(
                    label: locale.adminshare1,
                    hint: locale.adminshare2,
                    controller: adminShareC,
                  ),
                  EntryField(
                    label: locale.password1,
                    hint: locale.password2,
                    controller: passwordC,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 1),
                    child: Text(
                      locale.selectycity1,
                      style: Theme.of(context).textTheme.headline6.copyWith(color: kMainTextColor, fontWeight: FontWeight.bold, fontSize: 21.7),
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 10),
                    child: DropdownButton<CityDataBean>(
                      hint: Text(
                        selectCity,
                        overflow: TextOverflow.clip,
                        maxLines: 1,
                      ),
                      isExpanded: true,
                      iconEnabledColor: kMainTextColor,
                      iconDisabledColor: kMainTextColor,
                      iconSize: 30,
                      items: cityList.map((value) {
                        return DropdownMenuItem<CityDataBean>(
                          value: value,
                          child: Text(value.city_name, overflow: TextOverflow.clip),
                        );
                      }).toList(),
                      onChanged: (value) {
                        setState(() {
                          selectCity = value.city_name;
                          cityData = value;
                          // showDialogBox = true;
                        });
                        // hitSocityList(value.city_name, locale);
                        print(value);
                      },
                    ),
                  ),
                  EntryField(
                    label: locale.deliveryrange1,
                    hint: locale.deliveryrange2,
                    controller: deliveryRangeC,
                  ),
                  EntryField(
                    label: locale.storeaddress1,
                    hint: locale.storeaddress2,
                    controller: addressC,
                    readOnly: true,
                    onTap: () {
                      Navigator.pushNamed(context, PageRoutes.locSearch).then((value) {
                        if (value != null) {
                          BackLatLng back = value;
                          setState(() {
                            addressC.text = back.address;
                            lat = double.parse('${back.lat}');
                            lng = double.parse('${back.lng}');
                          });
                        }
                      });
                    },
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 1),
                    child: Text(
                      'Select Id',
                      style: Theme.of(context).textTheme.headline6.copyWith(color: kMainTextColor, fontWeight: FontWeight.bold, fontSize: 21.7),
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 10),
                    child: DropdownButton<IdListData>(
                      hint: Text(
                        selectId,
                        overflow: TextOverflow.clip,
                        maxLines: 1,
                      ),
                      isExpanded: true,
                      iconEnabledColor: kMainTextColor,
                      iconDisabledColor: kMainTextColor,
                      iconSize: 30,
                      items: idList.map((value) {
                        return DropdownMenuItem<IdListData>(
                          value: value,
                          child: Text(value.name, overflow: TextOverflow.clip),
                        );
                      }).toList(),
                      onChanged: (value) {
                        setState(() {
                          selectId = value.name;
                          idValue = value;
                          // cityData = value;
                          // showDialogBox = true;
                        });
                        // hitSocityList(value.city_name, locale);
                        print(value);
                      },
                    ),
                  ),
                  idValue != null
                      ? EntryField(
                          label: 'Id Number',
                          hint: 'Enter id number',
                          controller: idNumberC,
                        )
                      : SizedBox(),
                  idValue != null
                      ? Container(
                          margin: EdgeInsets.all(08),
                          decoration: BoxDecoration(border: Border.all(width: 1, color: Theme.of(context).primaryColor), borderRadius: BorderRadius.all(Radius.circular(10))),
                          width: MediaQuery.of(context).size.width,
                          height: 250,
                          child: Padding(
                            padding: const EdgeInsets.only(top: 10, left: 08, right: 08, bottom: 10),
                            child: GestureDetector(
                              onTap: () {
                                FocusScope.of(context).unfocus();
                                _showPickerForId(context);
                              },
                              child: Container(
                                  color: Colors.transparent,
                                  // color: Theme.of(context).primaryColor, //color of dotted/dash line
                                  // strokeWidth: 1, //thickness of dash/dots
                                  // dashPattern: const [10, 6],
                                  child: idPhoto == null
                                      ? SizedBox(
                                          height: 250,
                                          width: double.infinity,
                                          child: Center(
                                              child: Text(
                                            'Tap to add ${idValue.name} photo',
                                            //'Tap to add third image',
                                            style: Theme.of(context).inputDecorationTheme.labelStyle,
                                          )),
                                        )
                                      : SizedBox(
                                          height: 250,
                                          width: double.infinity,
                                          child: Image.file(
                                            idPhoto,
                                            fit: BoxFit.contain,
                                          ),
                                        )),
                            ),
                          ),
                        )
                      : SizedBox(),
                ],
              ),
            ),
          ),
          showDialogBox
              ? Container(
                  height: 50,
                  child: Center(widthFactor: 50, heightFactor: 40, child: CircularProgressIndicator(strokeWidth: 3)),
                )
              : CustomButton(onTap: () {
                  if (!showDialogBox) {
                    setState(() {
                      showDialogBox = true;
                    });
                    // int numLength = (mobileNumber!=null && mobileNumber.toString().length>0)?numberLimit:10;
                    if (sellerNameC.text != null) {
                      if (emailAddressC.text != null && emailValidator(emailAddressC.text)) {
                        if (passwordC.text != null && passwordC.text.length > 6) {
                          if (phoneNumberC.text != null && phoneNumberC.text.length == numberLimit) {
                            if (storeNameC.text != null) {
                              if (adminShareC.text != null) {
                                if (deliveryRangeC.text != null) {
                                  if (addressC.text != null) {
                                    if (idValue != null) {
                                      if (idNumberC.text != '') {
                                        if (_image != null) {
                                          if (idPhoto != null) {
                                            hitSignUpUrl(sellerNameC.text, storeNameC.text, phoneNumberC.text, emailAddressC.text, passwordC.text, cityData.city_name, adminShareC.text, deliveryRangeC.text, addressC.text, context, idValue.name, idNumberC.text);
                                          } else {
                                            setState(() {
                                              showDialogBox = false;
                                            });
                                            Toast.show('upload id photo', context, gravity: Toast.CENTER, duration: Toast.LENGTH_SHORT);
                                          }
                                        } else {
                                          setState(() {
                                            showDialogBox = false;
                                          });
                                          Toast.show('upload your trade license', context, gravity: Toast.CENTER, duration: Toast.LENGTH_SHORT);
                                        }
                                      } else {
                                        setState(() {
                                          showDialogBox = false;
                                        });
                                        Toast.show('incorect id number', context, gravity: Toast.CENTER, duration: Toast.LENGTH_SHORT);
                                      }
                                    } else {
                                      setState(() {
                                        showDialogBox = false;
                                      });
                                      Toast.show('incorectId', context, gravity: Toast.CENTER, duration: Toast.LENGTH_SHORT);
                                    }
                                  } else {
                                    setState(() {
                                      showDialogBox = false;
                                    });
                                    Toast.show('${locale.incorectUserName}$numberLimit', context, gravity: Toast.CENTER, duration: Toast.LENGTH_SHORT);
                                  }
                                } else {
                                  setState(() {
                                    showDialogBox = false;
                                  });
                                  Toast.show('${locale.incorectUserName}$numberLimit', context, gravity: Toast.CENTER, duration: Toast.LENGTH_SHORT);
                                }
                              } else {
                                setState(() {
                                  showDialogBox = false;
                                });
                                Toast.show('${locale.incorectUserName}$numberLimit', context, gravity: Toast.CENTER, duration: Toast.LENGTH_SHORT);
                              }
                            } else {
                              setState(() {
                                showDialogBox = false;
                              });
                              Toast.show('${locale.incorectUserName}$numberLimit', context, gravity: Toast.CENTER, duration: Toast.LENGTH_SHORT);
                            }
                          } else {
                            setState(() {
                              showDialogBox = false;
                            });
                            Toast.show('${locale.incorectMobileNumber}$numberLimit', context, gravity: Toast.CENTER, duration: Toast.LENGTH_SHORT);
                          }
                        } else {
                          setState(() {
                            showDialogBox = false;
                          });
                          Toast.show(locale.incorectPassword, context, gravity: Toast.CENTER, duration: Toast.LENGTH_SHORT);
                        }
                      } else {
                        setState(() {
                          showDialogBox = false;
                        });
                        Toast.show(locale.incorectEmail, context, gravity: Toast.CENTER, duration: Toast.LENGTH_SHORT);
                      }
                    } else {
                      setState(() {
                        showDialogBox = false;
                      });
                      Toast.show(locale.incorectUserName, context, gravity: Toast.CENTER, duration: Toast.LENGTH_SHORT);
                    }
                  } else {
                    Toast.show('Already in progress.', context, gravity: Toast.CENTER, duration: Toast.LENGTH_SHORT);
                  }
                })
        ],
      ),
    );
  }

  bool emailValidator(email) {
    return RegExp(r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+").hasMatch(email);
  }

  void hitSignUpUrl(
    dynamic sellerName,
    dynamic storename,
    dynamic storephone,
    dynamic storeemail,
    dynamic password,
    dynamic cityid,
    dynamic adminshare,
    dynamic deliveryrange,
    dynamic address,
    BuildContext context,
    String idName,
    String idNumber,
  ) async {
    print(storename + '\n' + sellerName + '\n' + storephone + '\n' + cityid + '\n' + storeemail + '\n' + deliveryrange + '\n' + password + '\n' + address + '\n' + lat.toString() + '\n' + lng.toString() + '\n' + adminshare);
    var requestMulti = http.MultipartRequest('POST', registrationStoreUri);
    requestMulti.fields["store_name"] = '$storename';
    requestMulti.fields["emp_name"] = '$sellerName';
    requestMulti.fields["store_phone"] = '$storephone';
    requestMulti.fields["city"] = '$cityid';
    requestMulti.fields["email"] = '$storeemail';
    requestMulti.fields["del_range"] = '$deliveryrange';
    requestMulti.fields["password"] = '$password';
    requestMulti.fields["address"] = '$address';
    requestMulti.fields["lat"] = '$lat';
    requestMulti.fields["lng"] = '$lng';
    requestMulti.fields["share"] = '$adminshare';
    requestMulti.fields["id_name"] = '$idName';
    requestMulti.fields["id_numb"] = '$idNumber';
    if (_image != null) {
      String fid = _image.path.split('/').last;
      requestMulti.files.add(await http.MultipartFile.fromPath('profile', _image.path, filename: fid));
      String fid2 = idPhoto.path.split('/').last;
      requestMulti.files.add(await http.MultipartFile.fromPath('id_img', idPhoto.path, filename: fid2));
      requestMulti.send().then((values) {
        values.stream.toBytes().then((value) {
          var responseString = String.fromCharCodes(value);
          print(responseString);
          var jsonData = jsonDecode(responseString);
          print('${jsonData.toString()}');
          RegistrationModel signInData = RegistrationModel.fromJson(jsonData);
          if ('${signInData.status}' == '1') {
            Navigator.of(context).pop();
          }
          Toast.show(signInData.message, context, gravity: Toast.CENTER, duration: Toast.LENGTH_SHORT);
          setState(() {
            showDialogBox = false;
          });
        }).catchError((e) {
          print(e);
          setState(() {
            showDialogBox = false;
          });
        });
      }).catchError((e) {
        setState(() {
          showDialogBox = false;
        });
        print(e);
      });
    }
    // if (_image != null) {
    //   String fid = _image.path.split('/').last;
    //   if (fid != null && fid.length > 0) {
    //     http.MultipartFile.fromPath('profile', _image.path, filename: fid).then((pic) async {
    //       requestMulti.files.add(pic);
    //       // if (idPhoto != null) {
    //       //   String fid2 = idPhoto.path.split('/').last;
    //       //   if (fid2 != null && fid2.length > 0) {
    //       //     http.MultipartFile.fromPath('id_img', _image.path, filename: fid2).then((pic2) {
    //       //       requestMulti.files.add(pic2);
    //       //     });
    //       //   }
    //       // } else {
    //       //   requestMulti.fields["id_img"] = '';
    //       // } //here needed
    //       if (idPhoto != null) {
    //         String fid5 = idPhoto.path.split('/').last;

    //         requestMulti.files.add(await http.MultipartFile.fromPath('id_img', idPhoto.path, filename: fid5));
    //       } else {
    //         requestMulti.fields['id_img'] = '';
    //       }

    //       // requestMulti.files.add(pic);
    //       requestMulti.send().then((values) {
    //         values.stream.toBytes().then((value) {
    //           var responseString = String.fromCharCodes(value);
    //           print(responseString);
    //           var jsonData = jsonDecode(responseString);
    //           print('${jsonData.toString()}');
    //           RegistrationModel signInData = RegistrationModel.fromJson(jsonData);
    //           if ('${signInData.status}' == '1') {
    //             Navigator.of(context).pop();
    //           }
    //           Toast.show(signInData.message, context, gravity: Toast.CENTER, duration: Toast.LENGTH_SHORT);
    //           setState(() {
    //             showDialogBox = false;
    //           });
    //         }).catchError((e) {
    //           print(e);
    //           setState(() {
    //             showDialogBox = false;
    //           });
    //         });
    //       }).catchError((e) {
    //         setState(() {
    //           showDialogBox = false;
    //         });
    //         print(e);
    //       });
    //     }).catchError((e) {
    //       setState(() {
    //         showDialogBox = false;
    //       });
    //       print(e);
    //     });
    //   } else {
    //     print('not null');
    //     requestMulti.fields["profile"] = '';
    //     if (idPhoto != null) {
    //       String fid3 = idPhoto.path.split('/').last;

    //       requestMulti.files.add(await http.MultipartFile.fromPath('id_img', idPhoto.path));
    //     } else {
    //       requestMulti.fields['id_img'] = '';
    //     }
    //     requestMulti.send().then((value1) {
    //       value1.stream.toBytes().then((value) {
    //         var responseString = String.fromCharCodes(value);
    //         var jsonData = jsonDecode(responseString);
    //         print('${jsonData.toString()}');
    //         RegistrationModel signInData = RegistrationModel.fromJson(jsonData);
    //         if ('${signInData.status}' == '1') {
    //           Navigator.of(context).pop();
    //         }
    //         Toast.show(signInData.message, context, gravity: Toast.CENTER, duration: Toast.LENGTH_LONG);
    //         setState(() {
    //           showDialogBox = false;
    //         });
    //       }).catchError((e) {
    //         print(e);
    //         setState(() {
    //           showDialogBox = false;
    //         });
    //       });
    //     }).catchError((e) {
    //       setState(() {
    //         showDialogBox = false;
    //       });
    //     });
    //   }
    // } else {
    //   print('not null');
    //   requestMulti.fields["profile"] = '';
    //   if (idPhoto != null) {
    //     String fid4 = idPhoto.path.split('/').last;

    //     requestMulti.files.add(await http.MultipartFile.fromPath('id_img', idPhoto.path, filename: fid4));
    //   } else {
    //     requestMulti.fields['id_img'] = '';
    //   }
    //   requestMulti.send().then((value1) {
    //     value1.stream.toBytes().then((value) {
    //       var responseString = String.fromCharCodes(value);
    //       print(responseString);
    //       var jsonData = jsonDecode(responseString);
    //       print('${jsonData.toString()}');
    //       RegistrationModel signInData = RegistrationModel.fromJson(jsonData);
    //       if ('${signInData.status}' == '1') {
    //         Navigator.of(context).pop();
    //       }
    //       Toast.show(signInData.message, context, gravity: Toast.CENTER, duration: Toast.LENGTH_SHORT);
    //       setState(() {
    //         showDialogBox = false;
    //       });
    //     }).catchError((e) {
    //       print(e);
    //       setState(() {
    //         showDialogBox = false;
    //       });
    //     });
    //   }).catchError((e) {
    //     setState(() {
    //       showDialogBox = false;
    //     });
    //   });
    // }
  }
}
