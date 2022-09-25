import 'package:berhentikok/base/color_const.dart';
import 'package:berhentikok/base/font_const.dart';
import 'package:berhentikok/page/home/widget/home_page_detail.dart';
import 'package:berhentikok/page/statistic/statistic_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with WidgetsBindingObserver {
  final _pageViewController = PageController();
  int _selectedIndex = 0;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
  }

  @override
  void dispose() {
    _pageViewController.dispose();
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageView(
        controller: _pageViewController,
        onPageChanged: (index) {
          setState(() {
            _selectedIndex = index;
          });
        },
        children: const [
          HomePageDetail(),
          StatisticPage(),
        ],
      ),
      bottomNavigationBar: Container(
        padding: EdgeInsets.symmetric(vertical: 5.h),
        decoration: BoxDecoration(
          color: ColorConst.darkGreen,
          borderRadius: BorderRadius.vertical(top: Radius.circular(20.r)),
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.vertical(top: Radius.circular(20.r)),
          child: BottomNavigationBar(
            backgroundColor: ColorConst.darkGreen,
            selectedItemColor: Colors.white,
            selectedLabelStyle: FontConst.body(
              color: Colors.white,
              fontWeight: FontWeight.w600,
            ),
            unselectedLabelStyle: FontConst.body(
              color: ColorConst.lightGreen,
              fontWeight: FontWeight.w600,
            ),
            currentIndex: _selectedIndex,
            onTap: (index) {
              _pageViewController.animateToPage(
                index,
                duration: const Duration(milliseconds: 200),
                curve: Curves.bounceOut,
              );
            },
            items: const [
              BottomNavigationBarItem(
                icon: Icon(Icons.home_outlined),
                label: "Home",
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.analytics_rounded),
                label: "Statistik",
              ),
            ],
          ),
        ),
      ),
    );
  }
}
