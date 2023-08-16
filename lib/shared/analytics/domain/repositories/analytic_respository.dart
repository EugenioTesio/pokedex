import 'package:pokedex/shared/analytics/domain/entities/event.dart';

abstract class AnalyticRepository {
  Future<void> logEvent(Event event);
}
