import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pokedex/shared/analytics/data/repositories/analytic_repository_impl.dart';
import 'package:pokedex/shared/analytics/domain/repositories/analytic_respository.dart';

final analyticRepositoryProvider = Provider<AnalyticRepository>(
  (ref) {
    return AnalyticRepositoryImpl();
  },
);
