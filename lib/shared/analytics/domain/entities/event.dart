import 'package:equatable/equatable.dart';

class Event extends Equatable {
  Event({
    required this.name,
    this.params,
  }) {
    if (name.length > 40) {
      throw ArgumentError('Event name can not exceed 40 characters.');
    }
    if (params != null) {
      if (params!.keys.length > 25) {
        throw ArgumentError('Event can not have more than 25 parameters.');
      }

      for (final entry in params!.entries) {
        if (entry.key.length > 40) {
          throw ArgumentError('Parameter name can not exceed 40 characters.');
        } else if (entry.value is! num && entry.value.toString().length > 100) {
          throw ArgumentError('Parameter value can not exceed 100 characters.');
        }
      }
    }
  }

  final String name;
  final Map<String, dynamic>? params;

  @override
  List<Object?> get props => [
        name,
        params,
      ];
}
