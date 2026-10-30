import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:weather_application/services/api_helper.dart';

final weeklyWeatherProvider = FutureProvider.autoDispose((ref) async {
  return ApiHelper.getWeeklyForecast();
});
