import 'package:app3/core/resources/app_colors.dart';
import 'package:app3/core/resources/app_icons.dart';
import 'package:app3/features/account/profile.dart';
import 'package:app3/features/cart/cart_screen.dart';
import 'package:app3/features/home/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class HomeNav extends StatefulWidget {
  const HomeNav({super.key});

  @override
  State<HomeNav> createState() => HomeNavState();
}

class HomeNavState extends State<HomeNav> {
  List<Widget> screens = [HomeScreen(), CartScreen(), Profile()];
  int currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xffFFFFFF),
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(20),
            topRight: Radius.circular(20),
          ),
          border: Border.all(color: Color(0xffE9E9E9), width: 1),
          boxShadow: [
            BoxShadow(
              color: Colors.black12,
              blurRadius: 100,
              spreadRadius: 0,
              offset: Offset(0, -5),
            ),
          ],
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(20),
            topRight: Radius.circular(20),
          ),
          child: BottomNavigationBar(
            currentIndex: currentIndex,
            onTap: (value) {
              setState(() {
                currentIndex = value;
              });
            },
            elevation: 0,
            type: BottomNavigationBarType.fixed,
            backgroundColor: Colors.white,
            unselectedItemColor: AppColors.textColor,
            selectedItemColor: AppColors.mainColor,
            selectedLabelStyle: TextStyle(
              fontWeight: FontWeight.w500,
              fontSize: 14,
            ),
            unselectedLabelStyle: TextStyle(
              fontWeight: FontWeight.w500,
              fontSize: 14,
            ),
            items: [
              BottomNavigationBarItem(
                icon: SvgPicture.asset(
                  AppIcons.home,
                  colorFilter: ColorFilter.mode(
                    currentIndex == 0
                        ? AppColors.mainColor
                        : AppColors.textColor,
                    BlendMode.srcIn,
                  ),
                ),
                label: "Home",
              ),
              BottomNavigationBarItem(
                icon: SvgPicture.asset(
                  AppIcons.navCart,
                  colorFilter: ColorFilter.mode(
                    currentIndex == 1
                        ? AppColors.mainColor
                        : AppColors.textColor,
                    BlendMode.srcIn,
                  ),
                ),
                label: "Cart",
              ),
              BottomNavigationBarItem(
                icon: SvgPicture.asset(
                  AppIcons.user,
                  colorFilter: ColorFilter.mode(
                    currentIndex == 2
                        ? AppColors.mainColor
                        : AppColors.textColor,
                    BlendMode.srcIn,
                  ),
                ),
                label: "Account",
              ),
            ],
          ),
        ),
      ),

      body: screens.elementAt(currentIndex),
    );
  }
}
