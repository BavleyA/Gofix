import 'dart:io';
import 'package:flutter/material.dart';
import 'package:gofix/core/constants/app_colors.dart';

class BikeNationalIdUploader extends StatefulWidget {
  final String label;
  final File? imageFile;
  final VoidCallback onTap;
  final bool dark;
  final bool showError; 

  const BikeNationalIdUploader({
    super.key,
    required this.label,
    required this.imageFile,
    required this.onTap,
    required this.dark,
    this.showError = false, 
    
  });

  @override
  State<BikeNationalIdUploader> createState() =>
      _BikeNationalIdUploaderState();
}

class _BikeNationalIdUploaderState extends State<BikeNationalIdUploader> {
  @override
  Widget build(BuildContext context) {
    Color borderColor;


    if (widget.showError && widget.imageFile == null) {
      borderColor = Colors.red;
    } else {
      borderColor = widget.dark
          ? AppColors.selectedContainerDark.withOpacity(0.6)
          : AppColors.choosenCard.withOpacity(0.6);
    }

    return GestureDetector(
      onTap: widget.onTap,
      child: Container(
        width: double.infinity,
        height: 180,
        margin: const EdgeInsets.symmetric(vertical: 8),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: borderColor, width: 2),
          color: widget.dark ? AppColors.imageCardDark : AppColors.docCard,
        ),
        child: widget.imageFile == null
            ? Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.upload_file,
                    color: widget.dark
                        ? AppColors.primaryTextDark
                        : AppColors.primary,
                    size: 40,
                  ),
                  const SizedBox(height: 8),
                  Text(
                    widget.label,
                    style: TextStyle(
                      color: widget.dark
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
                  widget.imageFile!,
                  width: double.infinity,
                  height: 180,
                  fit: BoxFit.cover,
                ),
              ),
      ),
    );
  }
}
