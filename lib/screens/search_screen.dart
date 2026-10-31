import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:weather_application/constants/app_colors.dart';
import 'package:weather_application/providers/get_weather_by_city_provider.dart';
import 'package:weather_application/views/famous_cities_view.dart';
import 'package:weather_application/views/gradient_container.dart';
import 'package:weather_application/views/search_result_view.dart';
import 'package:weather_application/widgets/round_text_field.dart';
import 'package:weather_application/widgets/search_header.dart';

class SearchScreen extends ConsumerStatefulWidget {
  const SearchScreen({super.key});

  @override
  ConsumerState<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends ConsumerState<SearchScreen> {
  final _controller = TextEditingController();
  final _focusNode = FocusNode();
  String _searchedCity = '';

  @override
  void initState() {
    super.initState();
    _controller.addListener(_onTextChanged);
  }

  @override
  void dispose() {
    _controller.dispose();
    _focusNode.dispose();
    super.dispose();
  }

  void _onTextChanged() {
    if (_controller.text.trim().isEmpty && _searchedCity.isNotEmpty) {
      setState(() => _searchedCity = '');
    }
  }

  void _search(String value) {
    FocusScope.of(context).unfocus();
    final city = value.trim();
    if (city.isEmpty) return;

    // Same city again = force a fresh request
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
          const SearchHeader(),
          const SizedBox(height: 40),
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
            child: _searchedCity.isEmpty
                ? FamouseCitiesView()
                : SearchResultView(
                    city: _searchedCity,
                    onDelete: _deleteSearch,
                    onSearchAgain: _searchAgain,
                  ),
          ),
        ],
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
