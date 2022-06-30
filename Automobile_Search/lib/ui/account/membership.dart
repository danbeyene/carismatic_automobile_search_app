import 'package:carismatic/constants/constant.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:carismatic/ui/reusable/cache_image_network.dart';




class MembershipPage extends StatefulWidget {
  const MembershipPage({Key? key}) : super(key: key);

  @override
  _MembershipPageState createState() => _MembershipPageState();
}

class _MembershipPageState extends State<MembershipPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: false,
        leading: const Icon(
          CupertinoIcons.back,
          color: Colors.black,
        ),
        title: const Text(
          'Memberships',
          style: TextStyle(color: Colors.black,fontSize: 14),
        ),
        elevation: 0,
        backgroundColor: Colors.white,
      ),
      body: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        color: Colors.white,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            _carismaticLogo(),
            _carismatic(),
            _currentPlan(),
            _infoBox(),
            _addSubscription(),
            _cancelSubscription(),
            Expanded(child: _otherPlanLayout()),
          ],
        ),
      ),
    );
  }

  ///other plan layouts
  Widget _otherPlanLayout() {
    return Padding(
      padding: EdgeInsets.only(
          right: MediaQuery.of(context).size.width * 0.1,
          left: MediaQuery.of(context).size.width * 0.1),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        mainAxisAlignment: MainAxisAlignment.end,
        children: <Widget>[
          _planRow(),
        ],
      ),
    );
  }

  Widget _planRow() {
    return SizedBox(
      width: MediaQuery.of(context).size.width * 0.8,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          SizedBox(width: MediaQuery.of(context).size.width * 0.03),
          // _premiumPlanBox()
        ],
      ),
    );
  }





  ///Cancel subscription option
  Widget _cancelSubscription() {
    return Padding(
      padding: EdgeInsets.only(top: MediaQuery.of(context).size.height * 0.03),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        GestureDetector(
          onTap: () {
            Fluttertoast.showToast(msg: 'Click Cancel Subscription', toastLength: Toast.LENGTH_SHORT);
          },
          child: Row(
            children: <Widget>[
              const Text(
                'CANCEL SUBSCRIPTION',
                style: TextStyle(
                    letterSpacing: 0.5,
                    color: Colors.black,
                    fontWeight: FontWeight.w800,
                    fontSize: 14),
                textAlign: TextAlign.center,
              ),
              SizedBox(width: MediaQuery.of(context).size.width * 0.02),
              const Icon(
                CupertinoIcons.forward,
                color: Colors.black,
              )

            ],
          ),

        ),
      ],
    ),
    );
  }

  ///Add subscription option
  Widget _addSubscription() {
    return Padding(
      padding: EdgeInsets.only(top: MediaQuery.of(context).size.height * 0.03),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          GestureDetector(
          onTap: () {
            Fluttertoast.showToast(msg: 'Click Add Subscription', toastLength: Toast.LENGTH_SHORT);
        },
      child: Row(
        children: <Widget>[
           const Text(
            'ADD SUBSCRIPTION',
            style: TextStyle(
                letterSpacing: 0.5,
                color: Colors.black,
                fontWeight: FontWeight.w900,
                fontSize: 14),
            textAlign: TextAlign.center,
          ),
      SizedBox(width: MediaQuery.of(context).size.width * 0.02),
      const Icon(
        CupertinoIcons.forward,
        color: Colors.black,
      )

            ],
      ),

    ),
      ],
    ));
  }

  ///Subscription info box
  Widget _infoBox() {
    return Center(
      child: Padding(
        padding: EdgeInsets.symmetric(
            horizontal: MediaQuery.of(context).size.width * 0.08),
        child: Container(
          width: MediaQuery.of(context).size.width,
          margin:
          EdgeInsets.only(top: MediaQuery.of(context).size.height * 0.05),
          padding: const EdgeInsets.all(15),
          decoration: BoxDecoration(
            color: Colors.grey[100],
            border: Border.all(color: Colors.grey.shade300),
            borderRadius: BorderRadius.circular(5),
          ),
          child: const Text(
            'Your current subscription will end next month.\nAnd will be renewed automatically.',
            style: TextStyle(
                letterSpacing: 1,
                color: Colors.black,
                fontWeight: FontWeight.w400,
                fontSize: 12),
            textAlign: TextAlign.center,
          ),
        ),
      ),
    );
  }

  ///caristic text
  Widget _carismatic() {
    return Center(
      child: Padding(
        padding:
        EdgeInsets.only(top: MediaQuery.of(context).size.height * 0.05),
        child: const Text('carsimatic membership plan',
            style: TextStyle(
                fontSize: 25,
                color: Colors.black,
                fontWeight: FontWeight.bold)),
      ),
    );
  }

  Widget _currentPlan() {
    return Center(
      child: Padding(
        padding:
        EdgeInsets.only(top: MediaQuery.of(context).size.height * 0.02),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Text("\$0.99/Annualy",
                style: TextStyle(
                    fontSize: 16,
                    color: Colors.black,
                    fontWeight: FontWeight.bold)),
            SizedBox(width: MediaQuery.of(context).size.width * 0.03),
            const Text("Remove Ads",
                style: TextStyle(
                    fontSize: 16,
                    color: Colors.black,
                    fontWeight: FontWeight.bold)),
          ],
        ),
      ),
    );
  }

  Widget _carismaticLogo() {
    final double profilePictureSize = MediaQuery.of(context).size.width/3;
    return Align(
      alignment: Alignment.center,
      child: Container(
        margin: const EdgeInsets.only(top: 40),
        width: profilePictureSize,
        height: profilePictureSize,
          child: Stack(
            children: [
              CircleAvatar(
                backgroundColor: Colors.white,
                radius: (profilePictureSize),
                child: Hero(
                  tag: 'profilePicture',
                  child: ClipOval(
                      child: buildCacheNetworkImage(width: profilePictureSize, height: profilePictureSize, url : '$GLOBAL_URL/assets/images/user/avatar.png')
                  ),
                ),
              ),
              // create edit icon in the picture
              Container(
                width: 30,
                height: 30,
                margin: EdgeInsets.only(top: 0, left: MediaQuery.of(context).size.width/4),
                child: Card(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30),
                  ),
                  elevation: 1,
                  child: const Icon(Icons.edit, size: 12, color: CHARCOAL),
                ),
              ),


            ],
          ),

      ),
    );
    // return Container(
    //   margin: EdgeInsets.only(top: MediaQuery.of(context).size.height * 0.12),
    //   width: MediaQuery.of(context).size.width * 0.2,
    //   height: MediaQuery.of(context).size.width * 0.2,
    //   decoration: BoxDecoration(
    //       color: Colors.white,
    //       shape: BoxShape.circle,
    //       boxShadow: [
    //         BoxShadow(
    //             color: Colors.black54.withOpacity(0.1),
    //             blurRadius: 10,
    //             offset: const Offset(0, 1))
    //       ]),
    //   child: const Center(
    //     child: Text(
    //       'C',
    //       style: TextStyle(
    //           fontSize: 34, color: Colors.red, fontWeight: FontWeight.bold),
    //     ),
    //   ),
    // );
  }
}