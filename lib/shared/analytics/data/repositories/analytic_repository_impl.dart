import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:pokedex/shared/analytics/domain/entities/event.dart';
import 'package:pokedex/shared/analytics/domain/repositories/analytic_respository.dart';

class AnalyticRepositoryImpl extends AnalyticRepository {
  final FirebaseAnalytics firebaseAnalytics = FirebaseAnalytics.instance;

  @override
  Future<void> logEvent(Event event) async {
    await firebaseAnalytics.logEvent(
      name: event.name,
      parameters: event.params,
    );
  }
}
