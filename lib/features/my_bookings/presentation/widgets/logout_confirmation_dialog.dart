import 'package:flutter/material.dart';

import '../../../../core/l10n/generated/app_localizations.dart';

final class LogoutConfirmationDialog extends StatelessWidget {
  const LogoutConfirmationDialog({super.key});

  static Future<bool> show(BuildContext context) async =>
      await showDialog<bool>(
        context: context,
        builder: (_) => const LogoutConfirmationDialog(),
      ) ??
      false;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    return AlertDialog(
      title: Text(l10n.myBookingsLogoutTitle),
      content: Text(l10n.myBookingsLogoutMessage),
      actions: [
        TextButton(
          onPressed: () => Navigator.of(context).pop(false),
          child: Text(l10n.myBookingsKeepBooking),
        ),
        FilledButton(
          onPressed: () => Navigator.of(context).pop(true),
          child: Text(l10n.myBookingsLogout),
        ),
      ],
    );
  }
}
