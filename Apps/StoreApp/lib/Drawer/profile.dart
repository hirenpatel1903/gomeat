import 'dart:convert';
import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_image_compress/flutter_image_compress.dart';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:toast/toast.dart';
import 'package:vendor/Components/custom_button.dart';
import 'package:vendor/Components/entry_field.dart';
import 'package:vendor/Locale/locales.dart';
import 'package:vendor/Theme/colors.dart';
import 'package:vendor/baseurl/baseurlg.dart';
import 'package:vendor/beanmodel/profilebean/storeprofile.dart';

class MyProfile extends StatefulWidget {
  @override
  _MyProfileState createState() => _MyProfileState();
}

class _MyProfileState extends State<MyProfile> {
  TextEditingController sellerNameC = TextEditingController();
  TextEditingController storeNameC = TextEditingController();
  TextEditingController emailAddressC = TextEditingController();
  TextEditingController phoneNumberC = TextEditingController();
  TextEditingController addressC = TextEditingController();
  TextEditingController passwordC = TextEditingController();
  var storeImage;
  bool isLoading = false;
  File _image;
  final picker = ImagePicker();

  @override
  void initState() {
    super.initState();
    getProfileData();
  }

  void getProfileData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    // prefs.getInt('store_id');
    setState(() {
      isLoading = true;
      storeNameC.text = '${prefs.getString('store_name')}';
      sellerNameC.text = '${prefs.getString('owner_name')}';
      phoneNumberC.text = '${prefs.getString('store_phone')}';
      emailAddressC.text = '${prefs.getString('store_email')}';
      addressC.text = '${prefs.getString('store_address')}';
      //passwordC.text = '${prefs.getString('store_password')}';
      storeImage = '${prefs.getString('store_photo')}';
    });
    var https = http.Client();
    https.post(storeProfileUri, body: {'store_id': '${prefs.getInt('store_id')}'}).then((value) {
      print(value.body);
      if (value.statusCode == 200) {
        StoreProfileMain jsData = StoreProfileMain.fromJson(jsonDecode(value.body));
        if ('${jsData.status}' == '1') {
          setState(() {
            sellerNameC.text = '${jsData.data.owner_name}';
            storeNameC.text = '${jsData.data.store_name}';
            phoneNumberC.text = '${jsData.data.phone_number}';
            emailAddressC.text = '${jsData.data.email}';
            addressC.text = '${jsData.data.address}';
            //passwordC.text = '${jsData.data.password}';
            storeImage = Uri.parse('$imagebaseUrl${jsData.data.store_photo}');
          });
          prefs.setString('store_name', storeNameC.text);
          prefs.setString('owner_name', sellerNameC.text);
          prefs.setString('store_phone', phoneNumberC.text);
          prefs.setString('store_email', emailAddressC.text);
          prefs.setString('store_address', addressC.text);
          prefs.setString('store_photo', storeImage);
          //prefs.setString('store_password', passwordC.text);
        }
      }
      setState(() {
        isLoading = false;
      });
    }).catchError((e) {
      setState(() {
        isLoading = false;
      });
      print(e);
    });
  }

  _imgFromCamera() async {
    var pathd = await getApplicationDocumentsDirectory();
    final pickedFile = await picker.pickImage(source: ImageSource.camera);

    if (pickedFile != null) {
      setState(() {
        _image = File(pickedFile.path);
      });
      compressImageFile(_image, '${pathd.path}/${DateTime.now()}.jpg');
    } else {
      print('No image selected.');
    }
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

  _imgFromGallery() async {
    var pathd = await getApplicationDocumentsDirectory();
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

  @override
  Widget build(BuildContext context) {
    var locale = AppLocalizations.of(context);
    return Scaffold(
      body: Stack(
        children: [
          SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Stack(
                  alignment: Alignment.bottomLeft,
                  children: [
                    _image != null
                        ? Container(
                            padding: const EdgeInsets.only(top: 30, left: 10, right: 10),
                            width: MediaQuery.of(context).size.width,
                            height: 230,
                            alignment: Alignment.center,
                            child: Image.file(
                              _image,
                              fit: BoxFit.contain,
                            ),
                          )
                        : Container(
                            padding: const EdgeInsets.only(top: 30, left: 10, right: 10),
                            width: MediaQuery.of(context).size.width,
                            height: 230,
                            alignment: Alignment.center,
                            child: CachedNetworkImage(
                              width: MediaQuery.of(context).size.width,
                              height: 230,
                              imageUrl: '$storeImage',
                              fit: BoxFit.fill,
                              placeholder: (context, url) => Align(
                                widthFactor: 50,
                                heightFactor: 50,
                                alignment: Alignment.center,
                                child: Container(
                                  padding: const EdgeInsets.all(5.0),
                                  width: 50,
                                  height: 50,
                                  child: CircularProgressIndicator(),
                                ),
                              ),
                              errorWidget: (context, url, error) => Image.asset(
                                'assets/icon.png',
                                fit: BoxFit.fill,
                              ),
                            ),
                          ),
                    Positioned.directional(
                        top: 40,
                        textDirection: Directionality.of(context),
                        child: IconButton(
                            onPressed: () {
                              Navigator.pop(context);
                            },
                            icon: Icon(
                              Icons.arrow_back_ios,
                              color: kMainTextColor,
                            ))),
                  ],
                ),
                GestureDetector(
                  onTap: () {
                    _showPicker(context);
                  },
                  behavior: HitTestBehavior.opaque,
                  child: Padding(
                    padding: const EdgeInsets.only(left: 10, top: 15),
                    child: Row(
                      children: [
                        Icon(
                          Icons.camera_alt,
                          color: kMainTextColor,
                        ),
                        SizedBox(
                          width: 15,
                        ),
                        Text(
                          locale.changeCoverImage,
                          style: Theme.of(context).textTheme.bodyText1.copyWith(color: kMainTextColor),
                        ),
                      ],
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 22.0, vertical: 12),
                  child: Text(
                    locale.setProfileInfo,
                    style: Theme.of(context).textTheme.subtitle2.copyWith(fontWeight: FontWeight.w500),
                  ),
                ),
                EntryField(
                  label: locale.storename1,
                  hint: locale.storename2,
                  labelFontSize: 16,
                  labelFontWeight: FontWeight.w400,
                  controller: storeNameC,
                ),
                EntryField(
                  label: locale.sellerName,
                  labelFontSize: 16,
                  labelFontWeight: FontWeight.w400,
                  controller: sellerNameC,
                ),
                EntryField(
                  label: locale.emailAddress,
                  labelFontSize: 16,
                  labelFontWeight: FontWeight.w400,
                  controller: emailAddressC,
                ),
                EntryField(
                  label: locale.password1,
                  hint: 'enter new password if you want to change',
                  hintStyle: TextStyle(fontSize: 16),
                  labelFontSize: 16,
                  labelFontWeight: FontWeight.w400,
                  controller: passwordC,
                ),
                EntryField(
                  label: locale.phoneNumber,
                  labelFontSize: 16,
                  readOnly: true,
                  labelFontWeight: FontWeight.w400,
                  controller: phoneNumberC,
                ),
                Divider(
                  height: 30,
                  thickness: 8,
                  color: Colors.grey[100],
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 10, right: 10),
                  child: Text(
                    'Seller Address',
                    style: Theme.of(context).textTheme.bodyText2.copyWith(fontWeight: FontWeight.w400, fontSize: 16),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 10, right: 10),
                  child: Text(
                    'you cannot change it if you want to change it contact admin',
                    style: Theme.of(context).textTheme.subtitle2.copyWith(fontWeight: FontWeight.w500, fontSize: 16),
                  ),
                ),
                // Padding(
                //   padding: const EdgeInsets.symmetric(horizontal: 22.0, vertical: 8),
                //   child: Column(
                //     children: [
                //       Row(
                //         children: [
                //           Text(
                //             'you cannot change it if you want to change it contact admin',
                //             style: Theme.of(context).textTheme.subtitle2.copyWith(fontWeight: FontWeight.w500, fontSize: 16),
                //           ),
                //           Spacer(),
                //           Icon(
                //             Icons.location_on,
                //             color: Theme.of(context).primaryColor,
                //           ),
                //         ],
                //       ),

                //     ],
                //   ),
                // ),
                Padding(
                  padding: const EdgeInsets.only(left: 10, right: 10),
                  child: TextFormField(
                    maxLines: 3,
                    controller: addressC,
                    readOnly: true,
                    decoration: InputDecoration(enabledBorder: UnderlineInputBorder(borderSide: BorderSide(color: Colors.grey[200]))),
                  ),
                ),
                SizedBox(
                  height: 60,
                ),
              ],
            ),
          ),
          (!isLoading)
              ? Align(
                  alignment: Alignment.bottomCenter,
                  child: CustomButton(
                    onTap: () {
                      if (storeNameC.text != null) {
                        if (emailAddressC.text != null && emailValidator(emailAddressC.text)) {
                          if (sellerNameC.text != null && sellerNameC.text.length > 0) {
                            String fid = (_image != null) ? _image.path.split('/').last : null;
                            if (fid != null && fid.length > 0) {
                              updateWithImage(fid);
                            } else {
                              updateProfileData();
                            }
                          } else {
                            setState(() {
                              isLoading = false;
                            });
                            Toast.show(locale.incorectUserName, context, gravity: Toast.CENTER, duration: Toast.LENGTH_SHORT);
                          }
                        } else {
                          setState(() {
                            isLoading = false;
                          });
                          Toast.show(locale.incorectEmail, context, gravity: Toast.CENTER, duration: Toast.LENGTH_SHORT);
                        }
                      } else {
                        setState(() {
                          isLoading = false;
                        });
                        Toast.show(locale.incorectUserName, context, gravity: Toast.CENTER, duration: Toast.LENGTH_SHORT);
                      }
                    },
                    label: locale.update,
                  ))
              : Align(
                  alignment: Alignment.bottomCenter,
                  child: Container(
                    width: MediaQuery.of(context).size.width,
                    height: 52,
                    alignment: Alignment.center,
                    child: Align(
                      widthFactor: 30,
                      heightFactor: 30,
                      alignment: Alignment.center,
                      child: CircularProgressIndicator(),
                    ),
                  ),
                )
        ],
      ),
    );
  }

  bool emailValidator(email) {
    return RegExp(r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+").hasMatch(email);
  }

  void updateWithImage(String fileP) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var dio = Dio();
    var formData = FormData.fromMap({
      'store_id': '${prefs.getInt('store_id')}',
      'owner_name': '${sellerNameC.text}',
      'store_name': '${storeNameC.text}',
      'store_phone': '${phoneNumberC.text}',
      'store_email': '${emailAddressC.text}',
      if (passwordC.text != null && passwordC.text != '' && passwordC.text.isNotEmpty) 'password': '${passwordC.text}',
      'store_photo': _image != null ? await MultipartFile.fromFile(_image.path) : null,
    });

    await dio
        .post(storeUpdateProfileUri.toString(),
            data: formData,
            options: Options(
                // headers: await global.getApiHeaders(false),
                ))
        .then((response) {
      if (response != null) {
        print('success');
        Toast.show(response.data['message'], context, gravity: Toast.CENTER, duration: Toast.LENGTH_SHORT);

        StoreProfileDataMain jsData = StoreProfileDataMain.fromJson(response.data['data'][0]);
        setState(() {
          sellerNameC.text = '${jsData.owner_name}';
          storeNameC.text = '${jsData.store_name}';
          phoneNumberC.text = '${jsData.phone_number}';
          emailAddressC.text = '${jsData.email}';
          addressC.text = '${jsData.address}';
          //passwordC.text = '${jsData.password}';
          storeImage = Uri.parse('$imagebaseUrl${jsData.store_photo}');
        });
        prefs.setString('store_name', storeNameC.text);
        prefs.setString('owner_name', sellerNameC.text);
        prefs.setString('store_phone', phoneNumberC.text);
        prefs.setString('store_email', emailAddressC.text);
        prefs.setString('store_address', addressC.text);
        prefs.setString('store_photo', storeImage);
        prefs.setString('store_password', jsData.password);
        setState(() {
          isLoading = false;
        });
      }
    }).catchError((e) {
      print(e.toString());
    });
    // var requestMulti = http.MultipartRequest('POST', storeUpdateProfileUri);
    // requestMulti.fields["store_id"] = '${prefs.getInt('store_id')}';
    // requestMulti.fields["owner_name"] = '${sellerNameC.text}';
    // requestMulti.fields["store_name"] = '${storeNameC.text}';
    // requestMulti.fields["store_phone"] = '${phoneNumberC.text}';
    // requestMulti.fields["store_email"] = '${emailAddressC.text}';
    // requestMulti.fields["password"] = '${passwordC.text}';
    // http.MultipartFile.fromPath('store_image', _image.path, filename: fileP).then((pic) {
    //   requestMulti.files.add(pic);
    //   requestMulti.send().then((values) {
    //     values.stream.toBytes().then((value) {
    //       var responseString = String.fromCharCodes(value);
    //       var jsonData = jsonDecode(responseString);
    //       print('${jsonData.toString()}');

    //       setState(() {
    //         isLoading = false;
    //       });
    //     }).catchError((e) {
    //       print(e);
    //       setState(() {
    //         isLoading = false;
    //       });
    //     });
    //   }).catchError((e) {
    //     setState(() {
    //       isLoading = false;
    //     });
    //     print(e);
    //   });
    // }).catchError((e) {
    //   setState(() {
    //     isLoading = false;
    //   });
    //   print(e);
    // });
  }

  void updateProfileData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var https = http.Client();
    https.post(storeUpdateProfileUri, body: {
      'store_id': '${prefs.getInt('store_id')}',
      'owner_name': '${sellerNameC.text}',
      'store_name': '${storeNameC.text}',
      'store_phone': '${phoneNumberC.text}',
      'store_email': '${emailAddressC.text}',
      if (passwordC.text != null && passwordC.text != '' && passwordC.text.isNotEmpty) 'password': '${passwordC.text}',
      'store_photo': '',
    }).then((value) {
      print('${value.body}');
      if (value.statusCode == 200) {
        StoreProfileMain jsData = StoreProfileMain.fromJson(jsonDecode(value.body));
        if ('${jsData.status}' == '1') {
          Toast.show(jsData.message, context, gravity: Toast.CENTER, duration: Toast.LENGTH_SHORT);
          setState(() {
            sellerNameC.text = '${jsData.data.owner_name}';
            storeNameC.text = '${jsData.data.store_name}';
            phoneNumberC.text = '${jsData.data.phone_number}';
            emailAddressC.text = '${jsData.data.email}';
            addressC.text = '${jsData.data.address}';
            //passwordC.text = '${jsData.data.password}';
            storeImage = Uri.parse('$imagebaseUrl${jsData.data.store_photo}');
          });
          prefs.setString('store_name', storeNameC.text);
          prefs.setString('owner_name', sellerNameC.text);
          prefs.setString('store_phone', phoneNumberC.text);
          prefs.setString('store_email', emailAddressC.text);
          prefs.setString('store_address', addressC.text);
          prefs.setString('store_photo', storeImage);
          prefs.setString('store_password', jsData.data.password);
        }
      }
      setState(() {
        isLoading = false;
      });
    }).catchError((e) {
      print(e);
      setState(() {
        isLoading = false;
      });
    });
  }
}
