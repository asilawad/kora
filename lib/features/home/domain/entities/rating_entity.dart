import 'package:equatable/equatable.dart';

class RatingEntity extends Equatable {
  const RatingEntity({required this.average, required this.count});

  final num average;
  final int count;

  @override
  List<Object?> get props => [average, count];
}
