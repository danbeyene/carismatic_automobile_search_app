import 'package:carismatic/constants/constant.dart';
import 'package:carismatic/constants/global_style.dart';
import 'edit_profile.dart';
import 'package:carismatic/ui/reusable_widget.dart';
import 'package:carismatic/ui/reusable/cache_image_network.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class AccountInformationPage extends StatefulWidget {
  @override
  _AccountInformationPageState createState() => _AccountInformationPageState();
}

class _AccountInformationPageState extends State<AccountInformationPage> {
  // initialize reusable widget
  final Color _color1 = const Color(0xFFE43F3F);
  final Color _color2 = const Color(0xFF333333);
  final Color _color3 = const Color(0xFF666666);
  final _reusableWidget = ReusableWidget();

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          iconTheme: const IconThemeData(
            color: GlobalStyle.appBarIconThemeColor,
          ),
          elevation: GlobalStyle.appBarElevation,
          title: const Text(
            'Account Information',
            style: GlobalStyle.appBarTitle,
          ),
          backgroundColor: GlobalStyle.appBarBackgroundColor,
          systemOverlayStyle: GlobalStyle.appBarSystemOverlayStyle,
          bottom: _reusableWidget.bottomAppBar(),
        ),
        body: Container(
          margin: const EdgeInsets.fromLTRB(16, 0, 16, 16),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _createProfilePicture(),
                Container(
                  margin: const EdgeInsets.only(top: 10),
                  alignment: Alignment.center,
                  child: Text('Robert Steven', style: TextStyle(
                      fontSize: 18, fontWeight: FontWeight.bold, color: _color2
                  )),
                ),
                Container(
                  margin: const EdgeInsets.only(top: 5),
                  alignment: Alignment.center,
                  child: GestureDetector(
                    onTap: (){
                      // Fluttertoast.showToast(msg: 'Click edit profile', toastLength: Toast.LENGTH_SHORT);
                      Navigator.push(context, MaterialPageRoute(builder: (context) => EditProfilePage()));
                    },
                    child: Text('edit profile', style: TextStyle(
                        fontSize: 14, fontWeight: FontWeight.bold, color: _color1, decoration: TextDecoration.underline, decorationThickness: 2
                    )),
                  ),
                ),
                const SizedBox(height: 40),
                // const Text(
                //   'Name',
                //   style: GlobalStyle.accountInformationLabel,
                // ),
                // const SizedBox(
                //   height: 8,
                // ),
                // Row(
                //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                //   children: [
                //     const Expanded(
                //       child: Text(
                //         'Robert Steven',
                //         style: GlobalStyle.accountInformationValue,
                //       ),
                //     ),
                //     GestureDetector(
                //       onTap: (){
                //         Navigator.push(context, MaterialPageRoute(builder: (context) => EditNamePage()));
                //       },
                //       child: const Text('Edit', style: GlobalStyle.accountInformationEdit),
                //     )
                //   ],
                // ),
                // const SizedBox(
                //   height: 24,
                // ),
                // Row(
                //   children: [
                //     const Text(
                //       'Email',
                //       style: GlobalStyle.accountInformationLabel,
                //     ),
                //     const SizedBox(
                //       width: 8,
                //     ),
                //     _verifiedLabel()
                //   ],
                // ),
                // const SizedBox(
                //   height: 8,
                // ),
                // Row(
                //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                //   children: [
                //     const Expanded(
                //       child: Text(
                //         'robert.steven@ijteknologi.com',
                //         style: GlobalStyle.accountInformationValue,
                //       ),
                //     ),
                //     GestureDetector(
                //       onTap: (){
                //         Navigator.push(context, MaterialPageRoute(builder: (context) => EditEmailPage()));
                //       },
                //       child: const Text('Edit', style: GlobalStyle.accountInformationEdit),
                //     )
                //   ],
                // ),
                // const SizedBox(
                //   height: 24,
                // ),
                // Row(
                //   children: [
                //     const Text(
                //       'Phone Number',
                //       style: GlobalStyle.accountInformationLabel,
                //     ),
                //     const SizedBox(
                //       width: 8,
                //     ),
                //     _verifiedLabel()
                //   ],
                // ),
                // const SizedBox(height: 8),
                // Row(
                //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                //   children: [
                //     const Expanded(
                //       child: Text(
                //         '0811888999',
                //         style: GlobalStyle.accountInformationValue,
                //       ),
                //     ),
                //     GestureDetector(
                //       onTap: (){
                //         Navigator.push(context, MaterialPageRoute(builder: (context) => EditPhoneNumberPage()));
                //       },
                //       child: const Text('Edit', style: GlobalStyle.accountInformationEdit),
                //     )
                //   ],
                // ),
                Container(

                  margin: const EdgeInsets.only(top: 32),
                  padding: const EdgeInsets.all(32),
                  decoration: const BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.all(
                        Radius.circular(10.0)
                    ),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('First Name', style: TextStyle(
                          color: Colors.grey[700], fontSize: 13
                      )),
                      const SizedBox(height: 4),
                      Text('Robert ', style: TextStyle(
                          color: _color3, fontSize: 15, fontWeight: FontWeight.bold
                      )),
                      const SizedBox(height: 16),
                      Text('Last Name', style: TextStyle(
                          color: Colors.grey[700], fontSize: 13
                      )),
                      const SizedBox(height: 4),
                      Text('steven', style: TextStyle(
                          color: _color3, fontSize: 15, fontWeight: FontWeight.bold
                      )),
                      const SizedBox(height: 16),
                      Text('User Name', style: TextStyle(
                          color: Colors.grey[700], fontSize: 13
                      )),
                      const SizedBox(height: 4),
                      Text('robe23', style: TextStyle(
                          color: _color3, fontSize: 15, fontWeight: FontWeight.bold
                      )),
                      const SizedBox(height: 16),
                      Text('Email', style: TextStyle(
                          color: Colors.grey[700], fontSize: 13
                      )),
                      const SizedBox(height: 4),
                      Text('robertsteven@domain.com', style: TextStyle(
                          color: _color3, fontSize: 15, fontWeight: FontWeight.bold
                      )),
                      const SizedBox(height: 16),
                      Text('Phone Number', style: TextStyle(
                          color: Colors.grey[700], fontSize: 13
                      )),
                      const SizedBox(height: 4),
                      Text('0985256113', style: TextStyle(
                          color: _color3, fontSize: 15, fontWeight: FontWeight.bold
                      )),
                      const SizedBox(height: 16),
                      Text('Date of Birth', style: TextStyle(
                          color: Colors.grey[700], fontSize: 13
                      )),
                      const SizedBox(height: 4),
                      Text('1999-09-19', style: TextStyle(
                          color: _color3, fontSize: 15, fontWeight: FontWeight.bold
                      )),

                    ],
                  ),
                )
              ],
            ),
          ),
        )
    );
  }

  Widget _createProfilePicture(){
    final double profilePictureSize = MediaQuery.of(context).size.width/3;
    return Align(
      alignment: Alignment.center,
      child: Container(
        margin: const EdgeInsets.only(top: 40),
        width: profilePictureSize,
        height: profilePictureSize,
        child: GestureDetector(
          onTap: () {
            _showPopupUpdatePicture();
          },
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
      ),
    );
  }

  // Widget _verifiedLabel(){
  //   return Container(
  //     padding: const EdgeInsets.fromLTRB(8, 2, 8, 2),
  //     decoration: BoxDecoration(
  //         color: SOFT_BLUE,
  //         borderRadius: BorderRadius.circular(2)
  //     ),
  //     child: Row(
  //       children: const [
  //         Text('verified', style: TextStyle(
  //             color: Colors.white, fontSize: 11
  //         )),
  //         SizedBox(
  //           width: 4,
  //         ),
  //         Icon(Icons.done, color: Colors.white, size: 11)
  //       ],
  //     ),
  //   );
  // }

  void _showPopupUpdatePicture() {
    // set up the buttons
    Widget cancelButton = TextButton(
        onPressed: () {
          Navigator.pop(context);
        },
        child: const Text('No', style: TextStyle(color: SOFT_BLUE))
    );
    Widget continueButton = TextButton(
        onPressed: () {
          Navigator.pop(context);
          Fluttertoast.showToast(msg: 'Click edit profile picture', toastLength: Toast.LENGTH_SHORT);
        },
        child: const Text('Yes', style: TextStyle(color: SOFT_BLUE))
    );

    // set up the AlertDialog
    AlertDialog alert = AlertDialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      title: const Text('Edit Profile Picture', style: TextStyle(fontSize: 18),),
      content: const Text('Do you want to edit profile picture ?', style: TextStyle(fontSize: 13, color: BLACK_GREY)),
      actions: [
        cancelButton,
        continueButton,
      ],
    );

    // show the dialog
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }
}
