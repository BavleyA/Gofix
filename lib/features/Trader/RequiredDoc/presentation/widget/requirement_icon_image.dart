
import 'package:flutter/material.dart';
import 'package:gofix/core/constants/app_colors.dart';
import 'package:gofix/core/constants/app_image_strings.dart';

class RequirementImageIcon extends StatelessWidget {
  const RequirementImageIcon({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      color: AppColors.imageCard,
      padding: const EdgeInsets.symmetric(vertical: 20),
      child: Center(
        child: ClipOval(
          child: Image.asset(
            AppImageStrings.nationalIdIcon,
            width: 230,
            height: 150,
          ),
        ),
      ),
    );
  }
}
