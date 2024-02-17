import 'package:dartz/dartz.dart';

import '../../../../core/error/exceptions.dart';
import '../../../../core/error/failures.dart';
import '../../domain/entities/currency.dart';
import '../../domain/entities/exchange_result.dart';
import '../../domain/entities/historical_exchange_rate.dart';
import '../../domain/repositories/currencies_repositroy.dart';
import '../datasources/currencies_local_data_source.dart';
import '../datasources/currencies_remote_data_source.dart';

class CurrenciesRepositoryImpl implements CurrenciesRepository {
  final CurrenciesRemoteDataSource remoteDataSource;
  final CurrenciesLocalDataSource localDataSource;

  CurrenciesRepositoryImpl({
    required this.remoteDataSource,
    required this.localDataSource,
  });
  @override
  Future<Either<Failure, List<Currency>>> getCurrencies() async {
    try {
      final currencies = await localDataSource.getCurrencies();
      if (currencies != null) {
        return right(currencies);
      } else {
        final currencies = await remoteDataSource.getCurrencies();
        await localDataSource.cacheCurrencies(currencies);
        return right(currencies);
      }
    } on ServerException catch (error) {
      return left(ServerFailure.formServerException(error));
    } on CacheException catch (_) {
      return left(const CacheFailure(message: 'Unable to get data'));
    }
  }

  @override
  Future<Either<Failure, ExchangeResult>> exchangeCurrencies(
      {required Currency base, required Currency target}) async {
    try {
      final exchangeResult =
          await remoteDataSource.exchangeCurrencies(base: base, target: target);
      return right(exchangeResult);
    } on ServerException catch (error) {
      return left(ServerFailure.formServerException(error));
    } on CacheException catch (_) {
      return left(const CacheFailure(message: 'Unable to get data'));
    }
  }

  @override
  Future<Either<Failure, List<HistoricalExchangeRate>>>
      getHistoricalExchangeRates() async {
    try {
      final historicalExchangeResult =
          await remoteDataSource.getHistoricalExchangeRates();
      return right(historicalExchangeResult);
    } on ServerException catch (error) {
      return left(ServerFailure.formServerException(error));
    } on CacheException catch (_) {
      return left(const CacheFailure(message: 'Unable to get data'));
    }
  }
}
