import 'package:flutter/material.dart';
import 'package:skeletonizer/skeletonizer.dart';
import 'package:weather_application/constants/app_colors.dart';
import 'package:weather_application/views/weekly_forecast_view.dart';

class WeeklyForecastSkeleton extends StatelessWidget {
  const WeeklyForecastSkeleton({super.key});

  @override
  Widget build(BuildContext context) {
    return Skeletonizer(
      effect: const ShimmerEffect(
        baseColor: AppColors.skeletonHighlight,
        highlightColor: AppColors.lightBlue,
      ),
      child: ListView.builder(
        itemCount: 7, // one fake tile per day
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        itemBuilder: (context, index) {
          return const WeeklyWeatherTile(
            day: 'Monday',
            date: '2026-10-31',
            temp: 20,
            icon: 'assets/icons/01d.png', 
          );
        },
      ),
    );
  }
}