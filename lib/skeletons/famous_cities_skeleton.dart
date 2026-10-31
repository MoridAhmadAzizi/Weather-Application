import 'package:flutter/material.dart';
import 'package:skeletonizer/skeletonizer.dart';
import 'package:weather_application/constants/app_colors.dart';
import 'package:weather_application/constants/text_styles.dart';

class FamousCitiesSkeleton extends StatelessWidget {
  const FamousCitiesSkeleton({super.key});

  @override
  Widget build(BuildContext context) {
    return Skeletonizer(
      effect: const ShimmerEffect(
        baseColor: AppColors.skeletonHighlight,
        highlightColor: AppColors.lightBlue,
      ),
      child: Material(
        color: AppColors.accentBlue,
        borderRadius: BorderRadius.circular(10),
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
                        Text('20\u00B0', style: TextStyles.h2),
                        const SizedBox(height: 10),
                        Text('clear sky', style: TextStyles.subtitleText),
                      ],
                    ),
                  ),
                  const Bone.circle(size: 50),
                ],
              ),
              const Text(
                'City name',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: AppColors.white,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}