import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import "package:collection/collection.dart";
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:gomeat/models/businessLayer/baseRoute.dart';
import 'package:gomeat/models/businessLayer/global.dart' as global;
import 'package:gomeat/models/imageModel.dart';
import 'package:gomeat/models/messageModel.dart';
import 'package:gomeat/models/userChatModel.dart';
import 'package:intl/intl.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

class ChatScreen extends BaseRoute {
  ChatScreen({a, o}) : super(a: a, o: o, r: 'ChatScreen');

  @override
  _ChatScreenState createState() => _ChatScreenState();
}

class _ChatScreenState extends BaseRouteState {
  UserChat userChat = new UserChat();
  MessagesModel messageModel = new MessagesModel();
  List<MessagesModel> messages = [];
  TextEditingController _cMessage = new TextEditingController();
  bool isShowSticker = false;
  String chatId;
  bool isAlreadyChat = false;
  File _tImage;
  GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  DateTime _today = DateTime(DateTime.now().year, DateTime.now().month, DateTime.now().day);
  bottomChatBar() {
    return Container(
      color: Theme.of(context).scaffoldBackgroundColor,
      height: MediaQuery.of(context).size.height * 0.04,
      width: MediaQuery.of(context).size.width,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            width: 60,
            child: IconButton(
              icon: Icon(Icons.image),
              iconSize: 25,
              onPressed: () async {
                _showCupertinoModalSheet();
              },
            ),
          ),
          Expanded(
            child: Container(
              decoration: BoxDecoration(borderRadius: BorderRadius.all(Radius.circular(0.0))),
              padding: EdgeInsets.only(),
              child: TextFormField(
                controller: _cMessage,
                style: Theme.of(context).primaryTextTheme.bodyText1,
                decoration: InputDecoration(
                  fillColor: global.isDarkModeEnable ? Theme.of(context).inputDecorationTheme.fillColor : Theme.of(context).scaffoldBackgroundColor,
                  hintText: 'Type here',
                  contentPadding: EdgeInsets.only(top: 10, left: 10, right: 10),
                  suffixIcon: IconButton(
                    icon: Icon(Icons.send),
                    onPressed: () async {
                      await sendMessage();
                    },
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        await updateLastMessage(global.nearStoreModel.id, global.currentUser.id, messages.first.message);
        Navigator.of(context).pop();
        return null;
      },
      child: Scaffold(
        appBar: AppBar(
          leading: InkWell(
            customBorder: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(30),
            ),
            onTap: () async {
              Navigator.of(context).pop();
              await updateLastMessage(global.nearStoreModel.id, global.currentUser.id, messages.first.message);
            },
            child: Align(
              alignment: Alignment.center,
              child: Icon(MdiIcons.arrowLeft),
            ),
          ),
          centerTitle: true,
          title: Text("Customer Support"),
        ),
        body: LayoutBuilder(
          builder: (context, constraints) => Scrollbar(
            child: Column(
              children: [
                SizedBox(
                  height: 15,
                ),
                Expanded(
                  child: StreamBuilder<List<MessagesModel>>(
                      stream: apiHelper.getChatMessages(chatId, global.currentUser.id.toString()),
                      builder: (context, snapshot) {
                        switch (snapshot.connectionState) {
                          default:
                            if (snapshot.hasError) {
                              print(snapshot.error);
                              return buildText('Something Went Wrong Try later');
                            } else {
                              messages = snapshot.data;
                              if (messages == null) {
                                messages = [];
                              }

                              return messages.isEmpty
                                  ? buildText('say hi')
                                  : Padding(
                                      padding: EdgeInsets.only(bottom: MediaQuery.of(context).size.height * 0.12),
                                      child: ListView.builder(
                                        reverse: true,
                                        physics: BouncingScrollPhysics(),
                                        itemCount: messages.length,
                                        itemBuilder: (context, index) {
                                          var groupDate = groupBy(messages, (a) => a.createdAt.toString().substring(0, 10));
                                          groupDate.forEach((key, value) {
                                            print("key  " + key.toString());
                                            MessagesModel m = value.lastWhere((e) => e.createdAt.toString().substring(0, 10) == key.toString());
                                            // _messageList[_messageList.indexOf(m)].isShowTime = true;
                                            messages[messages.indexOf(m)].isShowDate = true;

                                            print('  ${key.toString()}  +  ' + m.createdAt.toString().substring(0, 10) + '${m.createdAt.toString().substring(0, 10) == key.toString()}');
                                          });
                                          final message = messages[index];
                                          return _buildMessage(
                                            message,
                                            message.userId1 == global.currentUser.id.toString(),
                                          );
                                        },
                                      ),
                                    );
                            }
                        }
                      }),
                )
              ],
            ),
          ),
        ),
        bottomSheet: Container(
          height: MediaQuery.of(context).size.height * 0.12,
          child: bottomChatBar(),
        ),
      ),
    );
  }

  Widget buildText(String text) => Center(
        child: Text(
          text,
          style: Theme.of(context).primaryTextTheme.bodyText1,
        ),
      );

  Future<void> checkChatStoreExist() async {
    try {
      var result;
      print(global.currentUser.userImage);
      print(global.currentUser.name);
      result = await apiHelper.checkStoreExist(global.nearStoreModel.id, global.currentUser.id);
      await apiHelper.updateFirebaseUserFcmToken(global.currentUser.id, global.appDeviceId);
      chatId = result.id;
      setState(() {});
    } catch (e) {
      print("Exception - chatScreen.dart - checkChatStoreExist(): " + e.toString());
    }
  }

  @override
  void initState() {
    super.initState();

    _init();
  }

  Future<void> sendMessage() async {
    if (chatId != null) {
      if (_cMessage.text.trim() != '') {
        messageModel.message = _cMessage.text;
        messageModel.isActive = true;
        messageModel.isDelete = false;
        messageModel.createdAt = DateTime.now();
        messageModel.updatedAt = DateTime.now();
        messageModel.isRead = true;
        messageModel.userId1 = global.currentUser.id.toString();
        messageModel.userId2 = "${global.nearStoreModel.id}";
        messageModel.url = "";
        _cMessage.clear();
        await apiHelper.uploadMessage(chatId, '${global.nearStoreModel.id}', messageModel, isAlreadyChat, '');

        setState(() {
          isAlreadyChat = true;
        });
        await apiHelper.callOnFcmApiSendPushNotifications(
            userToken: [global.nearStoreModel.deviceId],
            title: "new message from ${global.currentUser.name}",
            body: "${messageModel.message}",
            route: "chatlist_screen",
            chatId: chatId,
            firstName: global.currentUser.name,
            lastName: global.currentUser.name,
            userId: global.currentUser.id.toString(),
            imageUrl: '',
            storeId: global.nearStoreModel.id.toString(),
            globalUserToken: global.appDeviceId);
      }
    } else {
      showSnackBar(key: _scaffoldKey, snackBarMessage: 'Something wend Wrong');
    }
  }

  Future updateLastMessage(int storeId, int userId, String lastMessage) async {
    try {
      List<QueryDocumentSnapshot> storeData = (await FirebaseFirestore.instance.collectionGroup("store").where('storeId', isEqualTo: storeId).where('userId', isEqualTo: userId).get()).docs.toList();
      if (storeData.isNotEmpty) {
        FirebaseFirestore.instance.collection("store").doc(storeData[0].id).update({"lastMessage": lastMessage, "lastMessageTime": DateTime.now().toUtc(), "updatedAt": DateTime.now().toUtc()});
      }
      print('hello ');
    } catch (e) {
      print("Exception - chatScreen.dart - updateLastMessage():" + e.toString());
    }
  }

  _buildMessage(MessagesModel message, bool isMe) {
    DateTime _indexTime = DateTime(message.createdAt.year, message.createdAt.month, message.createdAt.day);
    return Column(
      children: [
        message.isShowDate
            ? Padding(
                padding: const EdgeInsets.only(top: 45, bottom: 15),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Expanded(
                      child: Divider(
                        thickness: 0.6,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 25.0),
                      child: Text(
                        '${_today.difference(_indexTime).inDays == 0 ? 'Today' : _today.difference(_indexTime).inDays == 1 ? 'Yesterday' : DateFormat('MMM dd, yyyy').format(message.createdAt)}',
                        style: Theme.of(context).primaryTextTheme.bodyText1,
                      ),
                    ),
                    Expanded(
                      child: Divider(
                        thickness: 0.6,
                      ),
                    ),
                  ],
                ),
              )
            : SizedBox(),
        isMe
            ? Padding(
                padding: const EdgeInsets.only(right: 10, top: 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Flexible(
                        child: GestureDetector(
                      onTap: () {
                        if (message.url != '') {
                          FocusScope.of(context).unfocus();

                          ImageModel _imag = new ImageModel();
                          _imag.image = message.url;
                          dialogToOpenImage('Customer Support', [_imag], 0, screenId: 0);
                        }
                      },
                      child: Container(
                        height: message.message == global.imageUploadMessageKey ? 200 : null,
                        width: message.message == global.imageUploadMessageKey ? 200 : null,
                        margin: isMe ? EdgeInsets.only(top: 8.0, bottom: 8.0, left: 50.0) : EdgeInsets.only(top: 8.0, bottom: 8.0, right: 80.0),
                        decoration: BoxDecoration(
                            image: message.url != "" ? DecorationImage(image: NetworkImage(message.url), fit: BoxFit.cover) : null,
                            border: message.message == global.imageUploadMessageKey ? Border.all(color: Colors.white, width: 2) : null,
                            borderRadius: isMe ? BorderRadius.only(topLeft: Radius.circular(25.0), bottomLeft: Radius.circular(25.0), topRight: Radius.circular(15.0)) : BorderRadius.only(bottomRight: Radius.circular(15.0), topRight: Radius.circular(15.0), topLeft: Radius.circular(15.0))),
                        child: message.message == global.imageUploadMessageKey && message.url == ""
                            ? Center(
                                child: CircularProgressIndicator(),
                              )
                            : (message.message != "" && message.message != global.imageUploadMessageKey)
                                ? Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Container(
                                        margin: EdgeInsets.all(3),
                                        constraints: BoxConstraints(maxWidth: MediaQuery.of(context).size.width * .6),
                                        padding: const EdgeInsets.all(10.0),
                                        decoration: BoxDecoration(
                                          color: Theme.of(context).cardTheme.color,
                                          borderRadius: BorderRadius.only(topLeft: Radius.circular(10), topRight: Radius.circular(10), bottomLeft: Radius.circular(10)),
                                        ),
                                        child: Text(message.message, style: Theme.of(context).primaryTextTheme.bodyText1),
                                      ),
                                      Text(
                                        '${DateFormat().add_jm().format(message.createdAt)}',
                                        style: Theme.of(context).primaryTextTheme.headline2,
                                      )
                                    ],
                                  )
                                : SizedBox(),
                      ),
                    )),
                  ],
                ),
              )
            : Padding(
                padding: const EdgeInsets.only(left: 10, top: 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Icon(
                      Icons.person,
                      color: Theme.of(context).primaryTextTheme.bodyText1.color,
                    ),
                    Flexible(
                        child: Container(
                      height: message.message == global.imageUploadMessageKey ? 200 : null,
                      width: message.message == global.imageUploadMessageKey ? 200 : null,
                      margin: isMe ? EdgeInsets.only(top: 8.0, bottom: 8.0, left: 50.0) : EdgeInsets.only(top: 8.0, bottom: 8.0, right: 80.0),
                      decoration: BoxDecoration(
                          image: message.url != "" ? DecorationImage(image: NetworkImage(message.url), fit: BoxFit.cover) : null,
                          border: message.message == global.imageUploadMessageKey ? Border.all(color: Colors.white, width: 2) : null,
                          borderRadius: isMe ? BorderRadius.only(topLeft: Radius.circular(25.0), bottomLeft: Radius.circular(25.0), topRight: Radius.circular(15.0)) : BorderRadius.only(bottomRight: Radius.circular(15.0), topRight: Radius.circular(15.0), topLeft: Radius.circular(15.0))),
                      child: message.message == global.imageUploadMessageKey && message.url == ""
                          ? Center(
                              child: CircularProgressIndicator(),
                            )
                          : (message.message != "" && message.message != global.imageUploadMessageKey)
                              ? Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Container(
                                      margin: EdgeInsets.all(3),
                                      constraints: BoxConstraints(maxWidth: MediaQuery.of(context).size.width * .6),
                                      padding: const EdgeInsets.all(10.0),
                                      decoration: BoxDecoration(
                                        color: Theme.of(context).cardTheme.color,
                                        //color: const Color(0xffF4F4F4),
                                        borderRadius: BorderRadius.only(topLeft: Radius.circular(10), topRight: Radius.circular(10), bottomRight: Radius.circular(10)),
                                      ),
                                      child: Text(
                                        message.message,
                                        style: Theme.of(context).primaryTextTheme.bodyText1,
                                      ),
                                    ),
                                    Text(
                                      '${DateFormat().add_jm().format(message.createdAt)}',
                                      style: Theme.of(context).primaryTextTheme.headline2,
                                    )
                                  ],
                                )
                              : SizedBox(),
                    )),
                  ],
                ),
              )
      ],
    );
  }

  Future _init() async {
    try {
      global.appDeviceId = await FirebaseMessaging.instance.getToken();
      print('${global.nearStoreModel.id}');
      await checkChatStoreExist();
    } catch (e) {
      print('Exception - chat_screen.dart - _init():' + e.toString());
    }
  }

  _showCupertinoModalSheet() {
    try {
      showCupertinoModalPopup(
        context: context,
        builder: (BuildContext context) => CupertinoActionSheet(
          title: Text(AppLocalizations.of(context).lbl_actions),
          actions: [
            CupertinoActionSheetAction(
              child: Text('${AppLocalizations.of(context).lbl_take_picture}', style: TextStyle(color: Color(0xFF171D2C))),
              onPressed: () async {
                Navigator.pop(context);
                showOnlyLoaderDialog();
                _tImage = await br.openCamera();
                if (_tImage != null) {
                  messageModel.message = global.imageUploadMessageKey;
                  messageModel.isActive = true;
                  messageModel.isDelete = false;
                  messageModel.createdAt = DateTime.now();
                  messageModel.updatedAt = DateTime.now();
                  messageModel.isRead = true;
                  messageModel.userId1 = global.currentUser.id.toString();
                  messageModel.userId2 = "${global.nearStoreModel.id}";
                  messageModel.url = "";
                  await apiHelper.uploadImageToStorage(_tImage, chatId, global.nearStoreModel.id.toString(), messageModel);

                  setState(() {});
                }
                hideLoader();

                setState(() {});
              },
            ),
            CupertinoActionSheetAction(
              child: Text(AppLocalizations.of(context).lbl_choose_from_library, style: TextStyle(color: Color(0xFF171D2C))),
              onPressed: () async {
                Navigator.pop(context);
                showOnlyLoaderDialog();
                _tImage = await br.selectImageFromGallery();
                if (_tImage != null) {
                  messageModel.message = global.imageUploadMessageKey;
                  messageModel.isActive = true;
                  messageModel.isDelete = false;
                  messageModel.createdAt = DateTime.now();
                  messageModel.updatedAt = DateTime.now();
                  messageModel.isRead = true;
                  messageModel.userId1 = global.currentUser.id.toString();
                  messageModel.userId2 = "${global.nearStoreModel.id}";
                  messageModel.url = "";
                  await apiHelper.uploadImageToStorage(_tImage, chatId, global.nearStoreModel.id.toString(), messageModel);

                  setState(() {});
                }
                hideLoader();

                setState(() {});
              },
            )
          ],
          cancelButton: CupertinoActionSheetAction(
            child: Text(AppLocalizations.of(context).lbl_cancel, style: TextStyle(color: Color(0xFFFA692C))),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
        ),
      );
    } catch (e) {
      print("Exception - profileEditScreen.dart - _showCupertinoModalSheet():" + e.toString());
    }
  }
}
