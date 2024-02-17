import 'package:dartz/dartz.dart';

import '../../../../core/error/failures.dart';
import '../../../../core/usecases/usecases.dart';
import '../entities/currency.dart';
import '../entities/exchange_result.dart';
import '../repositories/currencies_repositroy.dart';

class ExchangeCurrency extends UseCase<ExchangeResult, ExchangeCurrencyParams> {
  final CurrenciesRepository repository;

  ExchangeCurrency({required this.repository});
  @override
  Future<Either<Failure, ExchangeResult>> call(
      ExchangeCurrencyParams params) async {
    return await repository.exchangeCurrencies(
        base: params.base, target: params.target);
  }
}

class ExchangeCurrencyParams {
  final Currency base;
  final Currency target;

  ExchangeCurrencyParams({required this.base, required this.target});
}
