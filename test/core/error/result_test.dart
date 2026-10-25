import 'package:flutter_test/flutter_test.dart';
import 'package:kora/core/error/failure.dart';
import 'package:kora/core/error/result.dart';

void main() {
  group('Result', () {
    test('map transforms success data', () {
      const result = Success<int>(2);
      final mapped = result.map((value) => value * 2);

      expect(mapped, isA<Success<int>>());
      expect((mapped as Success<int>).data, 4);
    });

    test('map preserves failures', () {
      const failure = NetworkFailure();
      const result = Failed<int>(failure);
      final mapped = result.map((value) => value * 2);

      expect(mapped, isA<Failed<int>>());
      expect((mapped as Failed<int>).failure, same(failure));
    });

    test('when handles success and failure', () {
      const success = Success<int>(3);
      const failed = Failed<int>(NetworkFailure());

      expect(
        success.when(success: (data) => data.toString(), failed: (_) => ''),
        '3',
      );
      expect(
        failed.when(success: (_) => '', failed: (_) => 'failed'),
        'failed',
      );
    });

    test('exposes data and failure only for the matching result', () {
      const success = Success<int>(7);
      const failure = NetworkFailure();
      const failed = Failed<int>(failure);

      expect(success.dataOrNull, 7);
      expect(success.failureOrNull, isNull);
      expect(failed.dataOrNull, isNull);
      expect(failed.failureOrNull, failure);
    });
  });
}
