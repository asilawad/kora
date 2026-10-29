import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../core/di/injection.dart';
import '../../../core/l10n/generated/app_localizations.dart';
import '../../../core/theme/app_colors.dart';
import 'auth_ui_constants.dart';
import 'cubit/auth_cubit.dart';
import 'cubit/auth_state.dart';
import 'widgets/login_form.dart';
import 'widgets/register_form.dart';

final class AuthBottomSheet extends StatefulWidget {
  const AuthBottomSheet({super.key});

  static Future<bool?> show(BuildContext context) =>
      showModalBottomSheet<bool>(
        context: context,
        isScrollControlled: true,
        useSafeArea: true,
        backgroundColor: AppColors.surface,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(
            top: Radius.circular(AuthUiConstants.sheetTopRadius),
          ),
        ),
        builder: (_) => BlocProvider.value(
          value: sl<AuthCubit>(),
          child: const AuthBottomSheet(),
        ),
      );

  @override
  State<AuthBottomSheet> createState() => _AuthBottomSheetState();
}

final class _AuthBottomSheetState extends State<AuthBottomSheet> {
  bool _isLogin = true;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    return BlocListener<AuthCubit, AuthState>(
      listenWhen: (previous, current) =>
          current.status == AuthStatus.authenticated &&
          previous.status != AuthStatus.authenticated,
      listener: (context, state) => Navigator.of(context).pop(true),
      child: Padding(
        padding: EdgeInsetsDirectional.fromSTEB(
          AuthUiConstants.sheetHorizontalPadding,
          AuthUiConstants.contentSpacing,
          AuthUiConstants.sheetHorizontalPadding,
          MediaQuery.viewInsetsOf(context).bottom + AuthUiConstants.contentSpacing,
        ),
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Text(
                l10n.authSheetTitle,
                style: Theme.of(context).textTheme.titleLarge,
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: AuthUiConstants.contentSpacing),
              _AuthModeToggle(
                isLogin: _isLogin,
                onChanged: (value) => setState(() {
                  _isLogin = value;
                  context.read<AuthCubit>().clearFailure();
                }),
              ),
              const SizedBox(height: AuthUiConstants.contentSpacing),
              if (_isLogin) const LoginForm() else const RegisterForm(),
            ],
          ),
        ),
      ),
    );
  }
}

final class _AuthModeToggle extends StatelessWidget {
  const _AuthModeToggle({required this.isLogin, required this.onChanged});

  final bool isLogin;
  final ValueChanged<bool> onChanged;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    return SegmentedButton<bool>(
      segments: [
        ButtonSegment(value: true, label: Text(l10n.authLogin)),
        ButtonSegment(value: false, label: Text(l10n.authRegister)),
      ],
      selected: {isLogin},
      onSelectionChanged: (selection) => onChanged(selection.first),
    );
  }
}
