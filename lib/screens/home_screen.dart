import 'package:flutter/material.dart';
import 'package:weather_application/constants/app_colors.dart';
import 'package:weather_application/screens/forecast_screen.dart';
import 'package:weather_application/screens/search_screen.dart';
import 'package:weather_application/screens/weather_screen.dart';
import 'package:weather_application/widgets/nav_bar_item.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _currentPageIndex = 0;

  final _icons = const [
    [Icons.home_outlined, Icons.home],
    [Icons.search_outlined, Icons.search],
    [Icons.wb_sunny_outlined, Icons.wb_sunny],
  ];

  final _screens = [WeatherScreen(), SearchScreen(), ForecastScreen()];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _screens[_currentPageIndex],
      bottomNavigationBar: Container(
        color: AppColors.secondaryBlack,
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 10),
            child: Container(
              height: 64,

              padding: const EdgeInsets.symmetric(horizontal: 10),

              decoration: BoxDecoration(
                color: AppColors.accentBlue,
                borderRadius: BorderRadius.circular(32),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: List.generate(_icons.length, (index) {
                  return NavBarItem(
                    icon: _icons[index][0],
                    selectedIcon: _icons[index][1],
                    isSelected: index == _currentPageIndex,
                    onTap: () => setState(() => _currentPageIndex = index),
                  );
                }),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
