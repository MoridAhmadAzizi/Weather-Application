import 'package:flutter/material.dart';
import 'package:skeletonizer/skeletonizer.dart';
import 'package:weather_application/constants/app_colors.dart';
import 'package:weather_application/views/hourly_forecast_view.dart';

class HourlyForecastSkeleton extends StatelessWidget {
  const HourlyForecastSkeleton({super.key});

  @override
  Widget build(BuildContext context) {
    return Skeletonizer(
      effect: const ShimmerEffect(
        baseColor: AppColors.skeletonHighlight,
        highlightColor: AppColors.lightBlue,
      ),
      child: SizedBox(
        height: 100,
        child: ListView.builder(
          itemCount: 4, 
          scrollDirection: Axis.horizontal,
          physics: const NeverScrollableScrollPhysics(),
          itemBuilder: (context, index) {
            return const HourlyForecastTile(
              id: 800, 
              hour: '00:00',
              temp: 20,
              isActive: false,
            );
          },
        ),
      ),
    );
  }
}