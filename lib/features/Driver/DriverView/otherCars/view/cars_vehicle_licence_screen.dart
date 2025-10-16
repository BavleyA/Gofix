import 'dart:io';
import 'package:flutter/material.dart';
import 'package:gofix/core/constants/app_colors.dart';
import 'package:gofix/core/constants/app_image_strings.dart';
import 'package:gofix/core/constants/app_strings.dart';
import 'package:gofix/core/constants/app_text_style.dart';
import 'package:gofix/core/utils/helper.dart';
import 'package:gofix/features/CommonPages/widgets/done_requirement_button.dart';
import 'package:gofix/features/CommonPages/widgets/requirement_icon_image.dart';
import 'package:gofix/features/Driver/DriverView/otherCars/widgets/car_upload_image.dart';
import 'package:gofix/features/Driver/DriverView/otherCars/widgets/car_vehicle_licence_uploader.dart';

class CarsVehicleLicenceScreen extends StatefulWidget {
  const CarsVehicleLicenceScreen({super.key});

  @override
  State<CarsVehicleLicenceScreen> createState() =>
      _CarsVehicleLicenceScreenState();
}

class _CarsVehicleLicenceScreenState extends State<CarsVehicleLicenceScreen> {
  File? _frontImage;
  File? _backImage;
  bool _isLoading = false;

  bool _frontError = false;
  bool _backError = false;

  bool get _allImagesCompleted => _frontImage != null && _backImage != null;

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
      builder: (context) => CarImagePickerSheetWidget(
        onImageSelected: (File image) {
          setState(() {
            if (isFront) {
              _frontImage = image;
              _frontError = false;
            } else {
              _backImage = image;
              _backError = false;
            }
          });
          _uploadImage(image);
        },
      ),
    );
  }

  void _done() {
    setState(() {
      _frontError = _frontImage == null;
      _backError = _backImage == null;
    });

    if (!_allImagesCompleted) {
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
                  ? AppImageStrings.vehicleLicenseIconDark
                  : AppImageStrings.vehicleLicenseIcon,
            ),
            Padding(
              padding: const EdgeInsets.all(18),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    AppStrings.vehicleLicense,
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
                    AppStrings.vehicleRequirementsRole,
                    style: TextStyle(
                      color: dark
                          ? AppColors.primaryTextDark
                          : AppColors.texthint,
                      fontSize: 14,
                      height: 1.5,
                    ),
                  ),
                  const SizedBox(height: 20),

                  // ===== Front Licence =====
                  CarVehicleLicenceUploader(
                    label: "Front Licence",
                    imageFile: _frontImage,
                    onTap: () => _showImagePickerSheet(true),
                    dark: dark,
                    isError: _frontError,
                  ),

                  // ===== Back Licence =====
                  CarVehicleLicenceUploader(
                    label: "Back Licence",
                    imageFile: _backImage,
                    onTap: () => _showImagePickerSheet(false),
                    dark: dark,
                    isError: _backError,
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
