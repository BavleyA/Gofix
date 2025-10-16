import 'package:flutter/material.dart';
import 'package:gofix/core/constants/app_colors.dart';
import 'package:gofix/core/constants/app_image_strings.dart';
import 'package:gofix/core/utils/helper.dart';

class DocTile extends StatelessWidget {
  final String title;
  final String route;
  final VoidCallback? onTap;

  const DocTile({
    super.key,
    required this.title,
    required this.route,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final dark = Helper.isDarkMode(context);

    return InkWell(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.only(right: 5),
        child: Container(
          decoration: BoxDecoration(
            color: dark ? AppColors.imageCardDark : AppColors.docCard,
            border: const Border(
              bottom: BorderSide(color: AppColors.selectedContainer, width: 2),
            ),
          ),
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                title,
                style: TextStyle(
                  color: dark
                      ? AppColors.primaryTextDark
                      : AppColors.dark.withOpacity(0.8),
                  fontSize: 17,
                  fontWeight: FontWeight.w500,
                ),
              ),

              Row(
                children: [
                  CircleAvatar(
                    radius: 16,
                    backgroundColor: Colors.transparent,
                    // child: Image.asset(AppImageStrings.documentIcon),
                  ),
                  const SizedBox(width: 8),
                  const Icon(
                    Icons.arrow_forward_ios,
                    size: 16,
                    color: AppColors.selectedContainer,
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
