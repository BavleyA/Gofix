import 'dart:io';
import 'package:flutter/material.dart';
import 'package:gofix/core/constants/app_colors.dart';
import 'package:gofix/core/constants/app_image_strings.dart';
import 'package:gofix/core/utils/helper.dart';

class ProfileImageWidget extends StatelessWidget {
  final File? imageFile;
  final double size;
  final String placeholderImage;

  const ProfileImageWidget({
    super.key,
    this.imageFile,
    this.size = 150,
    required this.placeholderImage,
  });

  @override
  Widget build(BuildContext context) {
    final dark = Helper.isDarkMode(context);

    return Container(
      width: double.infinity,
      color: dark ? AppColors.imageCardDark : AppColors.imageCard,
      padding: const EdgeInsets.symmetric(vertical: 20),
      child: Center(
        child: ClipOval(
          child: imageFile != null
              ? Image.file(
                  imageFile!,
                  width: size,
                  height: size,
                  fit: BoxFit.cover,
                )
              : Image.asset(
                  placeholderImage,
                  width: size,
                  height: size,
                  fit: BoxFit.cover,
                ),
        ),
      ),
    );
  }
}
