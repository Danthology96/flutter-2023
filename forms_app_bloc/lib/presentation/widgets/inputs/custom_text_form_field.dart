import 'package:flutter/material.dart';

class CustomTextFormField extends StatelessWidget {
  final bool obscureText;
  final String? label;
  final String? hintText;
  final String? errorText;
  final IconData? icon;
  final Function(String)? onChanged;
  final String? Function(String?)? validator;

  const CustomTextFormField({
    this.obscureText = false,
    super.key,
    this.label,
    this.hintText,
    this.errorText,
    this.icon,
    this.onChanged,
    this.validator,
  });

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;
    final border = OutlineInputBorder(borderRadius: BorderRadius.circular(40));

    return TextFormField(
      onChanged: onChanged,
      obscureText: obscureText,
      validator: validator,
      decoration: InputDecoration(
        enabledBorder: border,
        focusedBorder: border.copyWith(
          borderSide: BorderSide(color: colors.primary),
        ),
        errorBorder: border.copyWith(
          borderSide: BorderSide(color: colors.error),
        ),
        focusedErrorBorder: border.copyWith(
          borderSide: BorderSide(color: colors.error),
        ),
        isDense: true,
        label: label != null ? Text(label!) : null,
        hintText: hintText,
        prefixIcon: Icon(icon),
        errorText: errorText,
      ),
    );
  }
}
