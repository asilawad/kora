import 'package:flutter/material.dart';

import '../../../../core/l10n/generated/app_localizations.dart';
import '../auth_ui_constants.dart';

final class AuthTextField extends StatefulWidget {
  const AuthTextField({
    required this.controller,
    required this.label,
    required this.validator,
    this.keyboardType,
    this.errorText,
    this.isPassword = false,
    super.key,
  });

  final TextEditingController controller;
  final String label;
  final String? Function(String?) validator;
  final TextInputType? keyboardType;
  final String? errorText;
  final bool isPassword;

  @override
  State<AuthTextField> createState() => _AuthTextFieldState();
}

final class _AuthTextFieldState extends State<AuthTextField> {
  bool _obscureText = true;

  @override
  Widget build(BuildContext context) => TextFormField(
    controller: widget.controller,
    keyboardType: widget.keyboardType,
    obscureText: widget.isPassword && _obscureText,
    validator: widget.validator,
    decoration: InputDecoration(
      labelText: widget.label,
      errorText: widget.errorText,
      suffixIcon: widget.isPassword
          ? IconButton(
              tooltip: _obscureText
                  ? AppLocalizations.of(context)!.authPasswordVisibility
                  : AppLocalizations.of(context)!.authPasswordVisibilityHidden,
              icon: Icon(
                _obscureText ? Icons.visibility : Icons.visibility_off,
                size: AuthUiConstants.visibilityIconSize,
              ),
              onPressed: () => setState(() => _obscureText = !_obscureText),
            )
          : null,
    ),
  );
}
