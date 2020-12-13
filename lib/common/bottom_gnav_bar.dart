import 'package:flutter/material.dart';
import 'package:google_nav_bar/google_nav_bar.dart';

class BottomGNavBar extends StatefulWidget {
  @override
  _BottomGNavBarState createState() => _BottomGNavBarState();
}

class _BottomGNavBarState extends State<BottomGNavBar> with TickerProviderStateMixin {
  AnimationController animationController;
  int _selectedIndex = 0;

  @override
  void initState() {
    animationController = AnimationController(duration: const Duration(milliseconds: 200), vsync: this);

    super.initState();
  }

  @override
  void dispose() {
    animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BottomAppBar(
      shape: const CircularNotchedRectangle(),
      child: _buildBottomGNavBarMenu(),
    );
  }

  Widget _buildBottomGNavBarMenu() {
    return Container(
      height: 80.0,
      // height: 10 * SizeConfig.heightMultiplier,
      decoration: BoxDecoration(color: Colors.white, boxShadow: [BoxShadow(blurRadius: 20, color: Colors.black.withOpacity(.1))]),
      child: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 5.0, vertical: 8),
          child: GNav(
              gap: 6,
              activeColor: Colors.white,
              iconSize: 24,
              padding: EdgeInsets.symmetric(horizontal: 20, vertical: 8),
              duration: Duration(milliseconds: 800),
              tabBackgroundColor: Colors.blue,
              tabs: [
                GButton(
                  icon: Icons.home,
                  text: 'Home',
                ),
                GButton(
                  icon: Icons.alarm,
                  text: 'Notifications',
                ),
                GButton(
                  icon: Icons.event,
                  text: 'Reading',
                ),
                GButton(
                  icon: Icons.face,
                  text: 'COOL',
                ),
              ],
              selectedIndex: _selectedIndex,
              onTabChange: (index) {
                setState(() {
                  _selectedIndex = index;
                });
              }),
        ),
      ),
    );
  }
}
