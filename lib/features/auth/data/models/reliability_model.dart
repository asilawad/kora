import '../../domain/entities/reliability_entity.dart';
import 'auth_json_keys.dart';

final class ReliabilityModel extends ReliabilityEntity {
  const ReliabilityModel({
    required super.score,
    required super.level,
    required super.label,
    required super.completed,
    required super.noShows,
    required super.lateCancellations,
    required super.total,
  });

  factory ReliabilityModel.fromJson(Map<String, dynamic> json) =>
      ReliabilityModel(
        score: json[AuthJsonKeys.score] as num,
        level: json[AuthJsonKeys.level] as String,
        label: json[AuthJsonKeys.label] as String,
        completed: json[AuthJsonKeys.completed] as int,
        noShows: json[AuthJsonKeys.noShows] as int,
        lateCancellations: json[AuthJsonKeys.lateCancellations] as int,
        total: json[AuthJsonKeys.total] as int,
      );
}
