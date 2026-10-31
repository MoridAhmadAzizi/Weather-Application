import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:weather_application/constants/app_colors.dart';
import 'package:weather_application/constants/text_styles.dart';
import 'package:weather_application/providers/get_weather_by_city_provider.dart';
import 'package:weather_application/utils/get_weather_icons.dart';

class FamousCityTile extends ConsumerWidget {
  const FamousCityTile({super.key, required this.city, required this.index});

  final String city;
  final int index;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final weatherData = ref.watch(getWeatherByCityProvider(city));
    return weatherData.when(
      data: (weather) {
        return Material(
          color: index == 0 ? AppColors.lightBlue : AppColors.accentBlue,
          elevation: index == 0 ? 8 : 0,
          borderRadius: BorderRadius.circular(12),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 24),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                           '${weather.main.temp.round().toString()}\u00B0',
                            style: TextStyles.h2,
                          ),
                          SizedBox(height: 10),
                          Text(
                            weather.weather[0].description,
                            style: TextStyles.subtitleText,
                            overflow: TextOverflow.ellipsis,
                            maxLines: 2,
                          ),
                        ],
                      ),
                    ),
                    Image.asset(
                      width: 50,
                      getWeatherIcon(weatherCode: weather.weather[0].id),
                    ),
                  ],
                ),
                Text(
                  weather.name,
                  style: TextStyle(
                    fontSize: 18,
                    color: AppColors.white.withValues(alpha: .8),
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
        );
      },
      error: (error, stackTrace) => Center(child: Text(error.toString())),
      loading: () => Center(child: CircularProgressIndicator()),
    );
  }
}
