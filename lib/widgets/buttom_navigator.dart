import 'package:flutter/material.dart';
import 'package:re_fotos/core/app_colors.dart';
import 'package:re_fotos/core/app_images.dart';
import 'package:re_fotos/feature/edit/edit_screen.dart';
import 'package:re_fotos/feature/home/main_screen.dart';
import 'package:re_fotos/feature/photos/my_photos_screen.dart';
import 'package:re_fotos/feature/settings/settings_screen.dart';

class BottomNavigatorScreen extends StatefulWidget {
  const BottomNavigatorScreen({Key? key}) : super(key: key);

  @override
  State<BottomNavigatorScreen> createState() => _BottomNavigatorState();
}

class _BottomNavigatorState extends State<BottomNavigatorScreen> {
  int index = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: pages[index],
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          boxShadow: <BoxShadow>[
            BoxShadow(
              color: AppColors.color00B0F1Blue1,
              blurRadius: 10,
            ),
          ],
        ),
        child: ClipRRect(
          borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(12),
            topRight: Radius.circular(12),
          ),
          child: BottomNavigationBar(
            elevation: 10,
            backgroundColor: AppColors.colorCAF0FABlue3,
            type: BottomNavigationBarType.fixed,
            unselectedFontSize: 10,
            selectedFontSize: 10,
            selectedLabelStyle: const TextStyle(
              fontWeight: FontWeight.w400,
            ),
            unselectedLabelStyle: const TextStyle(
              fontWeight: FontWeight.w400,
            ),
            selectedItemColor: AppColors.white,
            unselectedItemColor: AppColors.white.withOpacity(0.5),
            currentIndex: index,
            onTap: (indexFrom) {
              setState(() {
                index = indexFrom;
              });
            },
            items: [
              BottomNavigationBarItem(
                activeIcon: Image.asset(
                  AppImages.navbarHomeActive,
                  height: 30,
                ),
                icon: Image.asset(
                  AppImages.navbarHome,
                  height: 30,
                ),
                label: "",
              ),
              BottomNavigationBarItem(
                activeIcon: Image.asset(
                  AppImages.navbarEditActive,
                  height: 35,
                ),
                icon: Image.asset(
                  AppImages.navbarEdit,
                  height: 35,
                ),
                label: "",
              ),
              BottomNavigationBarItem(
                activeIcon: Image.asset(
                  AppImages.navbarPhotosActive,
                  height: 30,
                ),
                icon: Image.asset(
                  AppImages.navbarPhotos,
                  height: 30,
                ),
                label: '',
              ),
              BottomNavigationBarItem(
                activeIcon: Image.asset(
                  AppImages.navbarSettingsActive,
                  height: 30,
                ),
                icon: Image.asset(
                  AppImages.navbarSettings,
                  height: 30,
                ),
                label: "",
              ),
            ],
          ),
        ),
      ),
    );
  }
}

List<Widget> pages = [
  const MainScreen(),
  const EditScreen(),
  const MyPhotosScreen(),
  const SettingsScreen(),
];
