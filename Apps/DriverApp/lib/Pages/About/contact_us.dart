import 'dart:convert';

import 'package:driver/Components/custom_button.dart';
import 'package:driver/Components/entry_field.dart';
import 'package:driver/Locale/locales.dart';
import 'package:driver/Pages/drawer.dart';
import 'package:driver/Theme/colors.dart';
import 'package:driver/Theme/style.dart';
import 'package:driver/baseurl/baseurlg.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:toast/toast.dart';

class ContactUsPage extends StatefulWidget {
  @override
  _ContactUsPageState createState() => _ContactUsPageState();
}

class _ContactUsPageState extends State<ContactUsPage> {
  TextEditingController numberC = TextEditingController();
  TextEditingController nameC = TextEditingController();
  TextEditingController messageC = TextEditingController();
  var userName;
  var userNumber;
  int numberlimit = 1;
  bool islogin = false;

  bool isLoading = false;

  var http = Client();

  @override
  void initState() {
    getProfileDetails();
    super.initState();
  }

  void getProfileDetails() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    setState(() {
      islogin = preferences.getBool('islogin');
      userName = preferences.getString('boy_name');
      userNumber = preferences.getString('boy_phone');
      numberlimit = int.parse('${preferences.getString('numberlimit')}');
      nameC.text = '$userName';
      numberC.text = '$userNumber';
    });
  }

  @override
  Widget build(BuildContext context) {
    var locale = AppLocalizations.of(context);
    return Scaffold(
      drawer: AccountDrawer(context),
      appBar: AppBar(
        foregroundColor: Colors.black,
        title: Text(
          locale.contactUs,
          style: TextStyle(color: kMainTextColor),
        ),
        centerTitle: true,
      ),
      body: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Image.asset(
                'assets/icon.png',
                scale: 2.5,
                height: 280,
              ),
              Container(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Text(
                        locale.callBackReq2,
                        style: Theme.of(context).textTheme.subtitle1.copyWith(fontSize: 16),
                      ),
                    ),
                    ClipRRect(
                      borderRadius: BorderRadius.circular(40),
                      child: ElevatedButton(
                        style: ButtonStyle(
                          shadowColor: MaterialStateProperty.all(primaryColor),
                          overlayColor: MaterialStateProperty.all(primaryColor),
                          backgroundColor: MaterialStateProperty.all(primaryColor),
                          foregroundColor: MaterialStateProperty.all(primaryColor),
                        ),
                        onPressed: () {
                          if (!isLoading) {
                            setState(() {
                              isLoading = true;
                            });
                            sendCallBackRequest(context);
                          }
                        },
                        child: Text(
                          locale.callBackReq1,
                          style: TextStyle(color: kMainTextColor),
                        ),
                      ),
                    )
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 20.0, horizontal: 5),
                child: Text(
                  locale.or,
                  textAlign: TextAlign.center,
                  style: Theme.of(context).textTheme.subtitle1.copyWith(fontSize: 17),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 5),
                child: Text(
                  locale.letUsKnowYourFeedbackQueriesIssueRegardingAppFeatures,
                  textAlign: TextAlign.center,
                  style: Theme.of(context).textTheme.subtitle1.copyWith(fontSize: 17),
                ),
              ),
              Divider(
                thickness: 3.5,
                color: Colors.transparent,
              ),
              EntryField(labelFontSize: 16, controller: nameC, labelFontWeight: FontWeight.w400, label: locale.fullName),
              EntryField(controller: numberC, labelFontSize: 16, maxLength: numberlimit, readOnly: true, labelFontWeight: FontWeight.w400, label: locale.phoneNumber),
              EntryField(hintStyle: Theme.of(context).textTheme.subtitle1.copyWith(color: kHintColor, fontSize: 18.3, fontWeight: FontWeight.w400), hint: locale.enterYourMessage, controller: messageC, labelFontSize: 16, labelFontWeight: FontWeight.w400, label: locale.yourFeedback),
              Divider(
                thickness: 3.5,
                color: Colors.transparent,
              ),
              isLoading
                  ? Container(
                      height: 60,
                      width: MediaQuery.of(context).size.width,
                      child: Align(
                        widthFactor: 40,
                        heightFactor: 40,
                        alignment: Alignment.center,
                        child: CircularProgressIndicator(),
                      ),
                    )
                  : CustomButton(
                      label: locale.submit,
                      onTap: () {
                        if (!isLoading) {
                          setState(() {
                            isLoading = true;
                          });
                          if (messageC.text != null) {
                            sendFeedBack(messageC.text);
                          } else {
                            setState(() {
                              isLoading = false;
                            });
                          }
                        }
                      },
                    )
            ],
          ),
        ),
      ),
    );
  }

  void sendFeedBack(dynamic message) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    http.post(driverFeedbackUrl, body: {'dboy_id': '${preferences.getInt('db_id')}', 'feedback': '$message'}).then((value) {
      print('ddv - ${value.body}');
      if (value.statusCode == 200) {
        var js = jsonDecode(value.body);
        if ('${js['status']}' == '1') {
          messageC.clear();
        }
        Toast.show(js['message'], context, duration: Toast.LENGTH_SHORT, gravity: Toast.CENTER);
      }
      setState(() {
        isLoading = false;
      });
    }).catchError((e) {
      setState(() {
        isLoading = false;
      });
    });
  }

  void sendCallBackRequest(BuildContext context) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    http.post(driverCallbackReqUrl, body: {
      'driver_id': '${preferences.getInt('db_id')}',
    }).then((value) {
      print('ddv - ${value.body}');
      if (value.statusCode == 200) {
        var js = jsonDecode(value.body);
        Toast.show(js['message'], context, duration: Toast.LENGTH_SHORT, gravity: Toast.CENTER);
      }
      setState(() {
        isLoading = false;
      });
    }).catchError((e) {
      setState(() {
        isLoading = false;
      });
    });
  }
}
