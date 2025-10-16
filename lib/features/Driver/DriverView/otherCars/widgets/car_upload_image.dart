import 'dart:io';
import 'package:flutter/material.dart';
import 'package:gofix/core/utils/helper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:gofix/core/constants/app_colors.dart';
import 'package:gofix/core/constants/app_strings.dart';

class CarImagePickerSheetWidget extends StatelessWidget {
  final void Function(File) onImageSelected;

  const CarImagePickerSheetWidget({super.key, required this.onImageSelected});

  Future<void> _pickImage(BuildContext context, ImageSource source) async {
    final ImagePicker picker = ImagePicker();
    final XFile? pickedFile = await picker.pickImage(
      source: source,
      imageQuality: 80,
    );

    if (pickedFile != null) {
      final file = File(pickedFile.path);
      onImageSelected(file);
      Navigator.pop(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    final dark = Helper.isDarkMode(context);

    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Wrap(
          children: [
            ListTile(
              leading: const Icon(Icons.camera_alt, color: AppColors.primary),
              title: Text(
                AppStrings.takePhoto,
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                  color: dark ? AppColors.light : AppColors.dark,
                ),
              ),
              onTap: () => _pickImage(context, ImageSource.camera),
            ),
            ListTile(
              leading: const Icon(
                Icons.photo_library,
                color: AppColors.primary,
              ),
              title: Text(
                AppStrings.chooseFromGallery,
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                  color: dark ? AppColors.light : AppColors.dark,
                ),
              ),
              onTap: () => _pickImage(context, ImageSource.gallery),
            ),
          ],
        ),
      ),
    );
  }
}
