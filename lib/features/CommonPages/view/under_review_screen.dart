import 'package:flutter/material.dart';
import 'package:gofix/core/constants/app_colors.dart';
import 'package:gofix/core/constants/app_image_strings.dart';
import 'package:gofix/core/constants/app_strings.dart';
import 'package:gofix/core/constants/app_text_style.dart';
import 'package:gofix/core/utils/helper.dart';

class UnderReviewScreen extends StatelessWidget {
  const UnderReviewScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final bool dark = Helper.isDarkMode(context);

    return Scaffold(
      appBar: AppBar(),
      backgroundColor: dark ? AppColors.backgroundDark : AppColors.background,
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(18.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(
                width: 250,
                height: 250,
                child: Image.asset(AppImageStrings.successRegistration),
              ),

              const SizedBox(height: 7),

              Text(
                AppStrings.underReview,
                style:
                    (dark
                            ? AppTextTheme.darkTextTheme.headlineLarge
                            : AppTextTheme.lightTextTheme.headlineLarge)!
                        .copyWith(
                          fontSize: 38,
                          color: dark ? AppColors.light : AppColors.mainButton,
                        ),
                textAlign: TextAlign.center,
              ),

              const SizedBox(height: 30),
              Text(
                AppStrings.underReviewDetails,
                style:
                    (dark
                            ? AppTextTheme.darkTextTheme.headlineLarge
                            : AppTextTheme.lightTextTheme.headlineLarge)!
                        .copyWith(
                          fontSize: 20,
                          color: dark
                              ? AppColors.texthintDark
                              : AppColors.secondaryBlack,
                        ),
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
