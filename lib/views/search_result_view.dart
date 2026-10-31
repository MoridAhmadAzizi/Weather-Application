import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:weather_application/providers/get_weather_by_city_provider.dart';
import 'package:weather_application/screens/weather_detail_screen.dart';
import 'package:weather_application/skeletons/famous_cities_skeleton.dart';
import 'package:weather_application/views/error_view.dart';
import 'package:weather_application/widgets/famous_city_tile.dart';

// Shows the result for one searched city: loading, error or the city tile
class SearchResultView extends ConsumerWidget {
  const SearchResultView({
    super.key,
    required this.city,
    required this.onDelete,
    required this.onSearchAgain,
  });

  final String city;
  final VoidCallback onDelete;
  final VoidCallback onSearchAgain;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final weatherAsync = ref.watch(getWeatherByCityProvider(city));

    return weatherAsync.when(
      loading: () => const FamousCitiesSkeleton(),

      error: (error, stack) => ErrorView(
        message: 'City not found',
        actions: [
          ErrorAction(label: 'Search again', onPressed: onSearchAgain),
          ErrorAction(
            label: 'Delete the search',
            onPressed: onDelete,
            isPrimary: false,
          ),
        ],
      ),

      data: (weather) => InkWell(
        overlayColor: const WidgetStatePropertyAll(Colors.transparent),
        onTap: () {
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (_) => WeatherDetailScreen(cityName: weather.name),
            ),
          );
        },
        // Use the typed city so the cached result is reused (no second request)
        child: FamousCityTile(index: 0, city: city),
      ),
    );
  }
}