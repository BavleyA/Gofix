import 'package:flutter/material.dart';
import 'package:gofix/core/constants/app_colors.dart';
import 'package:gofix/core/constants/app_image_strings.dart';
import 'package:gofix/core/constants/app_strings.dart';
import 'package:gofix/core/constants/app_text_style.dart';
import 'package:gofix/core/utils/helper.dart';
import 'package:gofix/features/Trader/RequiredDoc/presentation/widget/requirement_icon_image.dart';

class OnlinePresenceScreen extends StatefulWidget {
  const OnlinePresenceScreen({super.key});

  @override
  State<OnlinePresenceScreen> createState() => _OnlinePresenceScreenState();
}

class _OnlinePresenceScreenState extends State<OnlinePresenceScreen> {
  final _formKey = GlobalKey<FormState>();

  final TextEditingController socialMediaLinksController =
      TextEditingController();
  final TextEditingController WebsiteOnlineStoreLinkController =
      TextEditingController();

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
                  ? AppImageStrings.onlinePresenceIconDark
                  : AppImageStrings.onlinePresenceIcon,
            ),
            Padding(
              padding: const EdgeInsets.all(18.0),
              child: Text(
                AppStrings.onlinePresence,
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
                    // ===== Social Media Links =====
                    TextFormField(
                      controller: socialMediaLinksController,
                      keyboardType: TextInputType.multiline,
                      maxLines: null, 
                      decoration: InputDecoration(
                        labelText: AppStrings.socialMediaLinksHint,
                        prefixIcon: const Icon(
                          Icons.public, 
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

                    // ===== Website page =====
                    TextFormField(
                      controller: WebsiteOnlineStoreLinkController,
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
                            final socialMediaLinks =
                                socialMediaLinksController.text;
                            final WebsiteOnlineStoreLink =
                                WebsiteOnlineStoreLinkController.text;

                            socialMediaLinksController.clear();
                            WebsiteOnlineStoreLinkController.clear();

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
