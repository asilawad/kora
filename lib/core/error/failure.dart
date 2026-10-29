import 'package:equatable/equatable.dart';

/// Base class for every failure in the app.
/// Carries no user-facing text: the UI maps each type to a localized message,
/// and uses [message] (from the server) only when it is available.
sealed class Failure extends Equatable {
  const Failure({this.message, this.code});

  /// Server-provided message (may be null).
  final String? message;

  /// Server-provided error code (may be null).
  final String? code;

  @override
  List<Object?> get props => [message, code];
}

/// No connection or unreachable host.
final class NetworkFailure extends Failure {
  const NetworkFailure({super.message, super.code});
}

/// Connect / send / receive timeout.
final class TimeoutFailure extends Failure {
  const TimeoutFailure({super.message, super.code});
}

/// Non-success response from the API.
final class ServerFailure extends Failure {
  const ServerFailure({super.message, super.code, this.statusCode});

  final int? statusCode;

  @override
  List<Object?> get props => [...super.props, statusCode];
}

/// Missing or invalid token (HTTP 401).
final class UnauthorizedFailure extends Failure {
  const UnauthorizedFailure({super.message, super.code});
}

/// Invalid email or password returned by the authentication endpoints.
final class InvalidCredentialsFailure extends Failure {
  const InvalidCredentialsFailure({super.message, super.code});
}

/// Request rejected by validation (field errors kept raw in [details]).
final class ValidationFailure extends Failure {
  const ValidationFailure({super.message, super.code, this.details});

  final Object? details;

  @override
  List<Object?> get props => [...super.props, details];
}

/// The chosen slot was taken (`SLOT_UNAVAILABLE`).
/// [alternatives] is kept raw until the response shape is confirmed.
final class SlotUnavailableFailure extends Failure {
  const SlotUnavailableFailure({
    super.message,
    super.code,
    this.alternatives = const [],
  });

  final List<Object?> alternatives;

  @override
  List<Object?> get props => [...super.props, alternatives];
}

/// Anything unexpected (parsing errors, cancelled requests, ...).
final class UnknownFailure extends Failure {
  const UnknownFailure({super.message, super.code});
}
