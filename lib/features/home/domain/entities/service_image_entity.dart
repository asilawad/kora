import 'package:equatable/equatable.dart';

class ServiceImageEntity extends Equatable {
  const ServiceImageEntity({
    required this.path,
    required this.url,
    required this.thumb,
  });

  final String path;
  final String url;
  final String thumb;

  @override
  List<Object?> get props => [path, url, thumb];
}
