import 'package:pokedex/shared/analytics/domain/entities/event.dart';
import 'package:pokedex/shared/analytics/domain/repositories/analytic_respository.dart';

class FakeAnalyticsRepository extends AnalyticRepository {
  @override
  Future<void> logEvent(Event event) async {
    return;
  }
}
