import 'package:flutter/material.dart';
import 'package:weather_application/models/famous_city.dart';
import 'package:weather_application/screens/weather_detail_screen.dart';
import 'package:weather_application/widgets/famous_city_tile.dart';

class FamouseCitiesView extends StatelessWidget {
  const FamouseCitiesView({super.key});

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        crossAxisSpacing: 20,
        mainAxisSpacing: 20,
      ),
      itemCount: famousCities.length,
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemBuilder: (context, index) {
        final city = famousCities[index];

        return InkWell(
          overlayColor: WidgetStatePropertyAll(Colors.transparent),
          onTap: () {
            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (_) => WeatherDetailScreen(cityName: city.name),
              ),
            );
          },
          child: FamousCityTile(index: index, city: city.name),
        );
      },
    );
  }
}
