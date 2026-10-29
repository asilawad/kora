import 'package:flutter/material.dart';

import '../../../../core/l10n/generated/app_localizations.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/widgets/primary_button.dart';
import '../my_bookings_dimensions.dart';

final class SignedOutView extends StatelessWidget {
  const SignedOutView({required this.onLogin, super.key});

  final VoidCallback onLogin;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(MyBookingsDimensions.pagePadding),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Icon(
              Icons.lock_outline,
              color: AppColors.textSecondary,
              size: MyBookingsDimensions.signedOutIconSize,
            ),
            const SizedBox(height: MyBookingsDimensions.sectionSpacing),
            Text(
              l10n.myBookingsSignedOut,
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: MyBookingsDimensions.sectionSpacing),
            PrimaryButton(
              label: l10n.myBookingsLogin,
              onPressed: onLogin,
            ),
          ],
        ),
      ),
    );
  }
}
