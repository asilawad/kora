import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/di/injection.dart';
import '../../../../core/l10n/generated/app_localizations.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/widgets/primary_button.dart';
import '../../../app_shell/presentation/app_shell_navigation.dart';
import '../../../auth/domain/entities/user_entity.dart';
import '../../../auth/presentation/cubit/auth_cubit.dart';
import '../../../auth/presentation/cubit/auth_state.dart';
import '../../../auth/presentation/require_auth.dart';
import '../../../home/domain/providers/place_info_provider.dart';
import '../../../my_bookings/presentation/widgets/logout_confirmation_dialog.dart';
import '../account_dimensions.dart';
import '../widgets/account_profile_card.dart';
import '../widgets/account_tile.dart';

final class AccountPage extends StatelessWidget {
  const AccountPage({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    return Scaffold(
      appBar: AppBar(title: Text(l10n.accountTitle)),
      body: BlocBuilder<AuthCubit, AuthState>(
        bloc: sl<AuthCubit>(),
        builder: (context, state) => state.isAuthenticated
            ? _SignedInBody(user: state.user!)
            : const _GuestBody(),
      ),
    );
  }
}

final class _GuestBody extends StatelessWidget {
  const _GuestBody();

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(AccountDimensions.pagePadding),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: AccountDimensions.guestIconCircle,
              height: AccountDimensions.guestIconCircle,
              decoration: const BoxDecoration(
                color: AppColors.primarySoft,
                shape: BoxShape.circle,
              ),
              child: const Icon(
                Icons.person_outline_rounded,
                color: AppColors.primary,
                size: AccountDimensions.guestIconSize,
              ),
            ),
            const SizedBox(height: AccountDimensions.itemSpacing),
            Text(
              l10n.accountGuestTitle,
              style: Theme.of(context).textTheme.titleLarge,
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: AccountDimensions.smallSpacing),
            Text(
              l10n.accountGuestSubtitle,
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                color: AppColors.textSecondary,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: AccountDimensions.sectionSpacing),
            PrimaryButton(
              label: l10n.myBookingsLogin,
              onPressed: () => requireAuth(context),
            ),
          ],
        ),
      ),
    );
  }
}

final class _SignedInBody extends StatelessWidget {
  const _SignedInBody({required this.user});

  final UserEntity user;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final place = sl<PlaceInfoProvider>().place;
    return ListView(
      padding: const EdgeInsets.all(AccountDimensions.pagePadding),
      children: [
        AccountProfileCard(user: user),
        const SizedBox(height: AccountDimensions.sectionSpacing),
        AccountTile(
          icon: Icons.calendar_month_rounded,
          title: l10n.navigationBookings,
          onTap: AppShellNavigation.goToBookings,
        ),
        if (place != null) ...[
          const SizedBox(height: AccountDimensions.sectionSpacing),
          Text(
            l10n.accountContact,
            style: Theme.of(context).textTheme.titleSmall,
          ),
          const SizedBox(height: AccountDimensions.smallSpacing),
          if (place.contact.phone.isNotEmpty)
            AccountTile(
              icon: Icons.call_rounded,
              title: place.contact.phone,
              onTap: () => _copy(context, place.contact.phone),
            ),
          if (place.contact.whatsapp.isNotEmpty)
            AccountTile(
              icon: Icons.chat_rounded,
              title: place.contact.whatsapp,
              onTap: () => _copy(context, place.contact.whatsapp),
            ),
          if (place.contact.address.isNotEmpty)
            AccountTile(
              icon: Icons.location_on_rounded,
              title: place.contact.address,
              onTap: () => _copy(context, place.contact.address),
            ),
        ],
        const SizedBox(height: AccountDimensions.sectionSpacing),
        AccountTile(
          icon: Icons.logout_rounded,
          title: l10n.myBookingsLogout,
          destructive: true,
          onTap: () async {
            if (!await LogoutConfirmationDialog.show(context)) return;
            await sl<AuthCubit>().logout();
          },
        ),
      ],
    );
  }

  Future<void> _copy(BuildContext context, String text) async {
    await Clipboard.setData(ClipboardData(text: text));
    if (!context.mounted) return;
    ScaffoldMessenger.of(context)
      ..hideCurrentSnackBar()
      ..showSnackBar(
        SnackBar(content: Text(AppLocalizations.of(context)!.accountCopied)),
      );
  }
}
