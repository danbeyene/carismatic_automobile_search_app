
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
    //HomeScreen(),
    //MainPage(),
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
