import 'package:flutter/material.dart';
import 'package:gofix/core/constants/app_colors.dart';
import 'package:gofix/core/constants/app_strings.dart';
import 'package:gofix/core/constants/app_text_style.dart';
import 'package:gofix/core/utils/helper.dart';
import 'package:gofix/features/Trader/RequiredDoc/presentation/view/bussiness_details_screen.dart';
import 'package:gofix/features/Trader/RequiredDoc/presentation/view/national_id_screen.dart';
import 'package:gofix/features/Trader/RequiredDoc/presentation/view/onilne_presence_screen.dart';
import 'package:gofix/features/Trader/RequiredDoc/presentation/view/profile_pic_screen.dart';
import 'package:gofix/features/Trader/RequiredDoc/presentation/widget/nubmered_circle.dart';
import 'package:gofix/features/Trader/RequiredDoc/presentation/widget/required_doc_tile.dart';

class TraderDocScreen extends StatefulWidget {
  const TraderDocScreen({super.key});

  @override
  State<TraderDocScreen> createState() => _TraderDocScreenState();
}

class _TraderDocScreenState extends State<TraderDocScreen> {
  final List<bool> _stepsCompleted = [false, false, false, false];

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
                            builder: (_) => const ProfilePictureScreen(),
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
                            builder: (_) => const NationalIdScreen(),
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

              /// Business Details
              Row(
                children: [
                  NumberedCircle(number: "3", isCompleted: _stepsCompleted[2]),
                  const SizedBox(width: 12),
                  Expanded(
                    child: DocTile(
                      title: AppStrings.businessDetails,
                      route: '/business-details',
                      onTap: () async {
  final completed = await Navigator.push(
    context,
    MaterialPageRoute(
      builder: (_) => const BussinessDetailsScreen(),
    ),
  );

  if (completed == true) {
    _markStepCompleted(2);
  }
},

                    ),
                  ),
                ],
              ),
              const SizedBox(height: 12),

              /// Online Presence
              Row(
                children: [
                  NumberedCircle(number: "4", isCompleted: _stepsCompleted[3]),
                  const SizedBox(width: 12),
                  Expanded(
                    child: DocTile(
                      title: AppStrings.onlinePresence,
                      route: '/online-presence',
                      onTap: () async {
                        final completed = await Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (_) => const OnlinePresenceScreen(),
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

              const SizedBox(height: 70),

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
                  onPressed: _allStepsCompleted ? () {} : null,
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
