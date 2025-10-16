import 'dart:io';
import 'package:flutter/material.dart';
import 'package:gofix/core/constants/app_colors.dart';

class CarVehicleLicenceUploader extends StatelessWidget {
  final String label;
  final File? imageFile;
  final VoidCallback onTap;
  final bool dark;
  final bool isError;

  const CarVehicleLicenceUploader({
    super.key,
    required this.label,
    required this.imageFile,
    required this.onTap,
    required this.dark,
    this.isError = false,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: double.infinity,
        height: 230,
        margin: const EdgeInsets.symmetric(vertical: 8),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16),
          border: Border.all(
            color: isError
                ? Colors.red
                : dark
                ? AppColors.selectedContainerDark.withOpacity(0.6)
                : AppColors.choosenCard.withOpacity(0.6),
            width: isError ? 2 : 1.5,
          ),
          color: dark ? AppColors.imageCardDark : AppColors.docCard,
        ),
        child: imageFile == null
            ? Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.upload_file,
                    color: dark ? AppColors.primaryTextDark : AppColors.primary,
                    size: 40,
                  ),
                  const SizedBox(height: 8),
                  Text(
                    label,
                    style: TextStyle(
                      color: dark
                          ? AppColors.primaryTextDark
                          : AppColors.primary,
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              )
            : ClipRRect(
                borderRadius: BorderRadius.circular(16),
                child: Image.file(
                  imageFile!,
                  width: double.infinity,
                  height: 180,
                  fit: BoxFit.cover,
                ),
              ),
      ),
    );
  }
}
