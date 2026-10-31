import 'package:flutter/material.dart';
import 'package:weather_application/constants/app_colors.dart';

class NavBarItem extends StatelessWidget {
  const NavBarItem({
    super.key,
    required this.icon,
    required this.selectedIcon,
    required this.isSelected,
    required this.onTap,
  });

  final IconData icon;
  final IconData selectedIcon;
  final bool isSelected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      behavior: HitTestBehavior.opaque,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 250),
        curve: Curves.easeOut,
        width: isSelected ? 72 : 56,
        height: 44,
        decoration: BoxDecoration(
          color: isSelected ? AppColors.lightBlue : Colors.transparent,
          borderRadius: BorderRadius.circular(22),
        ),
        child: Icon(
          isSelected ? selectedIcon : icon,
          color: AppColors.white,
        ),
      ),
    );
  }
}