import 'dart:io';
import 'package:flutter/material.dart';
import 'package:gofix/core/constants/app_colors.dart';
import 'package:gofix/core/constants/app_image_strings.dart';
import 'package:gofix/core/constants/app_strings.dart';
import 'package:gofix/core/constants/app_text_style.dart';
import 'package:gofix/core/utils/helper.dart';
import 'package:gofix/features/CommonPages/widgets/done_requirement_button.dart';
import 'package:gofix/features/Driver/DriverView/bike/widget/bike_criminal_record_uploader.dart';
import 'package:gofix/features/CommonPages/widgets/requirement_icon_image.dart';
import 'package:gofix/features/Driver/DriverView/bike/widget/bike_upload_image.dart';

class BikeCriminalRecordScreen extends StatefulWidget {
  const BikeCriminalRecordScreen({super.key});

  @override
  State<BikeCriminalRecordScreen> createState() =>
      _BikeCriminalRecordScreenState();
}

class _BikeCriminalRecordScreenState extends State<BikeCriminalRecordScreen> {
  File? _criminalRecordImage;
  bool _isLoading = false;
  bool _isImageMissing = false;

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

  void _showImagePickerSheet() {
    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
      ),
      builder: (context) => BikeImagePickerSheetWidget(
        onImageSelected: (File image) {
          setState(() {
            _criminalRecordImage = image;
            _isImageMissing = false;
          });
          _uploadImage(image);
        },
      ),
    );
  }

  void _done() {
    if (_criminalRecordImage == null) {
      setState(() {
        _isImageMissing = true;
      });
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text(AppStrings.uploadMsg)));
      return;
    }

    setState(() {
      _isImageMissing = false;
    });

    Navigator.pop(context, {'image': _criminalRecordImage});
    // Navigator.pop(context, true);
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
                  ? AppImageStrings.criminalRecordCertificateIconDark
                  : AppImageStrings.criminalRecordCertificateIcon,
            ),
            Padding(
              padding: const EdgeInsets.all(18),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    AppStrings.criminalRecordCertificate,
                    style: dark
                        ? AppTextTheme.darkTextTheme.headlineLarge!.copyWith(
                            color: AppColors.headTextDark,
                          )
                        : AppTextTheme.lightTextTheme.headlineLarge,
                  ),
                  const SizedBox(height: 15),
                  Text(
                    AppStrings.criminalRecordCertificateReq,
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
                    AppStrings.criminalRecordCertificateRole,
                    style: dark
                        ? AppTextTheme.darkTextTheme.bodyLarge!.copyWith(
                            fontWeight: FontWeight.bold,
                            color: AppColors.primaryTextDark,
                          )
                        : AppTextTheme.lightTextTheme.bodyLarge!.copyWith(
                            fontWeight: FontWeight.bold,
                            color: AppColors.texthint,
                          ),
                  ),
                  const SizedBox(height: 20),

                  // ===== Criminal Record Image =====
                  CarsCriminalRecordUploader(
                    label: "Upload Criminal Record",
                    imageFile: _criminalRecordImage,
                    onTap: _showImagePickerSheet,
                    dark: dark,
                    isError: _isImageMissing,
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
