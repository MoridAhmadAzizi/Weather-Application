import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:weather_application/constants/app_colors.dart';
import 'package:weather_application/constants/text_styles.dart';
import 'package:weather_application/extensions/int.dart';
import 'package:weather_application/providers/hourly_weather_provider.dart';
import 'package:weather_application/skeletons/hourly_forecast_skeleton.dart';
import 'package:weather_application/utils/get_weather_icons.dart';
import 'package:weather_application/views/error_view.dart';

class HourlyForecastView extends ConsumerWidget {
  const HourlyForecastView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final hourlyWeatherData = ref.watch(hourlyWeatherProvider);
    return hourlyWeatherData.when(
      data: (hourlyWeather) {
        return SizedBox(
          height: 100,
          child: ListView.builder(
            itemCount: hourlyWeather.list.length,
            shrinkWrap: true,
            scrollDirection: Axis.horizontal,
            itemBuilder: (context, index) {
              final weather = hourlyWeather.list[index];
              return HourlyForecastTile(
                id: weather.weather[0].id,
                hour: weather.dt.time,
                temp: weather.main.temp.round(),
                isActive: index == 0,
              );
            },
          ),
        );
      },
      error: (error, stackTrace) => SizedBox(
        height: 100,
        child: ErrorView.retry(
          message: 'Could not load hourly forecast',
          compact: true,
          onRetry: () => ref.invalidate(hourlyWeatherProvider),
        ),
      ),
      loading: () => HourlyForecastSkeleton(),
    );
  }
}

class HourlyForecastTile extends StatelessWidget {
  const HourlyForecastTile({
    super.key,
    required this.id,
    required this.hour,
    required this.temp,
    required this.isActive,
  });

  final int id;
  final String hour;
  final int temp;
  final bool isActive;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(right: 16, top: 12, bottom: 12),
      child: Material(
        color: isActive ? AppColors.lightBlue : AppColors.accentBlue,
        borderRadius: BorderRadius.circular(10.0),
        elevation: isActive ? 8 : 0,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Image.asset(getWeatherIcon(weatherCode: id), width: 50),
              const SizedBox(width: 10),
              Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(hour, style: TextStyle(color: AppColors.white)),
                  SizedBox(height: 5),
                  Text('$temp\u00B0', style: TextStyles.h3),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
