import 'package:flutter/material.dart';
import 'package:gofix/core/constants/app_colors.dart';

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
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(20),
        margin: const EdgeInsets.only(bottom: 15),
        decoration: BoxDecoration(
          color: isSelected ? AppColors.choosenCard : AppColors.unChoosenCard,
          borderRadius: BorderRadius.circular(12),
          boxShadow: isSelected
              ? [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.4),
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
                color: isSelected ? AppColors.light : AppColors.dark,
              ),
            ),
            Image.asset(imagePath, height: 70, fit: BoxFit.contain),
          ],
        ),
      ),
    );
  }
}
