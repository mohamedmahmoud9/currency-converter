part of 'historical_exchange_cubit.dart';

sealed class HistoricalExchangeState extends Equatable {
  const HistoricalExchangeState();

  @override
  List<Object> get props => [];
}

final class HistoricalExchangeInitial extends HistoricalExchangeState {}

final class HistoricalExchangeLoading extends HistoricalExchangeState {
  const HistoricalExchangeLoading();
}

final class HistoricalExchangeLoaded extends HistoricalExchangeState {
  final List<HistoricalExchangeRate> historicalExchangeRates;

  const HistoricalExchangeLoaded({required this.historicalExchangeRates});
}

final class HistoricalExchangeError extends HistoricalExchangeState {
  final String message;

  const HistoricalExchangeError({required this.message});
}
