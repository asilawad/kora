import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/error/failure.dart';
import '../../../../core/l10n/generated/app_localizations.dart';
import '../../../../core/widgets/primary_button.dart';
import '../../data/auth_constants.dart';
import '../../domain/entities/login_params.dart';
import '../auth_ui_constants.dart';
import '../cubit/auth_cubit.dart';
import '../cubit/auth_state.dart';
import 'auth_server_error.dart';
import 'auth_text_field.dart';

final class LoginForm extends StatefulWidget {
  const LoginForm({super.key});

  @override
  State<LoginForm> createState() => _LoginFormState();
}

final class _LoginFormState extends State<LoginForm> {
  final _formKey = GlobalKey<FormState>();
  final _email = TextEditingController();
  final _password = TextEditingController();

  @override
  void dispose() {
    _email.dispose();
    _password.dispose();
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
              controller: _email,
              label: l10n.authEmail,
              keyboardType: TextInputType.emailAddress,
              validator: _validateEmail,
              errorText: _fieldError(state.failure, 'email'),
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
            AuthServerError(failure: state.failure),
            const SizedBox(height: AuthUiConstants.contentSpacing),
            PrimaryButton(
              label: l10n.authLogin,
              isLoading: state.status == AuthStatus.authenticating,
              onPressed: _submit,
            ),
          ],
        ),
      ),
    );
  }

  String? _validateEmail(String? value) {
    final l10n = AppLocalizations.of(context)!;
    final email = value?.trim() ?? '';
    if (email.isEmpty) return l10n.authRequired;
    if (!AuthUiConstants.emailPattern.hasMatch(email)) {
      return l10n.authInvalidEmail;
    }
    return null;
  }

  String? _validatePassword(String? value) {
    final l10n = AppLocalizations.of(context)!;
    if ((value ?? '').isEmpty) return l10n.authRequired;
    if (value!.length < AuthConstants.minimumPasswordLength) {
      return l10n.authPasswordMinLength;
    }
    return null;
  }

  String? _fieldError(Failure? failure, String key) =>
      failure is ValidationFailure
      ? _validationMessage(failure.details, key)
      : null;

  String? _validationMessage(Object? details, String key) {
    if (details is! Map) return null;
    final value = details[key];
    if (value is String) return value;
    if (value is List && value.isNotEmpty && value.first is String) {
      return value.first as String;
    }
    return null;
  }

  void _submit() {
    if (!_formKey.currentState!.validate()) return;
    context.read<AuthCubit>().login(
      LoginParams(email: _email.text.trim(), password: _password.text),
    );
  }
}
