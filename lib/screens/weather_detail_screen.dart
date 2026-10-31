import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:weather_application/constants/text_styles.dart';
import 'package:weather_application/extensions/datetime.dart';
import 'package:weather_application/extensions/strings.dart';
import 'package:weather_application/providers/get_weather_by_city_provider.dart';
import 'package:weather_application/views/gradient_container.dart';
import 'package:weather_application/views/weather_info.dart';

class WeatherDetailScreen extends ConsumerWidget {
  const WeatherDetailScreen({super.key, required this.cityName});

  final String cityName;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final weatherData = ref.watch(getWeatherByCityProvider(cityName));
    return Scaffold(
      body: weatherData.when(
        data: (weather) {
          return GradientContainer(
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(weather.name, style: TextStyles.h1),
                  SizedBox(height: 20),
                  Text(DateTime.now().dateTime, style: TextStyles.subtitleText),
                  SizedBox(height: 50),
                  SizedBox(
                    height: 260,
                    child: Image.asset(
                      'assets/icons/${weather.weather[0].icon.replaceAll('n', 'd')}.png',
                    ),
                  ),
                  SizedBox(height: 50),
                  Text(
                    weather.weather[0].description.capitalize,
                    style: TextStyles.h2,
                  ),
                ],
              ),
              SizedBox(height: 40),
              WeatherInfo(weather: weather),
              SizedBox(height: 15),
            ],
          );
        },
        error: (error, stackTrace) => Center(child: Text(error.toString())),
        loading: () => Center(child: CircularProgressIndicator()),
      ),
    );
  }
}
