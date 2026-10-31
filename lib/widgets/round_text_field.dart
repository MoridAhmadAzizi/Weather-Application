import 'package:flutter/material.dart';
import 'package:weather_application/constants/app_colors.dart';

class RoundTextField extends StatelessWidget {
  const RoundTextField({super.key, required this.controller});

  final TextEditingController controller;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 55,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: AppColors.accentBlue,
      ),
      child: TextField(
        controller: controller,
        style: TextStyle(color: AppColors.white),
        decoration: InputDecoration(
          border: InputBorder.none,
          contentPadding: EdgeInsets.only(left: 20, top: 10),
          fillColor: AppColors.white,
          focusColor: AppColors.white,
          hintText: 'Search',
          hintStyle: TextStyle(
            color: AppColors.grey,
            fontWeight: FontWeight.w400,
          ),
        ),
      ),
    );
  }
}
