import 'package:flutter/material.dart';
import 'package:weather_application/constants/text_styles.dart';

class SearchHeader extends StatelessWidget {
  const SearchHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text('Pick Location', style: TextStyles.h1),
        const SizedBox(height: 30),
        Text(
          'Find the area or city that you want to know the detailed weather info at the time',
          style: TextStyles.subtitleText,
          textAlign: TextAlign.center,
        ),
      ],
    );
  }
}