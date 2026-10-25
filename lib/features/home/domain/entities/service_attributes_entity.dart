import 'package:equatable/equatable.dart';

class ServiceAttributesEntity extends Equatable {
  const ServiceAttributesEntity({this.sport, this.players, this.lighting});

  final String? sport;
  final num? players;
  final bool? lighting;

  @override
  List<Object?> get props => [sport, players, lighting];
}
