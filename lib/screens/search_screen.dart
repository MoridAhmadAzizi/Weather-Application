import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:weather_application/constants/app_colors.dart';
import 'package:weather_application/constants/text_styles.dart';
import 'package:weather_application/providers/get_weather_by_city_provider.dart';
import 'package:weather_application/screens/weather_detail_screen.dart';
import 'package:weather_application/views/famous_cities_view.dart';
import 'package:weather_application/views/gradient_container.dart';
import 'package:weather_application/widgets/famous_city_tile.dart';
import 'package:weather_application/widgets/round_text_field.dart';

class SearchScreen extends ConsumerStatefulWidget {
  const SearchScreen({super.key});

  @override
  ConsumerState<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends ConsumerState<SearchScreen> {
  late final TextEditingController _controller;
  final FocusNode _focusNode = FocusNode();
  String _searchedCity = '';

  @override
  void initState() {
    _controller = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    _focusNode.dispose();
    super.dispose();
  }

  void _search(String value) {
    FocusScope.of(context).unfocus();
    final city = value.trim();
    if (city.isEmpty) return;

    if (city == _searchedCity) {
      ref.invalidate(getWeatherByCityProvider(city));
    }
    setState(() => _searchedCity = city);
  }

  void _deleteSearch() {
    _controller.clear();
    setState(() => _searchedCity = '');
  }

  void _searchAgain() {
    _focusNode.requestFocus();
    // select all text so the user can type over it
    _controller.selection = TextSelection(
      baseOffset: 0,
      extentOffset: _controller.text.length,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GradientContainer(
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text('Pick Location', style: TextStyles.h1),
              SizedBox(height: 30),
              Text(
                'Find the area or city that you want to know the detailed weather info at the time',
                style: TextStyles.subtitleText,
                textAlign: TextAlign.center,
              ),
            ],
          ),
          SizedBox(height: 40),
          Row(
            children: [
              Expanded(
                child: RoundTextField(
                  controller: _controller,
                  focusNode: _focusNode,
                  onSubmitted: _search,
                ),
              ),
              const SizedBox(width: 15),
              LocationIcon(onTap: () => _search(_controller.text)),
            ],
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 30),
            child: _buildResult(),
          ),
        ],
      ),
    );
  }

  Widget _buildResult() {
    if (_searchedCity.isEmpty) return FamouseCitiesView();
    final weatherAsync = ref.watch(getWeatherByCityProvider(_searchedCity));

    return weatherAsync.when(
      loading: () => const Center(child: CircularProgressIndicator()),
      error: (error, stack) => Column(
        children: [
          Text('City not Found', style: TextStyles.h1),
          const SizedBox(height: 20),
          ElevatedButton(
            onPressed: _deleteSearch,
            child: const Text('Delete the search'),
          ),
          const SizedBox(height: 10),
          ElevatedButton(
            onPressed: _searchAgain,
            child: const Text('Search again'),
          ),
        ],
      ),

      data: (weather) => InkWell(
        overlayColor: WidgetStatePropertyAll(Colors.transparent),
        onTap: () {
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (_) => WeatherDetailScreen(cityName: weather.name),
            ),
          );
        },
        child: FamousCityTile(index: 0, city: weather.name),
      ),
    );
  }
}

class LocationIcon extends StatelessWidget {
  const LocationIcon({super.key, required this.onTap});

  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      overlayColor: WidgetStatePropertyAll(Colors.transparent),
      onTap: onTap,
      child: Container(
        height: 55,
        width: 55,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: AppColors.accentBlue,
        ),
        child: Icon(Icons.search, color: AppColors.white),
      ),
    );
  }
}
