import 'package:flutter/material.dart';
import 'package:gofix/core/constants/app_colors.dart';
import 'package:gofix/core/utils/helper.dart';

class RoleOptionCard extends StatelessWidget {
  final String title;
  final String imagePath;
  final bool isSelected;
  final VoidCallback onTap;

  const RoleOptionCard({
    super.key,
    required this.title,
    required this.imagePath,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final dark = Helper.isDarkMode(context);
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(20),
        margin: const EdgeInsets.only(bottom: 15),
        decoration: BoxDecoration(
          color: dark
              ? (isSelected
                    ? AppColors.selectedContainerDark
                    : AppColors.disabledContainer)
              : (isSelected ? AppColors.choosenCard : AppColors.unChoosenCard),
          borderRadius: BorderRadius.circular(12),
          boxShadow: isSelected
              ? [
                  BoxShadow(
                    color: dark
                        ? const Color(0xFF59779C).withOpacity(0.4)
                        : Colors.black.withOpacity(0.4),
                    offset: const Offset(2, 4),
                    blurRadius: 6,
                  ),
                ]
              : [],
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              title,
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: isSelected ? AppColors.light : AppColors.light,
              ),
            ),
            Image.asset(imagePath, height: 70, fit: BoxFit.contain),
          ],
        ),
      ),
    );
  }
}
