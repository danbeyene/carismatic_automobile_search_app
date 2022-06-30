import 'package:carismatic/model/automobile.dart';
import 'package:flutter/material.dart';

class AutomobileViewPage extends StatefulWidget {
  final Automobile automobile;
  const AutomobileViewPage({ Key? key, required this.automobile }) : super(key: key);

  @override
  _AutomobileViewPageState createState() => _AutomobileViewPageState();
}

class _AutomobileViewPageState extends State<AutomobileViewPage> {
  List<dynamic> automobileList = [];


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
                  background: Image.network(widget.automobile.imageURL, fit: BoxFit.cover,)
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
                                  Text(widget.automobile.name,
                                    style: const TextStyle(color: Colors.black, fontSize: 22, fontWeight: FontWeight.bold,),
                                  ),
                                  const SizedBox(height: 5,),
                                  Text(widget.automobile.brand, style: TextStyle(color: Colors.orange.shade400, fontSize: 14,),),
                                ],
                              ),
                              Text("\$ " +widget.automobile.price.toString() + '.00',
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