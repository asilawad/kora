import 'failure.dart';

/// Outcome of an operation: either [Success] with data or [Failed] with a
/// [Failure]. Use `switch` (exhaustive) or [when] to consume it.
sealed class Result<T> {
  const Result();

  bool get isSuccess => this is Success<T>;

  /// Data when successful, otherwise null.
  T? get dataOrNull => switch (this) {
    Success<T>(:final data) => data,
    Failed<T>() => null,
  };

  /// Failure when failed, otherwise null.
  Failure? get failureOrNull => switch (this) {
    Success<T>() => null,
    Failed<T>(:final failure) => failure,
  };

  /// Folds the result into a single value.
  R when<R>({
    required R Function(T data) success,
    required R Function(Failure failure) failed,
  }) => switch (this) {
    Success<T>(:final data) => success(data),
    Failed<T>(:final failure) => failed(failure),
  };

  /// Transforms the data of a successful result.
  Result<R> map<R>(R Function(T data) transform) => switch (this) {
    Success<T>(:final data) => Success(transform(data)),
    Failed<T>(:final failure) => Failed(failure),
  };
}

final class Success<T> extends Result<T> {
  const Success(this.data);

  final T data;
}

final class Failed<T> extends Result<T> {
  const Failed(this.failure);

  final Failure failure;
}
