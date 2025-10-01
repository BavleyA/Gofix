import 'package:flutter/material.dart';

import '../../../../core/constants/app_text_form_field_theme.dart';

class CustomTextFormField extends StatefulWidget {
  final String labelText;
  // final String hintText;
  final TextInputType keyboardType;
  final TextEditingController? controller;
  final IconData? icon;
  final IconData? suffixIcon;
  final ValueChanged<String> onChanged;
  final String? Function(String?)? validator;
  final bool obscureText;


  const CustomTextFormField({
    super.key,
    this.keyboardType = TextInputType.text,
    required this.dark,
    required this.labelText,
    // required this.hintText,
    required this.controller,
    this.icon,
    this.suffixIcon,
    required this.onChanged,
    required this.validator,
    this.obscureText = false,
  });

  final bool dark;

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
      decoration: InputDecoration(
        label: Text(widget.labelText),
        // hintText: widget.hintText,
        prefixIcon: widget.icon != null ? Icon(widget.icon) : null,
        suffixIcon: widget.suffixIcon != null
            ? IconButton(
                icon: Icon(
                  _obscureText ? widget.suffixIcon
                      : Icons.visibility
                ),
                onPressed: () {
                  setState(() {
                    _obscureText = !_obscureText;
                  });
                },
        ) : null,

      ),
      keyboardType: widget.keyboardType,
      obscureText: widget.obscureText,
      onChanged: widget.onChanged,
      validator: widget.validator,
    );
  }
}
