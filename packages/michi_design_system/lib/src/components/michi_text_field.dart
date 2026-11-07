import 'package:flutter/material.dart';

import '../theme/michi_palette.dart';
import '../tokens/michi_radius.dart';

final class MichiTextField extends StatelessWidget {
  const MichiTextField({
    required this.label,
    this.controller,
    this.errorText,
    this.onChanged,
    this.obscureText = false,
    this.keyboardType,
    this.textInputAction,
    this.autofillHints,
    this.suffixIcon,
    this.enabled = true,
    this.onSubmitted,
    super.key,
  });

  final String label;
  final TextEditingController? controller;
  final String? errorText;
  final ValueChanged<String>? onChanged;
  final bool obscureText;
  final TextInputType? keyboardType;
  final TextInputAction? textInputAction;
  final Iterable<String>? autofillHints;
  final Widget? suffixIcon;
  final bool enabled;
  final ValueChanged<String>? onSubmitted;

  @override
  Widget build(BuildContext context) => TextField(
    controller: controller,
    onChanged: onChanged,
    onSubmitted: onSubmitted,
    obscureText: obscureText,
    keyboardType: keyboardType,
    textInputAction: textInputAction,
    autofillHints: autofillHints,
    enabled: enabled,
    decoration: InputDecoration(
      labelText: label,
      errorText: errorText,
      suffixIcon: suffixIcon,
      filled: true,
      fillColor: MichiPalette.of(context).ivory,
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(MichiRadius.control),
        borderSide: BorderSide(color: MichiPalette.of(context).inputLine),
      ),
    ),
  );
}
