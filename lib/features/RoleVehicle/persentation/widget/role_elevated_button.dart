import 'package:flutter/material.dart';
import 'package:gofix/core/constants/app_colors.dart';
import 'package:gofix/core/constants/app_strings.dart';
import '../../../../core/constants/app_text_style.dart';

class ElevatedRoleButton extends StatefulWidget {
  const ElevatedRoleButton({
    super.key,
    required this.dark,
    required this.role,
    required this.onPressed,
  });

  final bool dark;
  final String? role;
  final VoidCallback onPressed;

  @override
  State<ElevatedRoleButton> createState() => _ElevatedRoleButtonState();
}

class _ElevatedRoleButtonState extends State<ElevatedRoleButton> {
  bool _showMessage = false;

  void _showTemporaryMessage() {
    setState(() => _showMessage = true);

    Future.delayed(const Duration(seconds: 2), () {
      if (mounted) setState(() => _showMessage = false);
    });
  }

  @override
  Widget build(BuildContext context) {
    final messageColor = widget.dark ? AppColors.error : AppColors.warningRed;

    return Stack(
      alignment: Alignment.center,
      clipBehavior: Clip.none,
      children: [
        SizedBox(
          width: double.infinity,
          child: ElevatedButton(
            onPressed: () {
              if (widget.role == null || widget.role!.isEmpty) {
                _showTemporaryMessage();
              } else {
                widget.onPressed();
              }
            },
            child: Text(
              AppStrings.nextStepText,
              style: widget.dark
                  ? AppTextTheme.darkTextTheme.displaySmall
                  : AppTextTheme.lightTextTheme.displaySmall!.copyWith(
                      color: AppColors.light,
                    ),
            ),
          ),
        ),

        Positioned(
          top: 60,
          child: AnimatedOpacity(
            opacity: _showMessage ? 1.0 : 0.0,
            duration: const Duration(milliseconds: 300),
            child: _showMessage
                ? Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 16,
                      vertical: 10,
                    ),
                    decoration: BoxDecoration(
                      color: messageColor,
                      borderRadius: BorderRadius.circular(12),
                      boxShadow: [
                        BoxShadow(
                          color: messageColor.withOpacity(0.4),
                          blurRadius: 8,
                          offset: const Offset(0, 3),
                        ),
                      ],
                    ),
                    child: const Text(
                      AppStrings.chooseRoleWarning,
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  )
                : const SizedBox.shrink(),
          ),
        ),
      ],
    );
  }
}
