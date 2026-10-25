import 'package:equatable/equatable.dart';

class PlaceContactEntity extends Equatable {
  const PlaceContactEntity({
    required this.phone,
    required this.whatsapp,
    required this.address,
  });

  final String phone;
  final String whatsapp;
  final String address;

  @override
  List<Object?> get props => [phone, whatsapp, address];
}
