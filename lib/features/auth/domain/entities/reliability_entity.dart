import 'package:equatable/equatable.dart';

class ReliabilityEntity extends Equatable {
  const ReliabilityEntity({
    required this.score,
    required this.level,
    required this.label,
    required this.completed,
    required this.noShows,
    required this.lateCancellations,
    required this.total,
  });

  final num score;
  final String level;
  final String label;
  final int completed;
  final int noShows;
  final int lateCancellations;
  final int total;

  @override
  List<Object?> get props => [
    score,
    level,
    label,
    completed,
    noShows,
    lateCancellations,
    total,
  ];
}
