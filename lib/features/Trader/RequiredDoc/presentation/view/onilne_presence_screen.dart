import 'package:flutter/material.dart';
import 'package:gofix/core/constants/app_colors.dart';
import 'package:gofix/core/constants/app_image_strings.dart';
import 'package:gofix/core/constants/app_strings.dart';
import 'package:gofix/core/constants/app_text_style.dart';
import 'package:gofix/core/utils/helper.dart';
import 'package:gofix/features/CommonPages/widgets/requirement_icon_image.dart';
import 'package:gofix/features/Trader/RequiredDoc/presentation/widget/business_input_field.dart';

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
                    // ===== Website page =====
                    BuisenessReusableTextField(
                      controller: socialMediaLinksController,
                      labelText: AppStrings.socialMediaLinksHint,
                      prefixIcon: Icons.link,
                      dark: dark,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return AppStrings.requiredFieldBussiness;
                        }
                        return null;
                      },
                      keyboardType: TextInputType.multiline,
                    ),

                    const SizedBox(height: 16),

                    BuisenessReusableTextField(
                      controller: WebsiteOnlineStoreLinkController,
                      labelText: AppStrings.websiteOnlineStoreLink,
                      prefixIcon: Icons.language,
                      dark: dark,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return AppStrings.requiredFieldBussiness;
                        }
                        return null;
                      },
                      keyboardType: TextInputType.url,
                    ),

                    const SizedBox(height: 60),

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
