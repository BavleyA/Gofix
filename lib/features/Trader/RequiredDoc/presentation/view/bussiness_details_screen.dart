import 'package:flutter/material.dart';
import 'package:gofix/core/constants/app_colors.dart';
import 'package:gofix/core/constants/app_image_strings.dart';
import 'package:gofix/core/constants/app_strings.dart';
import 'package:gofix/core/constants/app_text_style.dart';
import 'package:gofix/core/utils/helper.dart';
import 'package:gofix/features/CommonPages/widgets/requirement_icon_image.dart';
import 'package:gofix/features/Trader/RequiredDoc/presentation/widget/business_input_field.dart';

class BussinessDetailsScreen extends StatefulWidget {
  const BussinessDetailsScreen({super.key});

  @override
  State<BussinessDetailsScreen> createState() => _BussinessDetailsScreenState();
}

class _BussinessDetailsScreenState extends State<BussinessDetailsScreen> {
  final _formKey = GlobalKey<FormState>();

  final TextEditingController emailController = TextEditingController();
  final TextEditingController nameController = TextEditingController();
  final TextEditingController categoryController = TextEditingController();
  final TextEditingController addressController = TextEditingController();

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
                  ? AppImageStrings.businessDetailsIconDark
                  : AppImageStrings.businessDetailsIcon,
            ),
            Padding(
              padding: const EdgeInsets.all(18.0),
              child: Text(
                AppStrings.businessDetails,
                style: dark
                    ? AppTextTheme.darkTextTheme.headlineLarge!.copyWith(
                        color: AppColors.headTextDark,
                      )
                    : AppTextTheme.lightTextTheme.headlineLarge,
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 18.0),
              child: Form(
                key: _formKey,
                child: Column(
                  children: [
                    BuisenessReusableTextField(
                      controller: emailController,
                      labelText: AppStrings.emailHint,
                      prefixIcon: Icons.email,
                      keyboardType: TextInputType.emailAddress,
                      dark: dark,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return AppStrings.requiredFieldEmail;
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 16),

                    BuisenessReusableTextField(
                      controller: nameController,
                      labelText: AppStrings.businessNameHint,
                      prefixIcon: Icons.business,
                      dark: dark,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return AppStrings.requiredFieldBussiness;
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 16),

                    BuisenessReusableTextField(
                      controller: categoryController,
                      labelText: AppStrings.businessCategoryHint,
                      prefixIcon: Icons.category,
                      dark: dark,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return AppStrings.requiredFieldCategory;
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 16),

                    BuisenessReusableTextField(
                      controller: addressController,
                      labelText: AppStrings.businessAddressHint,
                      prefixIcon: Icons.location_on,
                      dark: dark,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return AppStrings.requiredFieldAddress;
                        }
                        return null;
                      },
                    ),

                    const SizedBox(height: 30),

                    // ===== Submit Button =====
                    SizedBox(
                      width: double.infinity,
                      height: 50,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: dark
                              ? AppColors.mainButton
                              : AppColors.primary,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                        ),
                        onPressed: () {
                          if (_formKey.currentState!.validate()) {
                            final email = emailController.text;
                            final name = nameController.text;
                            final category = categoryController.text;
                            final address = addressController.text;

                            emailController.clear();
                            nameController.clear();
                            categoryController.clear();
                            addressController.clear();

                            Navigator.pop(context, true);
                          }
                        },
                        child: Text(
                          AppStrings.done,
                          style: dark
                              ? AppTextTheme.darkTextTheme.displaySmall!
                                    .copyWith(color: AppColors.imageCard)
                              : AppTextTheme.lightTextTheme.displaySmall!
                                    .copyWith(color: AppColors.light),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
