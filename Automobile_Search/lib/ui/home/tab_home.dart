import 'dart:convert';
import 'package:carismatic/animation/fadeAnimation.dart';
import 'package:carismatic/model/automobile.dart';
import 'package:carismatic/ui/home/automobile_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';


import 'package:carismatic/model/search_model.dart';
import 'package:carismatic/ui/home/destination.dart';
import 'package:carismatic/ui/reusable/cache_image_network.dart';
import 'package:carismatic/ui/reusable/global_function.dart';
import 'package:carismatic/ui/reusable/global_widget.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';

class TabHomePage extends StatefulWidget {
  const TabHomePage({ Key? key }) : super(key: key);

  @override
  _TabHomePageState createState() => _TabHomePageState();
}

class _TabHomePageState extends State<TabHomePage> with TickerProviderStateMixin {

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
  List _brandList = [
    "BMW",
    "Mercedes-Benz",
  ];
  List _modelList = [
    "5 Series",
    "4 Series",
    "GLA 250",
    "CLA 250",
  ];

  TextEditingController _etSearch = TextEditingController();
  late ScrollController _scrollController;
  bool _isScrolled = false;

  List<dynamic> automobileList = [];
  List<dynamic> bmwList = [];
  List<dynamic> mercedesList = [];

  List _yearList = [
    "2013",
    "2014",
    "2015",
    "2016",
    "2017",
    "2018",
    "2019",
    "2020",
    "2021",
    "2022",
    "2023",
    "2024",
  ];


  int _selectedColor = 0;
  int _selectedSize = 1;

  var selectedRange = const RangeValues(150.00, 1500.00);

  @override
  void initState() {
    _scrollController = ScrollController();
    _scrollController.addListener(_listenToScrollChange);
    automobiles();
    bmwAutomobiles();
    mercedesAutomobiles();

    super.initState();
  }

  @override
  void dispose() {
    _etSearch.dispose();

    super.dispose();
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

  // // This function is called whenever the text field changes
  // void _runNamesearch(String enteredValue) {
  // List<dynamic> results = [];
  //   if (enteredValue.isEmpty) {
  //     // if the search field is empty or only contains white-space, we'll display all users
  //     var results = automobileList;
  //   } else {
  //     var results = automobileList
  //         .where((automobiles) =>
  //         automobiles["name"].toLowerCase().contains(enteredValue.toLowerCase()))
  //         .toList();
  //     // we use the toLowerCase() method to make it case-insensitive
  //   }
  // // Refresh the UI
  // setState(() {
  //   automobileList = results;
  // });
  // }
  //
  // // This function is called whenever the text field changes
  // void _runBrandsearch(String enteredValue) {
  //   List<dynamic> results = [];
  //   if (enteredValue.isEmpty) {
  //     // if the search field is empty or only contains white-space, we'll display all users
  //     var results = automobileList;
  //   } else {
  //     var results = automobileList
  //         .where((automobiles) =>
  //         automobiles["brand"].toLowerCase().contains(enteredValue.toLowerCase()))
  //         .toList();
  //     // we use the toLowerCase() method to make it case-insensitive
  //   }
  //   // Refresh the UI
  //   setState(() {
  //     automobileList = results;
  //   });
  // }
  //
  //
  // // This function is called whenever the text field changes
  // void _runModelsearch(String enteredValue) {
  //   List<dynamic> results = [];
  //   if (enteredValue.isEmpty) {
  //     // if the search field is empty or only contains white-space, we'll display all users
  //     var results = automobileList;
  //   } else {
  //     var results = automobileList
  //         .where((automobiles) =>
  //         automobiles["model"].toLowerCase().contains(enteredValue.toLowerCase()))
  //         .toList();
  //     // we use the toLowerCase() method to make it case-insensitive
  //   }
  //   // Refresh the UI
  //   setState(() {
  //     automobileList = results;
  //   });
  // }


  @override
  Widget build(BuildContext context) {
    final double boxImageSize = (MediaQuery.of(context).size.width / 6);
    return CustomScrollView(
        controller: _scrollController,
        slivers: [
          SliverAppBar(
            expandedHeight: 300.0,
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
                  child: FadeAnimation(1, const Text("Find your 2022 Automobiles",
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 28.0,
                      ))),
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
                              hintStyle:TextStyle(fontSize: 20.0, color: Colors.green, )
                            ),

                          ),
                          suggestionsCallback: (pattern) {
                            return _getSuggestions(pattern);
                          },
                          itemBuilder: (context, SearchModel suggestion) {
                            return ListTile(
                              leading: ClipRRect(
                                  borderRadius:
                                  BorderRadius.all(const Radius.circular(4)),
                                  child: buildCacheNetworkImage(width: boxImageSize, height: boxImageSize, url: suggestion.imageURL)),
                              title: Text(suggestion.name),
                              subtitle: Text('\$ '+_globalFunction.removeDecimalZeroFormat(suggestion.price)),
                            );
                          },
                          onSuggestionSelected: (SearchModel suggestion) {
                            Navigator.push(context, MaterialPageRoute(builder: (context) => DestinationPage(searchData: suggestion)));
                          },
                        ),
                      ),
                      // child: TextField(
                      //   // readOnly: true,
                      //   // cursorColor: Colors.grey,
                      //   controller: _etSearch,
                      //   autofocus: true,
                      //   textInputAction: TextInputAction.search,
                      //   onChanged: (textValue) {
                      //     setState(() {});
                      //   },
                      //   maxLines: 1,
                      //   style: TextStyle(fontSize: 13, color: Colors.grey[600]),
                      //
                      //   decoration: InputDecoration(
                      //     contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                      //     filled: true,
                      //     fillColor: Colors.white,
                      //     prefixIcon: const Icon(Icons.search, color: Colors.black),
                      //     border: OutlineInputBorder(
                      //         borderRadius: BorderRadius.circular(10),
                      //         borderSide: BorderSide.none
                      //     ),
                      //     hintText: "Search automobile",
                      //     hintStyle: const TextStyle(fontSize: 14, color: Colors.black),
                      //   ),
                      // ),
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
                        FadeAnimation(1.4, Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: const [
                            Text('Popular Automobiles', style: TextStyle(color: Colors.black, fontSize: 18, fontWeight: FontWeight.bold),),
                            Padding(
                              padding: EdgeInsets.only(right: 20.0),
                              child: Text('See all ', style: TextStyle(color: Colors.black, fontSize: 14),),
                            ),
                          ],
                        )),
                        const SizedBox(height: 10,),
                        Expanded(
                            child: ListView.builder(
                                scrollDirection: Axis.horizontal,
                                itemCount: automobileList.length,
                                itemBuilder: (context, index) {
                                  return automobileCart(automobileList[index]);
                                }
                            )
                        )
                      ]
                  )
              ),
              Container(
                  padding: const EdgeInsets.only(top: 20, left: 20),
                  height: 180,
                  child: Column(
                      children: [
                        FadeAnimation(1.4, Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: const [
                            Text('For You', style: TextStyle(color: Colors.black, fontSize: 18, fontWeight: FontWeight.bold),),
                            Padding(
                              padding: EdgeInsets.only(right: 20.0),
                              child: Text('See all ', style: TextStyle(color: Colors.black, fontSize: 14),),
                            ),
                          ],
                        )),
                        const SizedBox(height: 10,),
                        Expanded(
                            child: ListView.builder(
                                scrollDirection: Axis.horizontal,
                                itemCount: automobileList.length,
                                itemBuilder: (context, index) {
                                  return forYou(automobileList[index]);
                                }
                            )
                        )
                      ]
                  )
              ),
              Container(
                  padding: const EdgeInsets.only(top: 20, left: 20),
                  height: 330,
                  child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: const [
                            Text('BMW Collection', style: TextStyle(color: Colors.black, fontSize: 18, fontWeight: FontWeight.bold),),
                            Padding(
                              padding: EdgeInsets.only(right: 20.0),
                              child: Text('See all ', style: TextStyle(color: Colors.black, fontSize: 14),),
                            ),
                          ],
                        ),
                        const SizedBox(height: 10,),
                        Expanded(
                            child: ListView.builder(
                                scrollDirection: Axis.horizontal,
                                itemCount: bmwList.length,
                                itemBuilder: (context, index) {
                                  return automobileCart(bmwList[index]);
                                }
                            )
                        )
                      ]
                  )
              ),
              Container(
                  padding: const EdgeInsets.only(top: 20, left: 20),
                  height: 330,
                  child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: const [
                            Text('Mercedes Collection', style: TextStyle(color: Colors.black, fontSize: 18, fontWeight: FontWeight.bold),),
                            Padding(
                              padding: EdgeInsets.only(right: 20.0),
                              child: Text('See all ', style: TextStyle(color: Colors.black, fontSize: 14),),
                            ),
                          ],
                        ),
                        const SizedBox(height: 10,),
                        Expanded(
                            child: ListView.builder(
                                reverse: true,
                                scrollDirection: Axis.horizontal,
                                itemCount: mercedesList.length,
                                itemBuilder: (context, index) {
                                  return automobileCart(mercedesList[index]);
                                }
                            )
                        )
                      ]
                  )
              ),
            ]),
          )
        ]
    );
  }

  Future<void> automobiles() async {
    final String response = await rootBundle.loadString('assets/automobiles.json');
    final data = await json.decode(response);

    setState(() {
      automobileList = data['automobiles']
          .map((data) => Automobile.fromJson(data)).toList();
    });
  }
  Future<void> bmwAutomobiles() async {
    final String response = await rootBundle.loadString('assets/automobiles.json');
    final decoded = await json.decode(response)['automobiles'];
    List data = decoded as List;

    final filteredData = data.where((element) => (element['brand'] != null ? element['brand'].contains('BMW') : true));
    //debugPrint('json response: $filteredData');


    setState(() {
      bmwList = filteredData
          .map((data) => Automobile.fromJson(data)).toList();
    });
  }
  Future<void> mercedesAutomobiles() async {
    final String response = await rootBundle.loadString('assets/automobiles.json');
    final decoded = await json.decode(response)['automobiles'];
    List data = decoded as List;
    final filteredData = data.where((element) => (element['brand'] != null ? element['brand'].contains('Mercedes-Benz') : true));


    setState(() {
      mercedesList = filteredData
          .map((data) => Automobile.fromJson(data)).toList();
    });
  }

  automobileCart(Automobile automobile) {
    return AspectRatio(
      aspectRatio: 1 / 1,
      child: FadeAnimation(1.5, GestureDetector(
        onTap: () {
          Navigator.push(context, MaterialPageRoute(builder: (context) => AutomobileViewPage(automobile: automobile,)));
        },
        child: Container(
          margin: const EdgeInsets.only(right: 20, bottom: 25),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            color: Colors.white,
            boxShadow: [BoxShadow(
              offset: const Offset(5, 10),
              blurRadius: 15,
              color: Colors.grey.shade200,
            )],
          ),
          padding: const EdgeInsets.all(10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: 150,
                child: Stack(
                  children: [
                    SizedBox(
                      width: double.infinity,
                      child: ClipRRect(
                          borderRadius: BorderRadius.circular(15),
                          child: Image.network(automobile.imageURL, fit: BoxFit.cover)
                      ),
                    ),
                    // Add to cart button
                    Positioned(
                      right: 5,
                      bottom: 5,
                      child: MaterialButton(
                        color: Colors.black,
                        minWidth: 45,
                        height: 45,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(50)
                        ),
                        onPressed: () {
                          //addToCartModal();
                          Fluttertoast.showToast(msg: 'add to cart pressed', toastLength: Toast.LENGTH_SHORT);
                        },
                        padding: const EdgeInsets.all(5),
                        child: const Center(child: Icon(Icons.shopping_cart, color: Colors.white, size: 20,)),
                      ),
                    )
                  ],
                ),
              ),
              const SizedBox(height: 20,),
              Text(automobile.name,
                style: const TextStyle(color: Colors.black, fontSize: 18,),
              ),
              const SizedBox(height: 10,),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(automobile.brand, style: TextStyle(color: Colors.orange.shade400, fontSize: 14,),),
                  Text("\$ " +automobile.price.toString() + '.00',
                    style: const TextStyle(color: Colors.black, fontSize: 18, fontWeight: FontWeight.w800),
                  ),
                ],
              ),
            ],
          ),
        ),
      )),
    );
  }

  forYou(Automobile automobile) {
    return AspectRatio(
      aspectRatio: 3 / 1,
      child: FadeAnimation(1.5, Container(
        margin: const EdgeInsets.only(right: 20, bottom: 25),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          color: Colors.white,
          boxShadow: [BoxShadow(
            offset: const Offset(5, 10),
            blurRadius: 15,
            color: Colors.grey.shade200,
          )],
        ),
        padding: const EdgeInsets.all(10),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              width: 100,
              child: ClipRRect(
                  borderRadius: BorderRadius.circular(15),
                  child: Image.network(automobile.imageURL, fit: BoxFit.cover)),
            ),
            const SizedBox(width: 10,),
            Expanded(
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(automobile.name,
                      style: const TextStyle(color: Colors.black, fontSize: 18,),
                    ),
                    const SizedBox(height: 5,),
                    Text(automobile.brand, style: TextStyle(color: Colors.orange.shade400, fontSize: 13,),),
                    const SizedBox(height: 10,),
                    Text("\$ " +automobile.price.toString() + '.00',
                      style: const TextStyle(color: Colors.black, fontSize: 18, fontWeight: FontWeight.w800),
                    ),
                  ]
              ),
            )
          ],
        ),
      )),
    );
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
                    const SizedBox(height: 10,),
                    // date filter
                    const Text('Year', style: TextStyle(color: Colors.black, fontSize: 18, fontWeight: FontWeight.bold),),
                    const SizedBox(height: 5,),
                    Container(
                      margin: const EdgeInsets.symmetric(vertical: 8),
                      child: DropdownButtonFormField<String>(
                        decoration: const InputDecoration(
                          border: OutlineInputBorder(),
                        ),
                        hint: const Text("Select Year"),
                        value: _valYear,
                        items: _yearList.map((value) {
                          return DropdownMenuItem<String>(
                            value: value,
                            child: Text(value),
                          );
                        }).toList(),
                        onChanged: (String? value) {
                          setState(() {
                            _valYear = value!;
                          });
                        },
                      ),
                    ),
                    // Slider Price Renge filter
                    const SizedBox(height: 10,),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text('Price Range', style: TextStyle(color: Colors.black, fontSize: 18, fontWeight: FontWeight.bold),),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Text('\$ ${selectedRange.start.toStringAsFixed(2)}', style: TextStyle(color: Colors.grey.shade500, fontSize: 12),),
                            Text(" - ", style: TextStyle(color: Colors.grey.shade500)),
                            Text('\$ ${selectedRange.end.toStringAsFixed(2)}', style: TextStyle(color: Colors.grey.shade500, fontSize: 12),),
                          ],
                        ),
                      ],
                    ),
                    const SizedBox(height: 5,),
                    RangeSlider(
                        values: selectedRange,
                        min: 0.00,
                        max: 2000.00,
                        divisions: 100,
                        inactiveColor: Colors.grey.shade300,
                        activeColor: Colors.yellow[800],
                        labels: RangeLabels('\$ ${selectedRange.start.toStringAsFixed(2)}', '\$ ${selectedRange.end.toStringAsFixed(2)}',),
                        onChanged: (RangeValues values) {
                          setState(() => selectedRange = values);
                        }
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


  button(String text, Function onPressed) {
    return MaterialButton(
      onPressed: () => onPressed(),
      height: 50,
      elevation: 0,
      splashColor: Colors.yellow[700],
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10)
      ),
      color: Colors.yellow[800],
      child: Center(
        child: Text(text, style: const TextStyle(color: Colors.white, fontSize: 18),),
      ),
    );
  }
}




// /*
// For this homepage, appBar is created at the bottom after CustomScrollView
// we used AutomaticKeepAliveClientMixin to keep the state when moving from 1 navbar to another navbar, so the page is not refresh overtime
//  */
//
// import 'dart:async';
//
//
// import 'search.dart';
// import '../reusable_widget.dart';
// import '../reusable/global_function.dart';
// import '../reusable/global_widget.dart';
// import '../reusable/shimmer_loading.dart';
// import '../reusable/cache_image_network.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';
// import 'package:fluttertoast/fluttertoast.dart';
// import '../../constants/constant.dart';
// import '../../constants/global_style.dart';
// import '../../model/automobile_model.dart';
//
//
// class TabHomePage extends StatefulWidget {
//   const TabHomePage({Key? key}) : super(key: key);
//
//   @override
//   _TabHomePageState createState() => _TabHomePageState();
// }
//
// class _TabHomePageState extends State<TabHomePage> with TickerProviderStateMixin, AutomaticKeepAliveClientMixin {
//   // initialize global function and reusable widget
//   final _globalFunction = GlobalFunction();
//   final _reusableWidget = ReusableWidget();
//   final _globalWidget = GlobalWidget();
//
//   final _shimmerLoading = ShimmerLoading();
//
//   bool _loading = true;
//   Timer? _timerDummy;
//
//   final Color _color1 = const Color(0xFF515151);
//   final Color _color2 = const Color(0xff777777);
//   List<AutomobileModel> _automobileData = [];
//
//
//   late ScrollController _scrollController;
//   Color _topIconColor = Colors.white;
//   Color _topSearchColor = Colors.white;
//   late AnimationController _topColorAnimationController;
//   late Animation _appBarColor;
//   SystemUiOverlayStyle _appBarSystemOverlayStyle = SystemUiOverlayStyle.light;
//
//
//
//
//
//   // keep the state to do not refresh when switch navbar
//   @override
//   bool get wantKeepAlive => true;
//
//   @override
//   void initState() {
//     _getData();
//     // _setupAnimateAppbar();
//
//
//
//     super.initState();
//   }
//
//   @override
//   void dispose() {
//     // _scrollController.dispose();
//     // _topColorAnimationController.dispose();
//     _timerDummy?.cancel();
//
//     super.dispose();
//   }
//
//   void _getData(){
//     // this timer function is just for demo, so after 2 second, the shimmer loading will disappear and show the content
//     _timerDummy = Timer(const Duration(seconds: 2), () {
//       setState(() {
//         _loading = false;
//       });
//     });
//
//     _automobileData = [
//       AutomobileModel(
//           id: 21,
//           name: "Delta Boots Import 8 Inch",
//           price: 18.3,
//           image: "$GLOBAL_URL/assets/images/product/25.jpg",
//           rating: 5,
//           review: 212,
//           sale: 735,
//           location: "Brooklyn"
//       ),
//       AutomobileModel(
//           id: 20,
//           name: "Fimi X8 SE Black",
//           price: 567,
//           image: "$GLOBAL_URL/assets/images/product/26.jpg",
//           rating: 5,
//           review: 63,
//           sale: 115,
//           location: "Brooklyn"
//       ),
//       AutomobileModel(
//           id: 19,
//           name: "Guess Collection Watch Ceramic Type GC 6004 ",
//           price: 52,
//           image: "$GLOBAL_URL/assets/images/product/27.jpg",
//           rating: 5,
//           review: 7,
//           sale: 7,
//           location: "Brooklyn"
//       ),
//       AutomobileModel(
//           id: 17,
//           name: "NEW Original Apple TV 4K 64GB 5th Generation",
//           price: 261,
//           image: "$GLOBAL_URL/assets/images/product/29.jpg",
//           rating: 5,
//           review: 98,
//           sale: 263,
//           location: "Brooklyn"
//       ),
//       AutomobileModel(
//           id: 16,
//           name: "SAMSUNG GALAXY S20 PLUS RAM 8/128GB",
//           price: 751,
//           image: "$GLOBAL_URL/assets/images/product/30.jpg",
//           rating: 5,
//           review: 14,
//           sale: 17,
//           location: "Brooklyn"
//       ),
//       AutomobileModel(
//           id: 15,
//           name: "Xiaomi Smart LED TV Mi 4",
//           price: 224.14,
//           image: "$GLOBAL_URL/assets/images/product/31.jpg",
//           rating: 5,
//           review: 701,
//           sale: 1558,
//           location: "Brooklyn"
//       ),
//       AutomobileModel(
//           id: 14,
//           name: "Adidas EQT Adv Premium Original",
//           price: 28.67,
//           image: "$GLOBAL_URL/assets/images/product/32.jpg",
//           rating: 5,
//           review: 146,
//           sale: 398,
//           location: "Brooklyn"
//       ),
//       AutomobileModel(
//           id: 13,
//           name: "Xiaomi Air Purifier 3 Mijia OLED Touch Sterilization Air Ionizer - 3",
//           price: 139,
//           image: "$GLOBAL_URL/assets/images/product/33.jpg",
//           rating: 5,
//           review: 275,
//           sale: 1055,
//           location: "Brooklyn"
//       ),
//       AutomobileModel(
//           id: 12,
//           name: "Spatula Set Stainless Kitchen Tools",
//           price: 2.5,
//           image: "$GLOBAL_URL/assets/images/product/34.jpg",
//           rating: 5,
//           review: 302,
//           sale: 752,
//           location: "Brooklyn"
//       ),
//       AutomobileModel(
//           id: 11,
//           name: "DATA CABLE TYPE-C TO TYPE-C BASEUS HALO DATA CABLE PD 2.0 60W - 0.5 M",
//           price: 3,
//           image: "$GLOBAL_URL/assets/images/product/35.jpg",
//           rating: 5,
//           review: 636,
//           sale: 2087,
//           location: "Brooklyn"
//       ),
//       AutomobileModel(
//           id: 10,
//           name: "BASEUS QUICK CHARGER HEAD QC3.0/4.0 TYPE-C+USB 30W PD 5A - USB TC",
//           price: 10.6,
//           image: "$GLOBAL_URL/assets/images/product/36.jpg",
//           rating: 5,
//           review: 2802,
//           sale: 7052,
//           location: "Brooklyn"
//       ),
//       AutomobileModel(
//           id: 9,
//           name: "Xiaomi Powerbank MI2C 20000mAh Mi Power Bank 20000 mAh PLM06ZM",
//           price: 19.9,
//           image: "$GLOBAL_URL/assets/images/product/37.jpg",
//           rating: 5,
//           review: 105,
//           sale: 227,
//           location: "Brooklyn"
//       ),
//       AutomobileModel(
//           id: 8,
//           name: "3D FASHION MASK WITH BREATHING VALVE / MASKER PM 2.5 KARBON / WASHABLE - BLACK NEW MODEL",
//           price: 2.33,
//           image: "$GLOBAL_URL/assets/images/product/38.jpg",
//           rating: 5,
//           review: 503,
//           sale: 3645,
//           location: "Brooklyn"
//       ),
//       AutomobileModel(
//           id: 7,
//           name: "Robot RT-US04 Table Phone Holder Stand Aluminium Alloy Universal - Pink",
//           price: 5.3,
//           image: "$GLOBAL_URL/assets/images/product/39.jpg",
//           rating: 5,
//           review: 1095,
//           sale: 3400,
//           location: "Brooklyn"
//       ),
//       AutomobileModel(
//           id: 6,
//           name: "Tactical Pants Blackhawk Helikon ",
//           price: 10,
//           image: "$GLOBAL_URL/assets/images/product/40.jpg",
//           rating: 5,
//           review: 63,
//           sale: 131,
//           location: "Brooklyn"
//       ),
//       AutomobileModel(
//           id: 5,
//           name: "Sony SRS- XB12 / XB 12 Extra Bass Portable Bluetooth Speaker - Black",
//           price: 48,
//           image: "$GLOBAL_URL/assets/images/product/41.jpg",
//           rating: 5,
//           review: 182,
//           sale: 427,
//           location: "Brooklyn"
//       ),
//       AutomobileModel(
//           id: 4,
//           name: "Original 100% 60W Magsafe 1 Power Adapter Charger Macbook Pro - Air",
//           price: 22.66,
//           image: "$GLOBAL_URL/assets/images/product/42.jpg",
//           rating: 5,
//           review: 131,
//           sale: 466,
//           location: "Brooklyn"
//       ),
//       AutomobileModel(
//           id: 3,
//           name: "Macbook Pro 2019 TouchBar MV912 15\" 16GB 512GB 2.3GHz 8-core i9 Gray",
//           price: 2212,
//           image: "$GLOBAL_URL/assets/images/product/43.jpg",
//           rating: 5,
//           review: 16,
//           sale: 37,
//           location: "Brooklyn"
//       ),
//       AutomobileModel(
//           id: 2,
//           name: "New imac 2017 MNEA2 5K retina /3,5GHZ/i5/8GB/1TB/RP575",
//           price: 1643,
//           image: "$GLOBAL_URL/assets/images/product/44.jpg",
//           rating: 5,
//           review: 2,
//           sale: 3,
//           location: "Brooklyn"
//       ),
//       AutomobileModel(
//           id: 1,
//           name: "Adidas Football Predator 19.3 FG F35594 Original",
//           price: 9,
//           image: "$GLOBAL_URL/assets/images/product/45.jpg",
//           rating: 5,
//           review: 30,
//           sale: 70,
//           location: "Brooklyn"
//       ),
//     ];
//   }
//
//   // void _setupAnimateAppbar() {
//   //   // use this function and paramater to animate top bar
//   //   _topColorAnimationController =
//   //       AnimationController(vsync: this, duration: const Duration(seconds: 0));
//   //   _appBarColor =
//   //       ColorTween(begin: Colors.transparent, end: Colors.white).animate(
//   //           _topColorAnimationController);
//   //   _scrollController = ScrollController()
//   //     ..addListener(() {
//   //       _topColorAnimationController.animateTo(_scrollController.offset / 120);
//   //       // if scroll for above 150, then change app bar color to white, search button to dark, and top icon color to dark
//   //       // if scroll for below 150, then change app bar color to transparent, search button to white and top icon color to light
//   //       if (_scrollController.hasClients &&
//   //           _scrollController.offset > (150 - kToolbarHeight)) {
//   //         if (_topIconColor != BLACK_GREY) {
//   //           _topIconColor = BLACK_GREY;
//   //           _topSearchColor = Colors.grey[100]!;
//   //           _appBarSystemOverlayStyle = SystemUiOverlayStyle.dark;
//   //         }
//   //       } else {
//   //         if (_topIconColor != Colors.white) {
//   //           _topIconColor = Colors.white;
//   //           _topSearchColor = Colors.white;
//   //           _appBarSystemOverlayStyle = SystemUiOverlayStyle.light;
//   //         }
//   //       }
//   //     });
//   // }
//
//   @override
//   Widget build(BuildContext context) {
//     // if we used AutomaticKeepAliveClientMixin, we must call super.build(context);
//     super.build(context);
//
//     final double boxImageSize = (MediaQuery
//         .of(context)
//         .size
//         .width / 3);
//     final double categoryForYouHeightShort = boxImageSize;
//     final double categoryForYouHeightLong = (boxImageSize * 2);
//
//     return  Scaffold(
//         appBar: AppBar(
//           iconTheme: const IconThemeData(
//             color: Colors.black, //change your color here
//           ),
//           systemOverlayStyle: SystemUiOverlayStyle.dark,
//           elevation: 0,
//           title: const Text(
//             'Automobile List',
//             style: TextStyle(
//                 fontSize: 18,
//                 color: Colors.black
//             ),
//           ),
//           backgroundColor: Colors.white,
//           bottom: PreferredSize(
//               preferredSize: const Size.fromHeight(1.0),
//               child: Container(
//                 color: Colors.grey[100],
//                 height: 1.0,
//               )),
//           actions: [
//             IconButton(
//                 icon: Icon(Icons.search, color: _color2),
//                 onPressed: () {
//                   // Fluttertoast.showToast(msg: 'Click search', toastLength: Toast.LENGTH_SHORT);
//                   Navigator.push(context, MaterialPageRoute(builder: (
//                       context) => SearchPage()));
//                 }),
//           ],
//         ),
//         body: RefreshIndicator(
//           onRefresh: refreshData,
//           child: (_loading == true)
//               ? _shimmerLoading.buildShimmerProduct(((MediaQuery.of(context).size.width) - 24) / 2 - 12)
//               : CustomScrollView(
//               slivers: <Widget>[
//                 SliverPadding(
//                   padding: const EdgeInsets.fromLTRB(12, 8, 12, 8),
//                   sliver: SliverGrid(
//                     gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
//                       crossAxisCount: 2,
//                       mainAxisSpacing: 8,
//                       crossAxisSpacing: 8,
//                       childAspectRatio: 0.625,
//                     ),
//                     delegate: SliverChildBuilderDelegate(
//                           (BuildContext context, int index) {
//                         return _buildItem(index);
//                       },
//                       childCount: _automobileData.length,
//                     ),
//                   ),
//                 ),
//               ]
//           ),
//         )
//       // body: Stack(
//       //   children: [
//       //
//       //     // Create AppBar with Animation
//       //     SizedBox(
//       //       height: 80,
//       //       child: AnimatedBuilder(
//       //         animation: _topColorAnimationController,
//       //         builder: (context, child) =>
//       //             AppBar(
//       //               automaticallyImplyLeading: false,
//       //               backgroundColor: _appBarColor.value,
//       //               systemOverlayStyle: _appBarSystemOverlayStyle,
//       //               elevation: GlobalStyle.appBarElevation,
//       //               title: TextButton(
//       //                   style: ButtonStyle(
//       //                     backgroundColor: MaterialStateProperty.resolveWith<
//       //                         Color>(
//       //                           (Set<
//       //                           MaterialState> states) => _topSearchColor,
//       //                     ),
//       //                     overlayColor: MaterialStateProperty.all(
//       //                         Colors.transparent),
//       //                     shape: MaterialStateProperty.all(
//       //                         RoundedRectangleBorder(
//       //                           borderRadius: BorderRadius.circular(5.0),
//       //                         )
//       //                     ),
//       //                   ),
//       //                   onPressed: () {
//       //                     Navigator.push(context, MaterialPageRoute(builder: (
//       //                         context) => SearchPage()));
//       //                   },
//       //                   child: Row(
//       //                     children: [
//       //                       const SizedBox(width: 8),
//       //                       Icon(Icons.search, color: Colors.grey[500],
//       //                         size: 18,),
//       //                       const SizedBox(width: 8),
//       //                       Text(
//       //                         'Search Automobile',
//       //                         style: TextStyle(
//       //                             color: Colors.grey[500],
//       //                             fontWeight: FontWeight.normal),
//       //                       )
//       //                     ],
//       //                   )
//       //               ),
//       //             ),
//       //
//       //       ),
//       //     )
//       //   ],
//       // ),
//     );
//   }
//   Widget _buildItem(index) {
//     final double boxImageSize = ((MediaQuery.of(context).size.width) - 24) / 2 - 12;
//     return Card(
//       shape: RoundedRectangleBorder(
//         borderRadius: BorderRadius.circular(10),
//       ),
//       elevation: 2,
//       color: Colors.white,
//       child: GestureDetector(
//         behavior: HitTestBehavior.translucent,
//         onTap: () {
//           Fluttertoast.showToast(msg: 'Click ${_automobileData[index].name}', toastLength: Toast.LENGTH_SHORT);
//         },
//         child: Column(
//           children: <Widget>[
//             ClipRRect(
//                 borderRadius: const BorderRadius.only(
//                     topLeft: Radius.circular(10),
//                     topRight: Radius.circular(10)),
//                 child: buildCacheNetworkImage(width: boxImageSize, height: boxImageSize, url: _automobileData[index].image)),
//             Container(
//               margin: const EdgeInsets.fromLTRB(8, 8, 8, 8),
//               child: Column(
//                 mainAxisAlignment: MainAxisAlignment.start,
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   Text(
//                     _automobileData[index].name,
//                     style: TextStyle(
//                         fontSize: 12,
//                         color: _color1
//                     ),
//                     maxLines: 2,
//                     overflow: TextOverflow.ellipsis,
//                   ),
//                   Container(
//                     margin: const EdgeInsets.only(top: 5),
//                     child: Row(
//                       mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                       children: [
//                         Text('\$ ${_globalFunction.removeDecimalZeroFormat(_automobileData[index].price!)}', style: const TextStyle(
//                             fontSize: 13,
//                             fontWeight: FontWeight.bold
//                         )),
//                         Text('${_automobileData[index].sale} Sale', style: const TextStyle(
//                             fontSize: 11,
//                             color: SOFT_GREY
//                         ))
//                       ],
//                     ),
//                   ),
//                   Container(
//                     margin: const EdgeInsets.only(top: 5),
//                     child: Row(
//                       children: [
//                         const Icon(Icons.location_on, color: SOFT_GREY, size: 12),
//                         Text(' ${_automobileData[index].location!}',
//                             style: const TextStyle(
//                                 fontSize: 11,
//                                 color: SOFT_GREY
//                             ))
//                       ],
//                     ),
//                   ),
//                   Container(
//                     margin: const EdgeInsets.only(top: 5),
//                     child: Row(
//                       children: [
//                         _globalWidget.createRatingBar(rating: _automobileData[index].rating!, size: 12),
//                         Text('(${_automobileData[index].review})', style: const TextStyle(
//                             fontSize: 11,
//                             color: SOFT_GREY
//                         )
//                         )
//                       ],
//                     ),
//                   )
//                 ],
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
//
//   Future refreshData() async {
//     setState(() {
//       _automobileData.clear();
//       _loading = true;
//       _getData();
//     });
//   }
//
// }
