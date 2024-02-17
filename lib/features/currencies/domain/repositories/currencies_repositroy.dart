import 'package:dartz/dartz.dart';

import '../../../../core/error/failures.dart';
import '../entities/currency.dart';
import '../entities/exchange_result.dart';
import '../entities/historical_exchange_rate.dart';

abstract class CurrenciesRepository {
  Future<Either<Failure, List<Currency>>> getCurrencies();

  Future<Either<Failure, ExchangeResult>> exchangeCurrencies(
      {required Currency base, required Currency target});
  Future<Either<Failure, List<HistoricalExchangeRate>>>
      getHistoricalExchangeRates();
}
