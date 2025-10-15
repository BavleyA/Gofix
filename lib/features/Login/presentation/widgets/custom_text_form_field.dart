// import 'package:flutter/material.dart';
// import 'package:gofix/core/constants/app_colors.dart';

// class CustomTextFormField extends StatefulWidget {
//   final String labelText;
//   final TextInputType keyboardType;
//   final TextEditingController? controller;
//   final IconData? icon;
//   final IconData? suffixIcon;
//   final ValueChanged<String> onChanged;
//   final String? Function(String?)? validator;
//   final bool obscureText;
//   final bool dark;

//   const CustomTextFormField({
//     super.key,
//     this.keyboardType = TextInputType.text,
//     required this.dark,
//     required this.labelText,
//     required this.controller,
//     this.icon,
//     this.suffixIcon,
//     required this.onChanged,
//     required this.validator,
//     this.obscureText = false,
//   });

//   @override
//   State<CustomTextFormField> createState() => _CustomTextFormFieldState();
// }

// class _CustomTextFormFieldState extends State<CustomTextFormField> {
//   late bool _obscureText;

//   @override
//   void initState() {
//     super.initState();
//     _obscureText = widget.obscureText;
//   }

//   @override
//   Widget build(BuildContext context) {
//     return TextFormField(
//       controller: widget.controller,
//       decoration: InputDecoration(
//         label: Text(
//           widget.labelText,
//           style: TextStyle(
//             color: widget.dark
//                 ? AppColors.placeholderTextDark
//                 : AppColors.placeholderTextLight,
//           ),
//         ),

//         prefixIcon: widget.icon != null ? Icon(widget.icon) : null,

//         suffixIcon: widget.suffixIcon != null
//             ? IconButton(
//                 icon: Icon(
//                   _obscureText ? widget.suffixIcon : Icons.visibility,
//                   // color: AppColors.placeholderTextDark,
//                 ),
//                 onPressed: () {
//                   setState(() {
//                     _obscureText = !_obscureText;
//                   });
//                 },
//               )
//             : null,

//         enabledBorder: OutlineInputBorder(
//           borderSide: BorderSide(
//             color: widget.dark
//                 ? AppColors.verifyNumberField
//                 : AppColors.buttonSecondary,
//             width: 1.2,
//           ),
//           borderRadius: BorderRadius.circular(12),
//         ),
//         focusedBorder: OutlineInputBorder(
//           borderSide: BorderSide(
//             color: widget.dark
//                 ? AppColors.strokeEnabled
//                 : AppColors.placeholderTextDark,
//             width: 2,
//           ),
//           borderRadius: BorderRadius.circular(12),
//         ),
//       ),
//       keyboardType: widget.keyboardType,
//       obscureText: widget.obscureText,
//       onChanged: widget.onChanged,
//       validator: widget.validator,
//     );
//   }
// }

// import 'package:flutter/material.dart';
// import 'package:gofix/core/constants/app_colors.dart';

// class CustomTextFormField extends StatefulWidget {
//   final String labelText;
//   final TextInputType keyboardType;
//   final TextEditingController? controller;
//   final IconData? icon;
//   final IconData? suffixIcon;
//   final ValueChanged<String> onChanged;
//   final String? Function(String?)? validator;
//   final bool obscureText;
//   final bool dark;

//   const CustomTextFormField({
//     super.key,
//     this.keyboardType = TextInputType.text,
//     required this.dark,
//     required this.labelText,
//     required this.controller,
//     this.icon,
//     this.suffixIcon,
//     required this.onChanged,
//     required this.validator,
//     this.obscureText = false,
//   });

//   @override
//   State<CustomTextFormField> createState() => _CustomTextFormFieldState();
// }

// class _CustomTextFormFieldState extends State<CustomTextFormField> {
//   late bool _obscureText;

//   @override
//   void initState() {
//     super.initState();
//     _obscureText = widget.obscureText;
//   }

//   @override
//   Widget build(BuildContext context) {
//     return TextFormField(
//       controller: widget.controller,
//       obscureText: _obscureText,
//       decoration: InputDecoration(
//         label: Text(
//           widget.labelText,
//           style: TextStyle(
//             color: widget.dark
//                 ? AppColors.placeholderTextDark
//                 : AppColors.placeholderTextLight,
//           ),
//         ),

//         prefixIcon: widget.icon != null
//             ? Icon(
//                 widget.icon,
//                 color: widget.dark
//                     ? AppColors.placeholderTextDark
//                     : AppColors.placeholderTextLight,
//               )
//             : null,

//         suffixIcon: widget.suffixIcon != null
//             ? IconButton(
//                 icon: Icon(
//                   Icons.visibility,

//                   color: widget.dark
//                       ? AppColors.placeholderTextDark
//                       : AppColors.placeholderTextLight,
//                 ),
//                 onPressed: () {
//                   setState(() {
//                     _obscureText = !_obscureText;
//                   });
//                 },
//               )
//             : null,

//         enabledBorder: OutlineInputBorder(
//           borderSide: BorderSide(
//             color: widget.dark
//                 ? AppColors.verifyNumberField
//                 : AppColors.buttonSecondary,
//             width: 1.2,
//           ),
//           borderRadius: BorderRadius.circular(12),
//         ),
//         focusedBorder: OutlineInputBorder(
//           borderSide: BorderSide(
//             color: widget.dark
//                 ? AppColors.strokeEnabled
//                 : AppColors.placeholderTextDark,
//             width: 2,
//           ),
//           borderRadius: BorderRadius.circular(12),
//         ),
//       ),
//       keyboardType: widget.keyboardType,
//       onChanged: widget.onChanged,
//       validator: widget.validator,
//     );
//   }
// }
import 'package:flutter/material.dart';
import 'package:gofix/core/constants/app_colors.dart';

class CustomTextFormField extends StatefulWidget {
  final String labelText;
  final TextInputType keyboardType;
  final TextEditingController? controller;
  final IconData? icon;
  final IconData? suffixIcon;
  final ValueChanged<String> onChanged;
  final String? Function(String?)? validator;
  final bool obscureText;
  final bool dark;

  const CustomTextFormField({
    super.key,
    this.keyboardType = TextInputType.text,
    required this.dark,
    required this.labelText,
    required this.controller,
    this.icon,
    this.suffixIcon,
    required this.onChanged,
    required this.validator,
    this.obscureText = false,
  });

  @override
  State<CustomTextFormField> createState() => _CustomTextFormFieldState();
}

class _CustomTextFormFieldState extends State<CustomTextFormField> {
  late bool _obscureText;

  @override
  void initState() {
    super.initState();
    _obscureText = widget.obscureText;
  }

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: widget.controller,
      obscureText: _obscureText,
      decoration: InputDecoration(
        label: Text(
          widget.labelText,
          style: TextStyle(
            color: widget.dark
                ? AppColors.placeholderTextDark
                : AppColors.placeholderTextLight,
          ),
        ),

        prefixIcon: widget.icon != null
            ? Icon(
                widget.icon,
                color: widget.dark
                    ? AppColors.placeholderTextDark
                    : AppColors.placeholderTextLight,
              )
            : null,

        suffixIcon: widget.suffixIcon != null
            ? IconButton(
                icon: Icon(
                  Icons.visibility,
                  color: widget.dark
                      ? AppColors.placeholderTextDark
                      : AppColors.placeholderTextLight,
                ),
                onPressed: () {
                  setState(() {
                    _obscureText = !_obscureText;
                  });
                },
              )
            : null,

        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(
            color: widget.dark
                ? AppColors.verifyNumberField
                : AppColors.buttonSecondary,
            width: 1.2,
          ),
          borderRadius: BorderRadius.circular(12),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(
            color: widget.dark
                ? AppColors.strokeEnabled
                : AppColors.placeholderTextDark,
            width: 2,
          ),
          borderRadius: BorderRadius.circular(12),
        ),

        errorBorder: OutlineInputBorder(
          borderSide: const BorderSide(color: Colors.red, width: 1.5),
          borderRadius: BorderRadius.circular(12),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderSide: const BorderSide(color: Colors.redAccent, width: 2),
          borderRadius: BorderRadius.circular(12),
        ),
        errorStyle: const TextStyle(color: Colors.red, fontSize: 13),
      ),
      keyboardType: widget.keyboardType,

      onChanged: (value) {
        widget.onChanged(value);
        Form.of(context).validate();
      },

      validator: widget.validator,
    );
  }
}
