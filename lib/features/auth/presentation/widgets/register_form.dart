import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/error/failure.dart';
import '../../../../core/l10n/generated/app_localizations.dart';
import '../../../../core/widgets/primary_button.dart';
import '../../data/auth_constants.dart';
import '../../domain/entities/register_params.dart';
import '../auth_ui_constants.dart';
import '../cubit/auth_cubit.dart';
import '../cubit/auth_state.dart';
import 'auth_server_error.dart';
import 'auth_text_field.dart';

final class RegisterForm extends StatefulWidget {
  const RegisterForm({super.key});

  @override
  State<RegisterForm> createState() => _RegisterFormState();
}

final class _RegisterFormState extends State<RegisterForm> {
  final _formKey = GlobalKey<FormState>();
  final _name = TextEditingController();
  final _email = TextEditingController();
  final _phone = TextEditingController();
  final _password = TextEditingController();
  final _confirmation = TextEditingController();

  @override
  void dispose() {
    _name.dispose();
    _email.dispose();
    _phone.dispose();
    _password.dispose();
    _confirmation.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    return BlocBuilder<AuthCubit, AuthState>(
      builder: (context, state) => Form(
        key: _formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            AuthTextField(
              controller: _name,
              label: l10n.authName,
              validator: _required,
              errorText: _fieldError(state.failure, 'name'),
            ),
            const SizedBox(height: AuthUiConstants.fieldSpacing),
            AuthTextField(
              controller: _email,
              label: l10n.authEmail,
              keyboardType: TextInputType.emailAddress,
              validator: _validateEmail,
              errorText: _fieldError(state.failure, 'email'),
            ),
            const SizedBox(height: AuthUiConstants.fieldSpacing),
            AuthTextField(
              controller: _phone,
              label: l10n.authPhone,
              keyboardType: TextInputType.phone,
              validator: _phoneRequired,
              errorText: _fieldError(state.failure, 'phone'),
            ),
            const SizedBox(height: AuthUiConstants.fieldSpacing),
            AuthTextField(
              controller: _password,
              label: l10n.authPassword,
              isPassword: true,
              validator: _validatePassword,
              errorText: _fieldError(state.failure, 'password'),
            ),
            const SizedBox(height: AuthUiConstants.fieldSpacing),
            AuthTextField(
              controller: _confirmation,
              label: l10n.authConfirmPassword,
              isPassword: true,
              validator: _validateConfirmation,
              errorText: _fieldError(state.failure, 'password_confirmation'),
            ),
            const SizedBox(height: AuthUiConstants.fieldSpacing),
            AuthServerError(failure: state.failure),
            const SizedBox(height: AuthUiConstants.contentSpacing),
            PrimaryButton(
              label: l10n.authRegister,
              isLoading: state.status == AuthStatus.authenticating,
              onPressed: _submit,
            ),
          ],
        ),
      ),
    );
  }

  String? _required(String? value) =>
      (value?.trim().isNotEmpty ?? false)
      ? null
      : AppLocalizations.of(context)!.authRequired;

  String? _phoneRequired(String? value) =>
      (value?.trim().isNotEmpty ?? false)
      ? null
      : AppLocalizations.of(context)!.authPhoneRequired;

  String? _validateEmail(String? value) {
    final email = value?.trim() ?? '';
    if (email.isEmpty) return AppLocalizations.of(context)!.authRequired;
    return AuthUiConstants.emailPattern.hasMatch(email)
        ? null
        : AppLocalizations.of(context)!.authInvalidEmail;
  }

  String? _validatePassword(String? value) {
    final l10n = AppLocalizations.of(context)!;
    if ((value ?? '').isEmpty) return l10n.authRequired;
    return value!.length >= AuthConstants.minimumPasswordLength
        ? null
        : l10n.authPasswordMinLength;
  }

  String? _validateConfirmation(String? value) {
    final l10n = AppLocalizations.of(context)!;
    if ((value ?? '').isEmpty) return l10n.authRequired;
    return value == _password.text ? null : l10n.authPasswordMismatch;
  }

  String? _fieldError(Failure? failure, String key) {
    if (failure is! ValidationFailure || failure.details is! Map) return null;
    final value = (failure.details as Map)[key];
    if (value is String) return value;
    if (value is List && value.isNotEmpty && value.first is String) {
      return value.first as String;
    }
    return null;
  }

  void _submit() {
    if (!_formKey.currentState!.validate()) return;
    context.read<AuthCubit>().register(
      RegisterParams(
        name: _name.text.trim(),
        email: _email.text.trim(),
        phone: _phone.text.trim(),
        password: _password.text,
        passwordConfirmation: _confirmation.text,
      ),
    );
  }
}
