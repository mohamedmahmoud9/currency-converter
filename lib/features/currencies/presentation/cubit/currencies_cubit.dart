import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';

import '../../../../core/error/failures.dart';
import '../../../../core/usecases/usecases.dart';
import '../../domain/entities/currency.dart';
import '../../domain/usecases/get_currencies.dart';

part 'currencies_state.dart';

class CurrenciesCubit extends Cubit<CurrenciesState> {
  final GetCurrencies getCurrencies;
  CurrenciesCubit({required this.getCurrencies}) : super(CurrenciesInitial());

  Future<void> getCurrenciesEvent() async {
    emit(CurrenciesLoading());
    final Either<Failure, List<Currency>> result =
        await getCurrencies(NoParams());
    result.fold(
      (failure) => emit(CurrenciesError(message: failure.message)),
      (currencies) => emit(CurrenciesLoaded(currencies: currencies)),
    );
  }
}
