import 'dart:io';
import 'package:flutter/material.dart';
import 'package:gofix/features/Trader/RequiredDoc/presentation/widget/upload_image.dart';
import 'package:image_picker/image_picker.dart';
import 'package:gofix/core/constants/app_colors.dart';
import 'package:gofix/core/constants/app_strings.dart';

class NationalIdUploader extends StatefulWidget {
  const NationalIdUploader({super.key});

  @override
  State<NationalIdUploader> createState() => _NationalIdUploaderState();
}

class _NationalIdUploaderState extends State<NationalIdUploader> {
  File? frontImage;
  File? backImage;

  void _pickImage(Function(File) onImageSelected) {
    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) => ImagePickerSheetWidget(
        onImageSelected: (file) {
          onImageSelected(file);
          setState(() {});
        },
      ),
    );
  }

  Widget _buildImageContainer({
    required String label,
    required File? imageFile,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: double.infinity,
        height: 180,
        margin: const EdgeInsets.symmetric(vertical: 8),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: AppColors.primary.withOpacity(0.6)),
          color: AppColors.light,
        ),
        child: imageFile == null
            ? Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(
                    Icons.upload_file,
                    color: AppColors.primary,
                    size: 40,
                  ),
                  const SizedBox(height: 8),
                  Text(
                    label,
                    style: const TextStyle(
                      color: AppColors.primary,
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              )
            : ClipRRect(
                borderRadius: BorderRadius.circular(16),
                child: Image.file(
                  imageFile,
                  width: double.infinity,
                  height: 180,
                  fit: BoxFit.cover,
                ),
              ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        _buildImageContainer(
          label: "Upload Front ID",
          imageFile: frontImage,
          onTap: () => _pickImage((file) => frontImage = file),
        ),
        _buildImageContainer(
          label: "Upload Back ID",
          imageFile: backImage,
          onTap: () => _pickImage((file) => backImage = file),
        ),
      ],
    );
  }
}
