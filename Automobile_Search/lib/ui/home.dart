
import 'package:flutter/material.dart';
import 'package:carismatic/ui/account/tab_account.dart';
import 'package:carismatic/ui/home/tab_home.dart';
import 'package:flashy_tab_bar2/flashy_tab_bar2.dart';
import 'package:carismatic/constants/constant.dart';


class HomePage extends StatefulWidget {
  const HomePage({ Key? key }) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late PageController _pageController;
  int _selectedPage = 0;

  List<Widget> pages = [
    TabHomePage(),
    TabAccountPage()
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedPage = index;
      _pageController.jumpToPage(index);
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    _pageController = PageController(initialPage: 0);

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageView(
        onPageChanged: (index) => setState(() { _selectedPage = index; }),
        controller: _pageController,
        children: [
          ...pages
        ],
      ),
      bottomNavigationBar: FlashyTabBar(
        selectedIndex: _selectedPage,
        showElevation: false,
        onItemSelected: (index) => _onItemTapped(index),
        items: [
          FlashyTabBarItem(
            icon: const Icon(Icons.home_outlined, size: 23, color: PRIMARY_COLOR,),
            title: const Text('Home'),
          ),
          FlashyTabBarItem(
            icon: const Icon(Icons.account_circle_outlined, size: 23, color: PRIMARY_COLOR,),
            title: const Text('Account',),
          ),
        ],
      ),
    );
  }
}




// import 'account/tab_account.dart';
// import 'home/tab_home.dart';
// import 'package:flutter/material.dart';
// import '../constants/constant.dart';
//
// class HomePage extends StatefulWidget {
//   const HomePage({Key? key}) : super(key: key);
//
//   @override
//   _HomePageState createState() => _HomePageState();
// }
//
// class _HomePageState extends State<HomePage> with SingleTickerProviderStateMixin {
//   late PageController _pageController;
//   int _currentIndex = 0;
//
//   // Pages if you click bottom navigation
//   final List<Widget> _contentPages = <Widget>[
//     const TabHomePage(),
//     TabAccountPage(),
//   ];
//
//   @override
//   void initState() {
//     // set initial pages for navigation to home page
//     _pageController = PageController(initialPage: 0);
//     _pageController.addListener(_handleTabSelection);
//     super.initState();
//   }
//
//   void _handleTabSelection() {
//     setState(() {
//     });
//   }
//
//   @override
//   void dispose() {
//     _pageController.dispose();
//     super.dispose();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: PageView(
//         controller: _pageController,
//         physics: const NeverScrollableScrollPhysics(),
//         children: _contentPages.map((Widget content) {
//           return content;
//         }).toList(),
//       ),
//       bottomNavigationBar: BottomNavigationBar(
//         type: BottomNavigationBarType.fixed,
//         currentIndex: _currentIndex,
//         onTap: (value) {
//           _currentIndex = value;
//           _pageController.jumpToPage(value);
//           // this unfocus is to prevent show keyboard in the wishlist page when focus on search text field
//           FocusScope.of(context).unfocus();
//         },
//         selectedFontSize: 8,
//         unselectedFontSize: 8,
//         iconSize: 28,
//         items: [
//           BottomNavigationBarItem(
//             // ignore: deprecated_member_use
//               label:('Home'),
//               icon: Icon(
//                   Icons.home,
//                   color: _currentIndex == 0 ? PRIMARY_COLOR : CHARCOAL
//               )
//           ),
//           BottomNavigationBarItem(
//             // ignore: deprecated_member_use
//               label: ('Account'),
//               icon: Icon(
//                   Icons.person_outline,
//                   color: _currentIndex == 1 ? PRIMARY_COLOR : CHARCOAL
//               )
//           ),
//         ],
//       ),
//     );
//   }
// }
