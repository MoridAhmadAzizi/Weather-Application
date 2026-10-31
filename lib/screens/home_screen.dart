import 'package:flutter/material.dart';
import 'package:weather_application/constants/app_colors.dart';
import 'package:weather_application/screens/forecast_screen.dart';
import 'package:weather_application/screens/search_screen.dart';
import 'package:weather_application/screens/weather_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _currentPageIndex = 0;
  final _destinations = const [
    NavigationDestination(
      icon: Icon(Icons.home_outlined, color: AppColors.white),
      selectedIcon: Icon(Icons.home, color: AppColors.white),
      label: '',
    ),
    NavigationDestination(
      icon: Icon(Icons.search_outlined, color: AppColors.white),
      selectedIcon: Icon(Icons.search, color: AppColors.white),
      label: '',
    ),
    NavigationDestination(
      icon: Icon(Icons.wb_sunny_outlined, color: AppColors.white),
      selectedIcon: Icon(Icons.wb_sunny, color: AppColors.white),
      label: '',
    ),
  ];

  final _screens = [
    WeatherScreen(),
    SearchScreen(),
    ForecastScreen(),
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _screens[_currentPageIndex],
      bottomNavigationBar: NavigationBarTheme(
        data: NavigationBarThemeData(backgroundColor: AppColors.secondaryBlack),
        child: NavigationBar(
          destinations: _destinations,
          labelBehavior: NavigationDestinationLabelBehavior.alwaysHide,
          selectedIndex: _currentPageIndex,
          indicatorColor: Colors.transparent,
          onDestinationSelected: (index) {
            setState(() {
              _currentPageIndex = index;
            });
          },
        ),
      ),
    );
  }
}
