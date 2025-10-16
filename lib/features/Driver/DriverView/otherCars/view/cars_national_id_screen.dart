import 'dart:io';
import 'package:flutter/material.dart';
import 'package:gofix/core/constants/app_colors.dart';
import 'package:gofix/core/constants/app_image_strings.dart';
import 'package:gofix/core/constants/app_strings.dart';
import 'package:gofix/core/constants/app_text_style.dart';
import 'package:gofix/core/utils/helper.dart';
import 'package:gofix/features/CommonPages/widgets/done_requirement_button.dart';
import 'package:gofix/features/CommonPages/widgets/requirement_icon_image.dart';
import 'package:gofix/features/Trader/RequiredDoc/presentation/widget/trader_national_id_uplader.dart';
import 'package:gofix/features/Trader/RequiredDoc/presentation/widget/trader_upload_image.dart';

class CarsNationalIDScreen extends StatefulWidget {
  const CarsNationalIDScreen({super.key});

  @override
  State<CarsNationalIDScreen> createState() => _CarsNationalIDScreenState();
}

class _CarsNationalIDScreenState extends State<CarsNationalIDScreen> {
  File? _frontImage;
  File? _backImage;
  bool _isLoading = false;
  bool showError = false;

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
      builder: (context) => TraderImagePickerSheetWidget(
        onImageSelected: (File image) {
          setState(() {
            if (isFront) {
              _frontImage = image;
            } else {
              _backImage = image;
            }
            showError = false;
          });
          _uploadImage(image);
        },
      ),
    );
  }

  void _done() {
    if (_frontImage == null || _backImage == null) {
      setState(() => showError = true);
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
      backgroundColor: dark ? AppColors.backgroundDark : AppColors.background,
      appBar: AppBar(
        backgroundColor: dark ? AppColors.imageCardDark : AppColors.imageCard,
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            RequirementImageIcon(
              image: dark
                  ? AppImageStrings.nationalIdIconDark
                  : AppImageStrings.nationalIdIcon,
            ),
            Padding(
              padding: const EdgeInsets.all(18),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    AppStrings.nationalID,
                    style: dark
                        ? AppTextTheme.darkTextTheme.headlineLarge!.copyWith(
                            color: AppColors.headTextDark,
                          )
                        : AppTextTheme.lightTextTheme.headlineLarge,
                  ),
                  const SizedBox(height: 15),
                  Text(
                    AppStrings.requirementTitle,
                    style: dark
                        ? AppTextTheme.darkTextTheme.bodyLarge!.copyWith(
                            fontWeight: FontWeight.bold,
                            decoration: TextDecoration.underline,
                            color: AppColors.primaryTextDark,
                          )
                        : AppTextTheme.lightTextTheme.bodyLarge!.copyWith(
                            fontWeight: FontWeight.bold,
                            decoration: TextDecoration.underline,
                            color: AppColors.texthint,
                          ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    AppStrings.nationalIDRole,
                    style: TextStyle(
                      color: dark
                          ? AppColors.primaryTextDark
                          : AppColors.texthint,
                      fontSize: 14,
                      height: 1.5,
                    ),
                  ),
                  const SizedBox(height: 20),

                  // ===== Front ID =====
                  TraderNationalIdUploader(
                    label: "Front ID",
                    imageFile: _frontImage,
                    onTap: () => _showImagePickerSheet(true),
                    dark: dark,
                    showError: showError,
                  ),

                  // ===== Back ID =====
                  TraderNationalIdUploader(
                    label: "Back ID",
                    imageFile: _backImage,
                    onTap: () => _showImagePickerSheet(false),
                    dark: dark,
                    showError: showError,
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
}
