import 'dart:convert';
import 'package:carismatic/animation/fadeAnimation.dart';
import 'package:carismatic/model/automobile.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:carismatic/constants/constant.dart';

// TODO: Import google_mobile_ads.dart
import 'package:google_mobile_ads/google_mobile_ads.dart';
// TODO: Import ad_helper.dart
import 'package:carismatic/ui/home/ad_helper.dart';



import 'package:carismatic/model/search_model.dart';
import 'package:carismatic/ui/reusable/global_function.dart';
import 'package:carismatic/ui/reusable/global_widget.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';

class TabHomePage extends StatefulWidget {
  const TabHomePage({ Key? key }) : super(key: key);



  @override
  _TabHomePageState createState() => _TabHomePageState();
}

class _TabHomePageState extends State<TabHomePage> with TickerProviderStateMixin {
  DateTime _selectedDate = DateTime.now(), initialDate = DateTime.now();
  TextEditingController _etDate = TextEditingController();
// TODO: Add _bannerAd
  BannerAd? _bannerAd;
  // COMPLETE: Add _interstitialAd
  InterstitialAd? _interstitialAd;

  // initialize global widget
  final _globalWidget = GlobalWidget();
  final _globalFunction = GlobalFunction();

  List<SearchModel> _getSuggestions(String query) {
    List<SearchModel> matches = [];
    matches.addAll(searchData);
    matches.retainWhere((data) => data.name.toLowerCase().contains(query.toLowerCase()));
    return matches;
  }

  String? _valYear;
  String? _valBrand;
  String? _valModel;
  final List _brandList = [
    "BMW",
    "Mercedes-Benz",
  ];
  final List _modelList = [
    "5 Series",
    "4 Series",
    "GLA 250",
    "CLA 250",
  ];

  final TextEditingController _etSearch = TextEditingController();
  late ScrollController _scrollController;
  bool _isScrolled = false;

  List<dynamic> automobileList = [];
  List<dynamic> myList = [];
  // List<dynamic> mercedesList = [];




  var selectedRange = const RangeValues(150.00, 1500.00);


  void _moveToHome() {
    showSaveModal();
  }


  // COMPLETE: Implement _loadInterstitialAd()
  void _loadInterstitialAd() {
    InterstitialAd.load(
      adUnitId: AdHelper.interstitialAdUnitId,
      request: const AdRequest(),
      adLoadCallback: InterstitialAdLoadCallback(
        onAdLoaded: (ad) {
          ad.fullScreenContentCallback = FullScreenContentCallback(
            onAdDismissedFullScreenContent: (ad) {
              _moveToHome();
            },
          );

          setState(() {
            _interstitialAd = ad;
          });
        },
        onAdFailedToLoad: (err) {
          debugPrint('Failed to load an interstitial ad: ${err.message}');
        },
      ),
    );
  }


  @override
  void initState() {
    _etDate = TextEditingController(text: _selectedDate.toLocal().toString().split(' ')[0]);
    _scrollController = ScrollController();
    _scrollController.addListener(_listenToScrollChange);
    // automobiles();
    myAutomobiles();
    // mercedesAutomobiles();


    // COMPLETE: Load a Interstitial Ad
    _loadInterstitialAd();
    // TODO: Load a banner ad
    BannerAd(
      adUnitId: AdHelper.bannerAdUnitId,
      request: const AdRequest(),
      size: AdSize.banner,
      listener: BannerAdListener(
        onAdLoaded: (ad) {
          setState(() {
            _bannerAd = ad as BannerAd;
          });
        },
        onAdFailedToLoad: (ad, err) {
          print('Failed to load a banner ad: ${err.message}');
          ad.dispose();
        },
      ),
    ).load();

    super.initState();
  }

  @override
  void dispose() {
    _etSearch.dispose();
    _etDate.dispose();

    // TODO: Dispose a BannerAd object
    _bannerAd?.dispose();
    // TODO: Dispose a RewardedAd object
    // TODO: Dispose an InterstitialAd object
    _interstitialAd?.dispose();

    super.dispose();
  }


  Future<InitializationStatus> _initGoogleMobileAds() {
    // TODO: Initialize Google Mobile Ads SDK
    return MobileAds.instance.initialize();
  }
  void _listenToScrollChange() {
    if (_scrollController.offset >= 100.0) {
      setState(() {
        _isScrolled = true;
      });
    } else {
      setState(() {
        _isScrolled = false;
      });
    }
  }



  @override
  Widget build(BuildContext context) {
    final double boxImageSize = (MediaQuery.of(context).size.width / 6);
    return Scaffold(
        body: SafeArea(
        child: Stack(
        children: [
        CustomScrollView(
        controller: _scrollController,
        slivers: [
          SliverAppBar(
            expandedHeight: 200.0,
            elevation: 0,
            pinned: true,
            floating: true,
            stretch: true,
            backgroundColor: Colors.grey.shade50,
            flexibleSpace: FlexibleSpaceBar(
                collapseMode: CollapseMode.pin,
                titlePadding: const EdgeInsets.only(left: 20, right: 30, bottom: 100),
                stretchModes: const [
                  StretchMode.zoomBackground,
                  // StretchMode.fadeTitle
                ],
                title: AnimatedOpacity(
                  opacity: _isScrolled ? 0.0 : 1.0,
                  duration: const Duration(milliseconds: 500),
                  child: FadeAnimation(1, const Text("Your Car Collection",
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 25.0,
                      ),
                    textAlign: TextAlign.center,)),
                ),
                background: Image.asset("assets/images/background.png", fit: BoxFit.cover,)
            ),
            bottom: AppBar(
              toolbarHeight: 70,
              elevation: 0,
              backgroundColor: Colors.transparent,
              title: Row(
                children: [
                  Expanded(
                    child: FadeAnimation(1.4, SizedBox(
                      height: 50,
                      child: Container(
                        margin: const EdgeInsets.symmetric(vertical: 8),
                        child: TypeAheadField(
                          textFieldConfiguration: const TextFieldConfiguration(
                            textAlignVertical: TextAlignVertical.bottom,
                            decoration: InputDecoration(
                                contentPadding: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                                filled: true,
                                fillColor: Colors.white,
                                prefixIcon: Icon(Icons.search, color: Colors.black),
                                border: OutlineInputBorder(),
                                hintText: 'Search Automobile',
                              hintStyle:TextStyle(fontSize: 20.0, color: PRIMARY_COLOR, )
                            ),

                          ),
                          suggestionsCallback: (pattern) {
                            return _getSuggestions(pattern);
                          },
                          itemBuilder: (context, SearchModel suggestion) {
                            return ListTile(
                              title: Text(suggestion.name),
                            );
                          },
                          onSuggestionSelected: (SearchModel suggestion) {
                            //Navigator.push(context, MaterialPageRoute(builder: (context) => DestinationPage(searchData: suggestion)));
                            Fluttertoast.showToast(msg: 'click suggestion', toastLength: Toast.LENGTH_SHORT);
                          },
                        ),
                      ),

                    )),
                  ),
                  const SizedBox(width: 10),
                  FadeAnimation(1.5, Container(
                    height: 50,
                    width: 50,
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(10)
                    ),
                    child: IconButton(
                      onPressed: () {
                        showFilterModal();
                      },
                      icon: const Icon(Icons.filter_list, color: Colors.black, size: 30,),
                    ),
                  ))
                ],
              ),
            ),
          ),
          SliverList(
            delegate: SliverChildListDelegate([

              Container(
                  padding: const EdgeInsets.only(top: 20, left: 20),
                  height: 330,
                  child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: const [
                            Text('My Car Collection', style: TextStyle(color: Colors.black, fontSize: 18, fontWeight: FontWeight.bold),),
                            Padding(
                              padding: EdgeInsets.only(right: 20.0),
                              child: Text('See all ', style: TextStyle(color: Colors.black, fontSize: 14),),
                            ),
                          ],
                        ),
                        const SizedBox(height: 10,),
                        Expanded(
                            child: ListView.builder(
                                scrollDirection: Axis.vertical,
                                itemCount: myList.length,
                                itemBuilder: (context, index) {
                                  return automobileBuilder(myList[index]);
                                }
                            )
                        )
                      ]
                  )
              ),
            ]),
          ),
        ]
    ),
          // TODO: Display a banner when ready
          if (_bannerAd != null)
            Align(
              alignment: Alignment.topCenter,
              child: SizedBox(
                width: _bannerAd!.size.width.toDouble(),
                height: _bannerAd!.size.height.toDouble(),
                child: AdWidget(ad: _bannerAd!),
              ),
            ),
        ],
        ),
        ),

    floatingActionButton: FloatingActionButton(
        backgroundColor: PRIMARY_COLOR,
        onPressed: () {
          // TODO: Display an Interstitial Ad
          if (_interstitialAd != null) {
            _interstitialAd?.show();
          }else{
            showSaveModal();
          }
        },
    child: const Icon(Icons.add)
    )
    );
  }

  // Future<void> automobiles() async {
  //   final String response = await rootBundle.loadString('assets/automobiles.json');
  //   final data = await json.decode(response);
  //
  //   setState(() {
  //     automobileList = data['automobiles']
  //         .map((data) => Automobile.fromJson(data)).toList();
  //   });
  // }
  Future<void> myAutomobiles() async {
    final String response = await rootBundle.loadString('assets/automobiles.json');
    final decoded = await json.decode(response)['automobiles'];
    List data = decoded as List;

    final filteredData = data.where((element) => (element['brand'] != null ? element['brand'].contains('BMW') : true));
    //debugPrint('json response: $filteredData');


    setState(() {
      myList = filteredData
          .map((data) => Automobile.fromJson(data)).toList();
    });
  }


  automobileBuilder(Automobile automobile) {
    return Card(
        elevation: 5,
        child: ListTile(
            title: Text(automobile.name),
            subtitle: Text('${automobile.brand}-${automobile.model}'),
            trailing: OutlinedButton(
                onPressed: () {
                },
                child: const Icon(Icons.delete, color: Colors.red)
            )));
    // return AspectRatio(
    //   aspectRatio: 1 / 0.5,
    //   child: FadeAnimation(1.5, GestureDetector(
    //     onTap: () {
    //       //Navigator.push(context, MaterialPageRoute(builder: (context) => AutomobileViewPage(automobile: automobile,)));
    //       Fluttertoast.showToast(msg: 'click Automobile', toastLength: Toast.LENGTH_SHORT);
    //     },
    //     child: Container(
    //       margin: const EdgeInsets.only(right: 20, bottom: 25),
    //       child: Column(
    //         crossAxisAlignment: CrossAxisAlignment.start,
    //         children: [
    //           Text(automobile.name,
    //             style: const TextStyle(color: Colors.black, fontSize: 18,),
    //           ),
    //           const SizedBox(height: 10,),
    //           Row(
    //             mainAxisAlignment: MainAxisAlignment.spaceBetween,
    //             children: [
    //               Text(automobile.brand, style: TextStyle(color: Colors.orange.shade400, fontSize: 14,),),
    //
    //             ],
    //           ),
    //         ],
    //       ),
    //     ),
    //
    //   )),
    // );
  }


  showFilterModal() {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.white,
      shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.only(topLeft: Radius.circular(20), topRight: Radius.circular(20))
      ),
      builder: (context) {
        return StatefulBuilder(
            builder: (context, setState) {
              return Container(
                padding: const EdgeInsets.only(top: 20, left: 20, right: 20, bottom: 20),
                height: MediaQuery.of(context).size.height * 0.8,
                child: ListView(
                  //crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text('Filter', style: TextStyle(color: Colors.black, fontSize: 23, fontWeight: FontWeight.bold),),
                        MaterialButton(
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          minWidth: 40,
                          height: 40,
                          color: Colors.grey.shade300,
                          elevation: 0,
                          padding: EdgeInsets.all(0),
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(50)
                          ),
                          child: const Icon(Icons.close, color: Colors.black,),
                        )
                      ],
                    ),
                    const SizedBox(height: 20,),
                    // brand filter
                    const Text("Brand", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),),
                    const SizedBox(height: 10,),
                    Container(
                      margin: const EdgeInsets.symmetric(vertical: 8),
                      child: DropdownButtonFormField<String>(
                        decoration: const InputDecoration(
                          border: OutlineInputBorder(),
                        ),
                        hint: const Text("Select Brand"),
                        value: _valBrand,
                        items: _brandList.map((value) {
                          return DropdownMenuItem<String>(
                            value: value,
                            child: Text(value),
                          );
                        }).toList(),
                        onChanged: (String? value) {
                          setState(() {
                            _valBrand = value!;
                          });
                        },
                      ),
                    ),

                    const SizedBox(height: 10,),
                    // model filter
                    const Text('Model', style: TextStyle(color: Colors.black, fontSize: 18, fontWeight: FontWeight.bold),),
                    const SizedBox(height: 5,),
                    Container(
                      margin: const EdgeInsets.symmetric(vertical: 8),
                      child: DropdownButtonFormField<String>(
                        decoration: const InputDecoration(
                          border: OutlineInputBorder(),
                        ),
                        hint: const Text("Select Model"),
                        value: _valModel,
                        items: _modelList.map((value) {
                          return DropdownMenuItem<String>(
                            value: value,
                            child: Text(value),
                          );
                        }).toList(),
                        onChanged: (String? value) {
                          setState(() {
                            _valModel = value!;
                          });
                        },
                      ),
                    ),


                    const SizedBox(height: 15,),
                    button('Filter', () {})
                  ],
                ),
              );
            }
        );
      },
    );
  }

  showSaveModal() {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.white,
      shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.only(topLeft: Radius.circular(20), topRight: Radius.circular(20))
      ),
      builder: (context) {
        return StatefulBuilder(
            builder: (context, setState) {
              return Container(
                padding: const EdgeInsets.only(top: 20, left: 20, right: 20, bottom: 20),
                height: MediaQuery.of(context).size.height * 0.8,
                child: ListView(
                  //crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text('Add New Car', style: TextStyle(color: Colors.black, fontSize: 23, fontWeight: FontWeight.bold),),
                        MaterialButton(
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          minWidth: 40,
                          height: 40,
                          color: Colors.grey.shade300,
                          elevation: 0,
                          padding: EdgeInsets.all(0),
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(50)
                          ),
                          child: const Icon(Icons.close, color: Colors.black,),
                        )
                      ],
                    ),
                    const SizedBox(height: 20,),
                    // Enter Name
                    const Text("Enter Brand", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),),
                    const SizedBox(height: 10,),
                    Container(
                      margin: const EdgeInsets.symmetric(vertical: 8),
                      child: DropdownButtonFormField<String>(
                        decoration: const InputDecoration(
                          border: OutlineInputBorder(),
                        ),
                        hint: const Text("Select Brand"),
                        value: _valBrand,
                        items: _brandList.map((value) {
                          return DropdownMenuItem<String>(
                            value: value,
                            child: Text(value),
                          );
                        }).toList(),
                        onChanged: (String? value) {
                          setState(() {
                            _valBrand = value!;
                          });
                        },
                      ),
                    ),

                    const SizedBox(height: 10,),
                    // brand filter
                    const Text("Enter Brand", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),),
                    const SizedBox(height: 10,),
                    Container(
                      margin: const EdgeInsets.symmetric(vertical: 8),
                      child: DropdownButtonFormField<String>(
                        decoration: const InputDecoration(
                          border: OutlineInputBorder(),
                        ),
                        hint: const Text("Select Model"),
                        value: _valModel,
                        items: _modelList.map((value) {
                          return DropdownMenuItem<String>(
                            value: value,
                            child: Text(value),
                          );
                        }).toList(),
                        onChanged: (String? value) {
                          setState(() {
                            _valModel = value!;
                          });
                        },
                      ),
                    ),

                    const SizedBox(height: 10,),
                    // date filter
                    const Text('Select Date', style: TextStyle(color: Colors.black, fontSize: 18, fontWeight: FontWeight.bold),),
                    const SizedBox(height: 5,),
                    Container(
                      margin: const EdgeInsets.symmetric(vertical: 8),
                      child: TextField(
                        controller: _etDate,
                        readOnly: true,
                        onTap: () {
                          _selectDate(context);
                        },
                        maxLines: 1,
                        cursorColor: Colors.grey[600],
                        style: const TextStyle(color: CHARCOAL),
                        decoration: const InputDecoration(
                          isDense: true,
                          suffixIcon: Icon(Icons.date_range, color: PRIMARY_COLOR),
                          enabledBorder: UnderlineInputBorder(
                            borderSide: BorderSide(color: Color(0xFFCCCCCC)),
                          ),
                          focusedBorder: UnderlineInputBorder(
                              borderSide:
                              BorderSide(color: PRIMARY_COLOR, width: 2.0)),
                          labelText: 'Select Date',
                          labelStyle: TextStyle(fontSize: 22 ,color: BLACK_GREY),
                        ),
                      ),
                    ),

                    const SizedBox(height: 15,),
                    button('Save', () {})
                  ],
                ),
              );
            }
        );
      },
    );
  }


  button(String text, Function onPressed) {
    return MaterialButton(
      onPressed: () => onPressed(),
      height: 50,
      elevation: 0,
      splashColor: Colors.yellow[700],
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10)
      ),
      color: PRIMARY_COLOR,
      child: Center(
        child: Text(text, style: const TextStyle(color: Colors.white, fontSize: 18),),
      ),
    );
  }
  Future<Null> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: _selectedDate,
      firstDate: DateTime(1900),
      lastDate: DateTime(2025),
      builder: (BuildContext context, Widget? child) {
        return Theme(
          data: ThemeData.light().copyWith(
            primaryColor: PRIMARY_COLOR,
            colorScheme: const ColorScheme.light(primary: PRIMARY_COLOR, secondary: PRIMARY_COLOR),
            buttonTheme: const ButtonThemeData(textTheme: ButtonTextTheme.primary),
          ),
          child: child!,
        );
      },
    );
    if (picked != null && picked != _selectedDate) {
      setState(() {
        _selectedDate = picked;
        _etDate = TextEditingController(
            text: _selectedDate.toLocal().toString().split(' ')[0]);
      });
    }
  }
}




