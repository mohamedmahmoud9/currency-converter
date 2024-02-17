import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';

import '../../../../../core/error/failures.dart';
import '../../../../../core/usecases/usecases.dart';
import '../../../domain/entities/historical_exchange_rate.dart';
import '../../../domain/usecases/get_historical_exchange_rate.dart';

part 'historical_exchange_state.dart';

class HistoricalExchangeCubit extends Cubit<HistoricalExchangeState> {
  final GetHistoricalExchangeRates getHistoricalExchangeRates;
  HistoricalExchangeCubit({
    required this.getHistoricalExchangeRates,
  }) : super(HistoricalExchangeInitial());

  Future<void> getHistoricalExchangeRatesEvent() async {
    emit(const HistoricalExchangeLoading());
    final Either<Failure, List<HistoricalExchangeRate>> result =
        await getHistoricalExchangeRates(NoParams());
    result.fold(
      (failure) => emit(HistoricalExchangeError(message: failure.message)),
      (historicalExchangeRates) => emit(HistoricalExchangeLoaded(
          historicalExchangeRates: historicalExchangeRates)),
    );
  }
}
