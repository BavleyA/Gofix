import 'package:flutter/material.dart';
import 'package:gofix/core/constants/app_colors.dart';
import 'package:gofix/core/constants/app_strings.dart';
import 'package:gofix/core/constants/app_text_style.dart';
import 'package:gofix/core/utils/helper.dart';
import 'package:gofix/features/CommonPages/view/under_review_screen.dart';
import 'package:gofix/features/CommonPages/widgets/nubmered_circle.dart';
import 'package:gofix/features/CommonPages/widgets/required_doc_tile.dart';
import 'package:gofix/features/Driver/DriverView/otherCars/view/cars_criminal_record.dart';
import 'package:gofix/features/Driver/DriverView/otherCars/view/cars_driving_licence_screen.dart';
import 'package:gofix/features/Driver/DriverView/otherCars/view/cars_national_id_screen.dart';
import 'package:gofix/features/Driver/DriverView/otherCars/view/cars_profile_picture_screen.dart';
import 'package:gofix/features/Driver/DriverView/otherCars/view/cars_vehicle_licence_screen.dart';

class CarsDocScreen extends StatefulWidget {
  const CarsDocScreen({super.key});

  @override
  State<CarsDocScreen> createState() => _CarsDocScreenState();
}

class _CarsDocScreenState extends State<CarsDocScreen> {
  final List<bool> _stepsCompleted = [false, false, false, false, false];

  void _markStepCompleted(int index) {
    setState(() {
      _stepsCompleted[index] = true;
    });
  }

  bool get _allStepsCompleted => _stepsCompleted.every((step) => step);

  @override
  Widget build(BuildContext context) {
    final dark = Helper.isDarkMode(context);

    return Scaffold(
      appBar: AppBar(),
      backgroundColor: AppColors.background,
      body: Padding(
        padding: const EdgeInsets.all(18),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                AppStrings.requiredDocuments,
                style: dark
                    ? AppTextTheme.darkTextTheme.headlineLarge
                    : AppTextTheme.lightTextTheme.headlineLarge,
              ),
              const SizedBox(height: 30),

              /// Profile Picture
              Row(
                children: [
                  NumberedCircle(number: "1", isCompleted: _stepsCompleted[0]),
                  const SizedBox(width: 12),
                  Expanded(
                    child: DocTile(
                      title: AppStrings.profilePhoto,
                      route: '/profile-picture',
                      onTap: () async {
                        final result = await Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (_) => const CarsProfilePictureScreen(),
                          ),
                        );

                        if (result != null) {
                          _markStepCompleted(0);
                        }
                      },
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 12),

              /// National ID
              Row(
                children: [
                  NumberedCircle(number: "2", isCompleted: _stepsCompleted[1]),
                  const SizedBox(width: 12),
                  Expanded(
                    child: DocTile(
                      title: AppStrings.nationalID,
                      route: '/national-id',
                      onTap: () async {
                        final completed = await Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (_) => const CarsNationalIDScreen(),
                          ),
                        );
                        if (completed != null) {
                          _markStepCompleted(1);
                        }
                      },
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 12),

              /// Criminal Record Certificate
              Row(
                children: [
                  NumberedCircle(number: "3", isCompleted: _stepsCompleted[2]),
                  const SizedBox(width: 12),
                  Expanded(
                    child: DocTile(
                      title: AppStrings.criminalRecordCertificate,
                      route: '/criminal-record-certificate',
                      onTap: () async {
                        final completed = await Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (_) => const CarsCriminalRecordScreen(),
                          ),
                        );
                        if (completed != null && completed['image'] != null) {
                          _markStepCompleted(2);
                        }
                      },
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 12),

              /// Vehicle Licence
              Row(
                children: [
                  NumberedCircle(number: "4", isCompleted: _stepsCompleted[3]),
                  const SizedBox(width: 12),
                  Expanded(
                    child: DocTile(
                      title: AppStrings.vehicleLicense,
                      route: '/vehicle-licence',
                      onTap: () async {
                        final completed = await Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (_) => const CarsVehicleLicenceScreen(),
                          ),
                        );
                        if (completed != null) {
                          _markStepCompleted(3);
                        }
                      },
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 12),

              /// Driving Licence
              Row(
                children: [
                  NumberedCircle(number: "5", isCompleted: _stepsCompleted[4]),
                  const SizedBox(width: 12),
                  Expanded(
                    child: DocTile(
                      title: AppStrings.driverLicense,
                      route: '/driving-licence',
                      onTap: () async {
                        final completed = await Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (_) => const CarsDrivingLicenceScreen(),
                          ),
                        );
                        if (completed != null) {
                          _markStepCompleted(4);
                        }
                      },
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 12),

              const SizedBox(height: 50),

              SizedBox(
                width: double.infinity,
                height: 50,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: _allStepsCompleted
                        ? AppColors.buttonPrimary
                        : AppColors.buttonPrimary.withOpacity(0.5),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  onPressed: _allStepsCompleted ? () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => UnderReviewScreen(),
                            ),
                          );
                        } : null,
                  child: Text(
                    AppStrings.done,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
