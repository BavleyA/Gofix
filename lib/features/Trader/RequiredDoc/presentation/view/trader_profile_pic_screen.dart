import 'dart:io';
import 'package:flutter/material.dart';
import 'package:gofix/core/constants/app_colors.dart';
import 'package:gofix/core/constants/app_image_strings.dart';
import 'package:gofix/core/constants/app_strings.dart';
import 'package:gofix/core/constants/app_text_style.dart';
import 'package:gofix/core/utils/helper.dart';
import 'package:gofix/features/CommonPages/widgets/done_requirement_button.dart';
import 'package:gofix/features/CommonPages/widgets/profile_image.dart';
import 'package:gofix/features/Trader/RequiredDoc/presentation/widget/trader_upload_image.dart';

class TraderProfilePictureScreen extends StatefulWidget {
  const TraderProfilePictureScreen({super.key});

  @override
  State<TraderProfilePictureScreen> createState() =>
      _TraderProfilePictureScreenState();
}

class _TraderProfilePictureScreenState
    extends State<TraderProfilePictureScreen> {
  File? _imageFile;
  bool _isLoading = false;

  Future<void> _uploadImage(File image) async {
    setState(() => _isLoading = true);
    try {
      await Future.delayed(const Duration(seconds: 2));
      setState(() => _isLoading = false);
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text(AppStrings.success)));
    } catch (e) {
      setState(() => _isLoading = false);
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text(AppStrings.failed)));
    }
  }

  void _showImagePicker() {
    final dark = Helper.isDarkMode(context);

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      useSafeArea: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      backgroundColor: dark ? AppColors.backgroundDark : AppColors.light,
      builder: (_) => TraderImagePickerSheetWidget(
        onImageSelected: (file) {
          setState(() => _imageFile = file);
          _uploadImage(file);
        },
      ),
    );
  }

  void _done() {
    if (_imageFile == null) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text(AppStrings.uploadMsg)));
      return;
    }
    Navigator.pop(context, _imageFile);
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
            ProfileImageWidget(
              imageFile: _imageFile,
              placeholderImage: dark
                  ? AppImageStrings.profileIconDark
                  : AppImageStrings.profileIcon,
            ),
            Padding(
              padding: const EdgeInsets.all(18),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    AppStrings.profilePhoto,
                    style: dark
                        ? AppTextTheme.darkTextTheme.headlineLarge!.copyWith(
                            color: AppColors.headTextDark,
                          )
                        : AppTextTheme.lightTextTheme.headlineLarge,
                  ),
                  const SizedBox(height: 15),

                  Text(
                    AppStrings.pfpRequirements,
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
                    AppStrings.pfpRequirementsRole,
                    style: TextStyle(
                      color: dark
                          ? AppColors.primaryTextDark
                          : AppColors.texthint,
                      fontSize: 14,
                      height: 1.5,
                    ),
                  ),

                  const SizedBox(height: 15),

                  Text(
                    AppStrings.notAccepted,
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
                    AppStrings.notAcceptedRole,
                    style: TextStyle(
                      color: dark
                          ? AppColors.primaryTextDark
                          : AppColors.texthint,
                      fontSize: 14,
                      height: 1.5,
                    ),
                  ),

                  const SizedBox(height: 50),

                  DoneReqButton(
                    text: AppStrings.uploadPhoto,
                    onPressed: _showImagePicker,
                    dark: dark,
                  ),

                  const SizedBox(height: 20),

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
