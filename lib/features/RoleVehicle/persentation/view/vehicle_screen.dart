import 'package:flutter/material.dart';
import 'package:gofix/core/constants/app_image_strings.dart';
import 'package:gofix/core/utils/helper.dart';
import 'package:gofix/core/constants/app_text_style.dart';
import 'package:gofix/core/constants/app_strings.dart';
import 'package:gofix/features/Driver/DriverView/bike/view/bike_required_doc_screen.dart';
import 'package:gofix/features/RoleVehicle/persentation/widget/role_elevated_button.dart';
import 'package:gofix/features/RoleVehicle/persentation/widget/role_option_card.dart';
import 'package:gofix/features/Trader/RequiredDoc/presentation/view/trader_doc_screen.dart';

class VehicleScreen extends StatefulWidget {
  const VehicleScreen({super.key});

  @override
  State<VehicleScreen> createState() => _VehicleScreenState();
}

class _VehicleScreenState extends State<VehicleScreen> {
  String? selectedVehicle;

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
                AppStrings.selectTheVehicleType,
                style: dark
                    ? AppTextTheme.darkTextTheme.headlineLarge!.copyWith(
                        fontSize: 25,
                      )
                    : AppTextTheme.lightTextTheme.headlineLarge!.copyWith(
                        fontSize: 25,
                      ),
              ),
              const SizedBox(height: 20),

              RoleOptionCard(
                title: AppStrings.vehicleTypeCar,
                imagePath: AppImageStrings.car,
                isSelected: selectedVehicle == AppStrings.vehicleTypeCar,
                onTap: () {
                  setState(() {
                    selectedVehicle = AppStrings.vehicleTypeCar;
                  });
                },
              ),

              RoleOptionCard(
                title: AppStrings.vehicleTypeVan,
                imagePath: AppImageStrings.van,
                isSelected: selectedVehicle == AppStrings.vehicleTypeVan,
                onTap: () {
                  setState(() {
                    selectedVehicle = AppStrings.vehicleTypeVan;
                  });
                },
              ),

              RoleOptionCard(
                title: AppStrings.vehicleTypeMotorcycle,
                imagePath: AppImageStrings.motorcycle,
                isSelected: selectedVehicle == AppStrings.vehicleTypeMotorcycle,
                onTap: () {
                  setState(() {
                    selectedVehicle = AppStrings.vehicleTypeMotorcycle;
                  });
                },
              ),

              RoleOptionCard(
                title: AppStrings.vehicleTypeBike,
                imagePath: AppImageStrings.bicycle,
                isSelected: selectedVehicle == AppStrings.vehicleTypeBike,
                onTap: () {
                  setState(() {
                    selectedVehicle = AppStrings.vehicleTypeBike;
                  });
                },
              ),

              const SizedBox(height: 50),

              ElevatedRoleButton(
                dark: dark,
                role: selectedVehicle,
                
                onPressed: () {
                  if (selectedVehicle == AppStrings.vehicleTypeCar) {
                    // Navigator.push(context, MaterialPageRoute(builder: (_) => VehicleScreen()));
                  } else if (selectedVehicle == AppStrings.vehicleTypeVan) {
                    // Navigator.push(
                    //   context,
                    //   MaterialPageRoute(builder: (_) => TraderDocScreen()),
                    // );
                  
                  } else if (selectedVehicle == AppStrings.vehicleTypeMotorcycle) {
                    // Navigator.push(
                    //   context,
                    //   MaterialPageRoute(builder: (_) => TraderDocScreen()),
                    // );
                  }
                  else
                  {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (_) => BikeDocScreen()),
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
