import 'package:dartz/dartz.dart';

import '../../../../core/error/failures.dart';
import '../../../../core/usecases/usecases.dart';
import '../entities/historical_exchange_rate.dart';
import '../repositories/currencies_repositroy.dart';

class GetHistoricalExchangeRates
    extends UseCase<List<HistoricalExchangeRate>, NoParams> {
  final CurrenciesRepository repository;
  GetHistoricalExchangeRates({required this.repository});
  @override
  Future<Either<Failure, List<HistoricalExchangeRate>>> call(
      NoParams params) async {
    return await repository.getHistoricalExchangeRates();
  }
}
