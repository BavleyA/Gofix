import 'package:flutter/material.dart';
import 'package:gofix/core/constants/app_colors.dart';
import 'package:gofix/core/constants/app_image_strings.dart';
import 'package:gofix/core/utils/helper.dart';
import 'package:gofix/core/constants/app_text_style.dart';
import 'package:gofix/core/constants/app_strings.dart';
import 'package:gofix/features/RoleVehicle/persentation/view/vehicle_screen.dart';
import 'package:gofix/features/RoleVehicle/persentation/widget/role_elevated_button.dart';
import 'package:gofix/features/RoleVehicle/persentation/widget/role_option_card.dart';
import 'package:gofix/features/Trader/RequiredDoc/presentation/view/trader_doc_screen.dart';

class RoleScreen extends StatefulWidget {
  const RoleScreen({super.key});

  @override
  State<RoleScreen> createState() => _RoleScreenState();
}

class _RoleScreenState extends State<RoleScreen> {
  String? selectedRole;

  @override
  Widget build(BuildContext context) {
    final dark = Helper.isDarkMode(context);

    return Scaffold(
      appBar: AppBar(),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(18.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                AppStrings.roleTitle,
                style: dark
                    ? AppTextTheme.darkTextTheme.headlineLarge!.copyWith(
                        color: AppColors.imageCard,
                      )
                    : AppTextTheme.lightTextTheme.headlineLarge!.copyWith(
                        color: AppColors.secondaryBlack,
                      ),
              ),
              const SizedBox(height: 20),

              RoleOptionCard(
                title: AppStrings.trader,
                imagePath: AppImageStrings.chooseRoleTrader,
                isSelected: selectedRole == AppStrings.trader,
                onTap: () {
                  setState(() {
                    selectedRole = AppStrings.trader;
                  });
                },
              ),

              RoleOptionCard(
                title: AppStrings.driver,
                imagePath: AppImageStrings.chooseRoleDriver,
                isSelected: selectedRole == AppStrings.driver,
                onTap: () {
                  setState(() {
                    selectedRole = AppStrings.driver;
                  });
                },
              ),

              const SizedBox(height: 50),

              ElevatedRoleButton(
                dark: dark,
                role: selectedRole,
                onPressed: () {
                  if (selectedRole == AppStrings.driver) {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (_) => VehicleScreen()),
                    );
                  } else if (selectedRole == AppStrings.trader) {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (_) => TraderDocScreen()),
                    );
                  }
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
