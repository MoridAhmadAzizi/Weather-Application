import 'package:flutter/material.dart';
import 'package:skeletonizer/skeletonizer.dart';
import 'package:weather_application/constants/app_colors.dart';
import 'package:weather_application/constants/text_styles.dart';
import 'package:weather_application/skeletons/hourly_forecast_skeleton.dart';
import 'package:weather_application/views/gradient_container.dart';
import 'package:weather_application/views/weather_info.dart';

class WeatherScreenSkeleton extends StatelessWidget {
  const WeatherScreenSkeleton({super.key});

  @override
  Widget build(BuildContext context) {
    return Skeletonizer(
      effect: const ShimmerEffect(
        baseColor: AppColors.accentBlue,
        highlightColor: AppColors.skeletonHighlight,
      ),
      child: GradientContainer(
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text('City name', style: TextStyles.h1),
              const SizedBox(height: 20),
              Text('October 31, 2026', style: TextStyles.subtitleText),
              const SizedBox(height: 30),
              const Bone.circle(size: 220),
              const SizedBox(height: 40),
              Text('clear sky', style: TextStyles.h2),
            ],
          ),
          const SizedBox(height: 40),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              WeatherInfoTile(title: 'Temp', value: '20.39'),
              WeatherInfoTile(title: 'Wind', value: '7.06 km/h'),
              WeatherInfoTile(title: 'Humidity', value: '18%'),
            ],
          ),
          const SizedBox(height: 40),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('Today', style: TextStyles.h2),
            ],
          ),
          const SizedBox(height: 15),
          const HourlyForecastSkeleton(),
        ],
      ),
    );
  }
}
