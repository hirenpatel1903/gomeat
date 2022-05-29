
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:google_place/google_place.dart';
import 'package:http/http.dart';
import 'package:mapbox_search/mapbox_search.dart';
import 'package:vendor/Locale/locales.dart';
import 'package:vendor/Theme/colors.dart';
import 'package:vendor/baseurl/baseurlg.dart';
import 'package:vendor/beanmodel/mapsection/googlemapkey.dart';
import 'package:vendor/beanmodel/mapsection/latlng.dart';
import 'package:vendor/beanmodel/mapsection/mapboxbean.dart';
import 'package:vendor/beanmodel/mapsection/mapbybean.dart';

class SearchLocation extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return SearchLocationState();
  }
}

class SearchLocationState extends State<SearchLocation> {
  var http = Client();
  bool isLoading = false;
  bool isDispose = false;
  GooglePlace places;
  PlacesSearch placesSearch;
  List<SearchResult> searchPredictions = [];
  List<MapBoxPlace> placePred = [];
  SearchResult pPredictions;
  MapBoxPlace mapboxPredictions;
  TextEditingController searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    searchController.addListener(() async {
      if(!isDispose){
        if (searchController.text != null && searchController.text.length > 0) {
          if (places != null) {
            await places.search.getTextSearch(searchController.text).then((value) {
              if (searchController.text != null &&
                  searchController.text.length > 0 && this.mounted) {
                setState(() {
                  searchPredictions.clear();
                  searchPredictions = List.from(value.results);
                  // print(value.candidates[0].formattedAddress);
                  // print(
                  //     '${value.candidates[0].geometry.location.lat} ${value.candidates[0].geometry.location.lng}');
                });
              } else {
                if(this.mounted){
                  setState(() {
                    searchPredictions.clear();
                  });
                }
              }
            }).catchError((e) {
              if(this.mounted){
                setState(() {
                  searchPredictions.clear();
                });
              }
            });
          } else if (placesSearch != null) {
            placesSearch.getPlaces(searchController.text).then((value) {
              if (searchController.text != null &&
                  searchController.text.length > 0 && this.mounted) {
                setState(() {
                  placePred.clear();
                  placePred = List.from(value);
                  print(value[0].placeName);
                  print(
                      '${value[0].geometry.coordinates[0]} ${value[0].geometry.coordinates[1]}');
                });
              } else {
                if(this.mounted){
                  setState(() {
                    placePred.clear();
                  });
                }
              }
            }).catchError((e) {
              if(this.mounted){
                setState(() {
                  placePred.clear();
                });
              }
            });
          }
        }
        else {
          if (places != null && this.mounted) {
            setState(() {
              searchPredictions.clear();
            });
          } else if (placesSearch != null && this.mounted) {
            setState(() {
              placePred.clear();
            });
          }
        }
      }
    });
    getMapbyApi();
  }

  void getMapbyApi() async {
    setState(() {
      isLoading = true;
    });
    http.get(mapbyUri).then((value) {
      if (value.statusCode == 200) {
        MapByKey googleMapD = MapByKey.fromJson(jsonDecode(value.body));
        if ('${googleMapD.status}' == '1') {
          if ('${googleMapD.data.mapbox}' == '1') {
            getMapBoxKey();
          } else if ('${googleMapD.data.googleMap}' == '1') {
            getGoogleMapKey();
          } else {
            setState(() {
              isLoading = false;
            });
          }
        } else {
          setState(() {
            isLoading = false;
          });
        }
      } else {
        setState(() {
          isLoading = false;
        });
      }
    }).catchError((e) {
      setState(() {
        isLoading = false;
      });
    });
  }

  void getGoogleMapKey() async {
    http.get(googleMapUri).then((value) {
      if (value.statusCode == 200) {
        GoogleMapKey googleMapD = GoogleMapKey.fromJson(jsonDecode(value.body));
        if ('${googleMapD.status}' == '1') {
          setState(() {
            places = new GooglePlace('${googleMapD.data.mapApiKey}');
          });
        }
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

  void getMapBoxKey() async {
    http.get(mapboxUri).then((value) {
      if (value.statusCode == 200) {
        MapBoxApiKey googleMapD = MapBoxApiKey.fromJson(jsonDecode(value.body));
        if ('${googleMapD.status}' == '1') {
          setState(() {
            placesSearch = PlacesSearch(
              apiKey: '${googleMapD.data.mapboxApi}',
              limit: 5,
            );
          });
        }
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

  @override
  void dispose() {
    http.close();
    isDispose = true;
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var locale = AppLocalizations.of(context);
    return Scaffold(
      backgroundColor: kCardBackgroundColor,
      appBar: AppBar(
        backgroundColor: Colors.white,
        titleSpacing: 0.0,
        title: Container(
          width: MediaQuery.of(context).size.width - 100,
          child: Text(
            locale.searchyourlocation,
            textAlign: TextAlign.center,
            style: Theme.of(context)
                .textTheme
                .bodyText1
                .copyWith(color: kMainTextColor.withOpacity(0.8)),
          ),
        ),
      ),
      body: Column(
        children: [
          Container(
            width: MediaQuery.of(context).size.width,
            height: 52,
            margin: EdgeInsets.only(left: 20,right: 20),
            decoration: BoxDecoration(
                color: kWhiteColor, borderRadius: BorderRadius.circular(10)),
            child: TextFormField(
              readOnly: isLoading,
              decoration: InputDecoration(
                hintText: locale.searchyourlocation,
                counterText: '',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10.0),
                  borderSide: BorderSide(color: kHintColor, width: 1),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10.0),
                  borderSide: BorderSide(color: kHintColor, width: 1),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10.0),
                  borderSide: BorderSide(color: kHintColor, width: 1),
                ),
              ),

              controller: searchController,
              // onEditingComplete: (){
              //   if(searchController.text!=null && searchController.text.length<=0){
              //     print('leg');
              //   }
              // },
            ),
          ),
          Expanded(
            child: SingleChildScrollView(
              primary: true,
              child: Column(
                children: [
                  Visibility(
                    visible: (searchPredictions != null &&
                        searchPredictions.length > 0),
                    child: Container(
                      width: MediaQuery.of(context).size.width * 0.85,
                      color: kWhiteColor,
                      margin: EdgeInsets.only(top: 5),
                      padding:
                      EdgeInsets.symmetric(vertical: 10.0, horizontal: 10),
                      child: ListView.separated(
                        itemCount: searchPredictions.length,
                        shrinkWrap: true,
                        primary: false,
                        scrollDirection: Axis.vertical,
                        itemBuilder: (context, index) {
                          return GestureDetector(
                            onTap: () {
                              setState(() {
                                pPredictions = searchPredictions[index];
                              });
                              Navigator.pop(
                                  context,
                                  BackLatLng(pPredictions.geometry.location.lat,
                                      pPredictions.geometry.location.lng,searchPredictions[index].formattedAddress));
                            },
                            behavior: HitTestBehavior.opaque,
                            child: Row(
                              children: <Widget>[
                                Container(
                                  height:15,
                                  width:15,
                                  child: Image.asset(
                                    'images/map_pin.png',
                                    scale: 3,
                                  ),
                                ),
                                SizedBox(
                                  width: 16.0,
                                ),
                                Expanded(
                                  child: Text(
                                    '${searchPredictions[index].formattedAddress}',
                                    overflow: TextOverflow.ellipsis,
                                    style: Theme.of(context).textTheme.caption,
                                    maxLines: 2,
                                  ),
                                ),
                              ],
                            ),
                          );
                        },
                        separatorBuilder: (context, index) {
                          return Divider(
                            thickness: 1,
                            color: kLightTextColor,
                          );
                        },
                      ),
                    ),
                  ),
                  Visibility(
                    visible: (placePred != null && placePred.length > 0),
                    child: Container(
                      width: MediaQuery.of(context).size.width * 0.85,
                      color: kWhiteColor,
                      margin: EdgeInsets.only(top: 5),
                      padding:
                      EdgeInsets.symmetric(vertical: 10.0, horizontal: 10),
                      child: ListView.separated(
                        itemCount: placePred.length,
                        shrinkWrap: true,
                        primary: false,
                        scrollDirection: Axis.vertical,
                        itemBuilder: (context, index) {
                          return GestureDetector(
                            onTap: () {
                              setState(() {
                                mapboxPredictions = placePred[index];
                              });
                              Navigator.pop(
                                  context,
                                  BackLatLng(
                                      mapboxPredictions.geometry.coordinates[1],
                                      mapboxPredictions.geometry.coordinates[0],placePred[index].placeName));
                            },
                            behavior: HitTestBehavior.opaque,
                            child: Row(
                              children: <Widget>[
                                Container(
                                  height:15,
                                  width:15,
                                  child: Image.asset(
                                    'images/map_pin.png',
                                    scale: 3,
                                  ),
                                ),
                                SizedBox(
                                  width: 16.0,
                                ),
                                Expanded(
                                  child: Text(
                                    '${placePred[index].placeName}',
                                    overflow: TextOverflow.ellipsis,
                                    style: Theme.of(context).textTheme.caption,
                                    maxLines: 2,
                                  ),
                                ),
                              ],
                            ),
                          );
                        },
                        separatorBuilder: (context, index) {
                          return Divider(
                            thickness: 1,
                            color: kLightTextColor,
                          );
                        },
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}