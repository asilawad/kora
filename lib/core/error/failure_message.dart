import '../l10n/generated/app_localizations.dart';
import 'failure.dart';

extension FailureMessage on Failure {
  String localized(AppLocalizations l10n) => switch (this) {
    NetworkFailure() => l10n.errorNetwork,
    TimeoutFailure() => l10n.errorTimeout,
    ServerFailure(:final message) => message ?? l10n.errorServer,
    UnauthorizedFailure() => l10n.errorUnauthorized,
    ValidationFailure(:final message) => message ?? l10n.errorValidation,
    SlotUnavailableFailure() => l10n.errorSlotUnavailable,
    UnknownFailure() => l10n.errorUnknown,
  };
}
