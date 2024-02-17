part of 'currencies_cubit.dart';

abstract class CurrenciesState extends Equatable {
  const CurrenciesState();

  @override
  List<Object> get props => [];
}

class CurrenciesInitial extends CurrenciesState {}

class CurrenciesLoading extends CurrenciesState {}

class CurrenciesError extends CurrenciesState {
  final String message;

  const CurrenciesError({required this.message});
}

class CurrenciesLoaded extends CurrenciesState {
  final List<Currency> currencies;

  const CurrenciesLoaded({required this.currencies});
}
