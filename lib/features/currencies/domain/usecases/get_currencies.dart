import 'package:dartz/dartz.dart';

import '../../../../core/error/failures.dart';
import '../../../../core/usecases/usecases.dart';
import '../entities/currency.dart';
import '../repositories/currencies_repositroy.dart';

class GetCurrencies extends UseCase<List<Currency>, NoParams> {
  final CurrenciesRepository repository;

  GetCurrencies({required this.repository});
  @override
  Future<Either<Failure, List<Currency>>> call(NoParams params) =>
      repository.getCurrencies();
}
