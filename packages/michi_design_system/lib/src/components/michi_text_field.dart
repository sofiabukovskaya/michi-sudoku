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
    super.key,
  });

  final String label;
  final TextEditingController? controller;
  final String? errorText;
  final ValueChanged<String>? onChanged;
  final bool obscureText;

  @override
  Widget build(BuildContext context) => TextField(
    controller: controller,
    onChanged: onChanged,
    obscureText: obscureText,
    decoration: InputDecoration(
      labelText: label,
      errorText: errorText,
      filled: true,
      fillColor: MichiPalette.of(context).ivory,
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(MichiRadius.control),
        borderSide: BorderSide(color: MichiPalette.of(context).inputLine),
      ),
    ),
  );
}
