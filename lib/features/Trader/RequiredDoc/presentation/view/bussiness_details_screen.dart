import 'package:flutter/material.dart';
import 'package:gofix/core/constants/app_colors.dart';
import 'package:gofix/core/constants/app_image_strings.dart';
import 'package:gofix/core/constants/app_strings.dart';
import 'package:gofix/core/constants/app_text_style.dart';
import 'package:gofix/core/utils/helper.dart';
import 'package:gofix/features/Trader/RequiredDoc/presentation/widget/requirement_icon_image.dart';

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
                    ? AppTextTheme.darkTextTheme.headlineLarge
                    : AppTextTheme.lightTextTheme.headlineLarge,
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 18.0),
              child: Form(
                key: _formKey,
                child: Column(
                  children: [
                    // ===== Email =====
                    TextFormField(
                      controller: emailController,
                      keyboardType: TextInputType.emailAddress,
                      decoration: InputDecoration(
                        labelText: AppStrings.emailHint,
                        prefixIcon: Icon(
                          Icons.email,
                          color: AppColors.mainButton,
                        ),
                        filled: true,
                        fillColor: dark
                            ? AppColors.textFieldBackgroundDark
                            : AppColors.light,
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                          borderSide: BorderSide(
                            color: dark ? Colors.grey[600]! : Colors.grey,
                          ),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                          borderSide: BorderSide(
                            color: AppColors.mainButton,
                            width: 2,
                          ),
                        ),
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return AppStrings.requiredFieldEmail;
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 16),

                    // ===== Business Name =====
                    TextFormField(
                      controller: nameController,
                      decoration: InputDecoration(
                        labelText: AppStrings.businessNameHint,
                        prefixIcon: const Icon(
                          Icons.business,
                          color: AppColors.mainButton,
                        ),
                        filled: true,
                        fillColor: dark
                            ? AppColors.textFieldBackgroundDark
                            : AppColors.light,
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                          borderSide: BorderSide(
                            color: dark ? Colors.grey[600]! : Colors.grey,
                          ),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                          borderSide: BorderSide(
                            color: AppColors.mainButton,
                            width: 2,
                          ),
                        ),
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return AppStrings.requiredFieldBussiness;
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 16),

                    // ===== Category =====
                    TextFormField(
                      controller: categoryController,
                      decoration: InputDecoration(
                        labelText: AppStrings.businessCategoryHint,
                        prefixIcon: const Icon(
                          Icons.category,
                          color: AppColors.mainButton,
                        ),
                        filled: true,
                        fillColor: dark
                            ? AppColors.textFieldBackgroundDark
                            : AppColors.light,
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                          borderSide: BorderSide(
                            color: dark ? Colors.grey[600]! : Colors.grey,
                          ),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                          borderSide: BorderSide(
                            color: AppColors.mainButton,
                            width: 2,
                          ),
                        ),
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return AppStrings.requiredFieldCategory;
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 16),

                    // ===== Address =====
                    TextFormField(
                      controller: addressController,
                      decoration: InputDecoration(
                        labelText: AppStrings.businessAddressHint,
                        prefixIcon: const Icon(
                          Icons.location_on,
                          color: AppColors.mainButton,
                        ),
                        filled: true,
                        fillColor: dark
                            ? AppColors.textFieldBackgroundDark
                            : AppColors.light,
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                          borderSide: BorderSide(
                            color: dark ? Colors.grey[600]! : Colors.grey,
                          ),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                          borderSide: BorderSide(
                            color: AppColors.mainButton,
                            width: 2,
                          ),
                        ),
                      ),
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

                            // امسحي الداتا بعد الحفظ
                            emailController.clear();
                            nameController.clear();
                            categoryController.clear();
                            addressController.clear();

                            // ✅ نرجع true علشان الصفحة اللي قبلها تعرف إن الخطوة خلصت
                            Navigator.pop(context, true);
                          }
                        },
                        child: Text(
                          AppStrings.done,
                          style: dark
                              ? AppTextTheme.darkTextTheme.displaySmall
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
