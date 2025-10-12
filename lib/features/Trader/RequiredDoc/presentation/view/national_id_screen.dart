import 'dart:io';
import 'package:flutter/material.dart';
import 'package:gofix/core/constants/app_colors.dart';
import 'package:gofix/core/constants/app_image_strings.dart';
import 'package:gofix/core/constants/app_strings.dart';
import 'package:gofix/core/constants/app_text_style.dart';
import 'package:gofix/core/utils/helper.dart';
import 'package:gofix/features/Trader/RequiredDoc/presentation/widget/done_requirement_button.dart';
import 'package:gofix/features/Trader/RequiredDoc/presentation/widget/requirement_icon_image.dart';
import 'package:gofix/features/Trader/RequiredDoc/presentation/widget/upload_image.dart';

class NationalIdScreen extends StatefulWidget {
  const NationalIdScreen({super.key});

  @override
  State<NationalIdScreen> createState() => _NationalIdScreenState();
}

class _NationalIdScreenState extends State<NationalIdScreen> {
  File? _frontImage;
  File? _backImage;
  bool _isLoading = false;

  Future<void> _uploadImage(File image) async {
    setState(() => _isLoading = true);
    try {
      await Future.delayed(const Duration(seconds: 1));
      setState(() => _isLoading = false);
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text(AppStrings.success)));
    } catch (e) {
      setState(() => _isLoading = false);
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text(AppStrings.failed)));
    }
  }

  void _showImagePickerSheet(bool isFront) {
    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
      ),
      builder: (context) => ImagePickerSheetWidget(
        onImageSelected: (File image) {
          setState(() {
            if (isFront) {
              _frontImage = image;
            } else {
              _backImage = image;
            }
          });
          _uploadImage(image);
        },
      ),
    );
  }

  void _done() {
    if (_frontImage == null || _backImage == null) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text(AppStrings.uploadMsg)));
      return;
    }
    Navigator.pop(context, {'front': _frontImage, 'back': _backImage});
  }

  @override
  Widget build(BuildContext context) {
    final dark = Helper.isDarkMode(context);

    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(backgroundColor: AppColors.imageCard),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            RequirementImageIcon(),

            Padding(
              padding: const EdgeInsets.all(18),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    AppStrings.nationalID,
                    style: dark
                        ? AppTextTheme.darkTextTheme.headlineLarge!.copyWith(
                            color: AppColors.secondaryBlack,
                          )
                        : AppTextTheme.lightTextTheme.headlineLarge,
                  ),
                  const SizedBox(height: 15),
                  Text(
                    AppStrings.nationalIDReq,
                    style: AppTextTheme.lightTextTheme.bodyLarge!.copyWith(
                      fontWeight: FontWeight.bold,
                      decoration: TextDecoration.underline,
                      color: AppColors.texthint,
                    ),
                  ),
                  const SizedBox(height: 4),
                  const Text(
                    AppStrings.nationalIDRole,
                    style: TextStyle(
                      color: AppColors.texthint,
                      fontSize: 14,
                      height: 1.5,
                    ),
                  ),
                  const SizedBox(height: 20),

                  // ===== FRONT IMAGE =====
                  _buildImageContainer(
                    label: "Front ID",
                    imageFile: _frontImage,
                    onTap: () => _showImagePickerSheet(true),
                  ),

                  // ===== BACK IMAGE =====
                  _buildImageContainer(
                    label: "Back ID",
                    imageFile: _backImage,
                    onTap: () => _showImagePickerSheet(false),
                  ),

                  const SizedBox(height: 40),

                  DoneReqButton(
                    text: AppStrings.done,
                    onPressed: _done,
                    dark: dark,
                  ),

                  if (_isLoading)
                    const Padding(
                      padding: EdgeInsets.only(top: 16),
                      child: Center(
                        child: CircularProgressIndicator(
                          color: AppColors.primary,
                        ),
                      ),
                    ),
                  const SizedBox(height: 90),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  // ===== Container يعرض الصورة أو الزر للرفع =====
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
          border: Border.all(
            color: AppColors.selectedContainer.withOpacity(0.6),
          ),
          color: AppColors.docCard,
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
}
