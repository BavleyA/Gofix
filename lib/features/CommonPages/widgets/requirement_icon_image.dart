import 'package:flutter/material.dart';
import 'package:gofix/core/constants/app_colors.dart';
import 'package:gofix/core/constants/app_image_strings.dart';
import 'package:gofix/core/utils/helper.dart';

class RequirementImageIcon extends StatelessWidget {
  const RequirementImageIcon({required this.image, super.key});
  final String image;

  @override
  Widget build(BuildContext context) {
    final dark = Helper.isDarkMode(context);

    return Container(
      width: double.infinity,
      color: dark ? AppColors.imageCardDark : AppColors.imageCard,
      padding: const EdgeInsets.symmetric(vertical: 20),
      child: Center(
        child: ClipOval(child: Image.asset(image, width: 230, height: 150)),
      ),
    );
  }
}
