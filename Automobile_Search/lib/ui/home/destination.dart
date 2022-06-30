import 'package:carismatic/model/search_model.dart';
import 'package:flutter/material.dart';

class DestinationPage extends StatefulWidget {
  final SearchModel searchData;
  const DestinationPage({ Key? key, required this.searchData }) : super(key: key);

  @override
  _DestinationPageState createState() => _DestinationPageState();
}

class _DestinationPageState extends State<DestinationPage> {
  List<dynamic> searchDataList = [];


  int _selectedColor = 0;
  int _selectedSize = 1;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: CustomScrollView(
          slivers: [
            SliverAppBar(
              expandedHeight: MediaQuery.of(context).size.height * 0.6,
              elevation: 0,
              snap: true,
              floating: true,
              stretch: true,
              backgroundColor: Colors.grey.shade50,
              flexibleSpace: FlexibleSpaceBar(
                  stretchModes: const [
                    StretchMode.zoomBackground,
                  ],
                  background: Image.network(widget.searchData.imageURL, fit: BoxFit.cover,)
              ),
              bottom: PreferredSize(
                  preferredSize: const Size.fromHeight(45),
                  child: Transform.translate(
                    offset: const Offset(0, 1),
                    child: Container(
                      height: 45,
                      decoration: const BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(30),
                          topRight: Radius.circular(30),
                        ),
                      ),
                      child: Center(
                          child: Container(
                            width: 50,
                            height: 8,
                            decoration: BoxDecoration(
                              color: Colors.grey.shade300,
                              borderRadius: BorderRadius.circular(10),
                            ),
                          )
                      ),
                    ),
                  )
              ),
            ),
            SliverList(
                delegate: SliverChildListDelegate([
                  Container(
                      height: MediaQuery.of(context).size.height * 0.55,
                      color: Colors.white,
                      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(widget.searchData.name,
                                    style: const TextStyle(color: Colors.black, fontSize: 22, fontWeight: FontWeight.bold,),
                                  ),
                                  const SizedBox(height: 5,),
                                  Text(widget.searchData.brand, style: TextStyle(color: Colors.orange.shade400, fontSize: 14,),),
                                ],
                              ),
                              Text("\$ " +widget.searchData.price.toString() + '.00',
                                style: const TextStyle(color: Colors.black, fontSize: 16),
                              ),
                            ],
                          ),
                          const SizedBox(height: 20,),
                          Text("Lorem ipsum dolor sit amet, incididunt ut elit esse cillum dolore eu fugiat nulla pariatur. unt in culpa qui officia deserunt mollit anim id est laborum.",
                            style: TextStyle(height: 1.5, color: Colors.grey.shade800, fontSize: 15,),
                          ),
                          const SizedBox(height: 30,),
                          MaterialButton(
                            onPressed: () {
                              Navigator.pop(context);
                            },
                            height: 50,
                            elevation: 0,
                            splashColor: Colors.yellow[700],
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10)
                            ),
                            color: Colors.yellow[800],
                            child: const Center(
                              child: Text("Add to Cart", style: TextStyle(color: Colors.white, fontSize: 18),),
                            ),
                          )
                        ],
                      )
                  )
                ])
            ),
          ]
      ),
    );
  }
}



// import 'package:carismatic/model/search_model.dart';
// import 'package:carismatic/ui/reusable/cache_image_network.dart';
// import 'package:carismatic/ui/reusable/global_function.dart';
// import 'package:carismatic/ui/reusable/global_widget.dart';
// import 'package:flutter/material.dart';
//
// class DestinationPage extends StatefulWidget {
//   final SearchModel searchData;
//
//   const DestinationPage({Key? key, required this.searchData}) : super(key: key);
//
//   @override
//   _DestinationPageState createState() => _DestinationPageState();
// }
//
// class _DestinationPageState extends State<DestinationPage> {
//   // initialize global widget
//   final _globalWidget = GlobalWidget();
//   final _globalFunction = GlobalFunction();
//
//   Color _color1 = Color(0xFF515151);
//   Color _color2 = Color(0xFFaaaaaa);
//
//   @override
//   void initState() {
//     super.initState();
//   }
//
//   @override
//   void dispose() {
//     super.dispose();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//         backgroundColor: Colors.white,
//         appBar: _globalWidget.globalAppBar(),
//         body: SingleChildScrollView(
//           padding: EdgeInsets.fromLTRB(24, 24, 24, 16),
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               _globalWidget.createDetailWidget(
//                   title: 'Destination Page',
//                   desc: 'This is the destination page from auto complete page'
//               ),
//               _buildSearchModel(),
//             ],
//           ),
//         )
//     );
//   }
//
//   Widget _buildSearchModel(){
//     final double boxImageSize = (MediaQuery.of(context).size.width / 4);
//     return Container(
//       margin: EdgeInsets.fromLTRB(12, 6, 12, 6),
//       child: Container(
//         margin: EdgeInsets.all(8),
//         child: Row(
//           mainAxisAlignment: MainAxisAlignment.start,
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: <Widget>[
//             ClipRRect(
//                 borderRadius:
//                 BorderRadius.all(Radius.circular(4)),
//                 child: buildCacheNetworkImage(width: boxImageSize, height: boxImageSize, url: widget.searchData.imageURL)),
//             SizedBox(
//               width: 10,
//             ),
//             Expanded(
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   Text(
//                     widget.searchData.name,
//                     style: TextStyle(
//                         fontSize: 13,
//                         color: _color1
//                     ),
//                     maxLines: 3,
//                     overflow: TextOverflow.ellipsis,
//                   ),
//                   Container(
//                     margin: const EdgeInsets.only(top: 5),
//                     child: Text('\$ ${_globalFunction.removeDecimalZeroFormat(widget.searchData.price)}',
//                         style: const TextStyle(
//                             fontSize: 13,
//                             fontWeight: FontWeight.bold
//                         )),
//                   ),
//                   // Container(
//                   //   margin: EdgeInsets.only(top: 5),
//                   //   child: Row(
//                   //     children: [
//                   //       Icon(Icons.location_on,
//                   //           color: _color2, size: 12),
//                   //       Text(' '+widget.searchData.location,
//                   //           style: TextStyle(
//                   //               fontSize: 11,
//                   //               color: _color2
//                   //           ))
//                   //     ],
//                   //   ),
//                   // ),
//                   // Container(
//                   //   margin: EdgeInsets.only(top: 5),
//                   //   child: Row(
//                   //     children: [
//                   //       _globalWidget.createRatingBar(rating: widget.searchData.rating, size: 12),
//                   //       Text('('+widget.searchData.review.toString()+')', style: TextStyle(
//                   //           fontSize: 11,
//                   //           color: _color2
//                   //       ))
//                   //     ],
//                   //   ),
//                   // ),
//                   // Container(
//                   //   margin: EdgeInsets.only(top: 5),
//                   //   child: Text(widget.searchData.sale.toString()+' Sale',
//                   //       style: TextStyle(
//                   //           fontSize: 11,
//                   //           color: _color2
//                   //       )),
//                   // ),
//                 ],
//               ),
//             )
//           ],
//         ),
//       ),
//     );
//   }
// }
