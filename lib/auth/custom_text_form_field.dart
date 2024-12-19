import 'package:flutter/material.dart';
import 'package:to_do_app/app_colors.dart';

typedef myValidator = String? Function(String?)?;

class CustomTextFormField extends StatelessWidget {
  String label;
  myValidator validator;
  TextInputType keyboardType;
  TextEditingController controller;
  bool obscureText;

  // String? Function(String?)? validator;
  CustomTextFormField(
      {super.key,
      required this.label,
      required this.validator,
      required this.controller,
      this.obscureText = false,
      this.keyboardType = TextInputType.text});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8),
      child: TextFormField(
        decoration: InputDecoration(
          enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(15),
              borderSide:
                  const BorderSide(color: AppColors.primaryColor, width: 2)),
          focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(15),
              borderSide:
                  const BorderSide(color: AppColors.primaryColor, width: 2)),
          errorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(15),
              borderSide:
                  const BorderSide(color: AppColors.redColor, width: 2)),
          focusedErrorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(15),
              borderSide:
                  const BorderSide(color: AppColors.redColor, width: 2)),
          label: Text(label),
        ),
        validator: validator,
        keyboardType: keyboardType,
        controller: controller,
        obscureText: obscureText,
      ),
    );
  }
}