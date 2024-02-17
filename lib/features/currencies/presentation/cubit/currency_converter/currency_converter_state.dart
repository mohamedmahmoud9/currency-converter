part of 'currency_converter_cubit.dart';

class CurrencyConverterState extends Equatable {
  final double exchangeRate;
  const CurrencyConverterState({required this.exchangeRate});

  @override
  List<Object> get props => [exchangeRate];
}

class CurrencyConverterLoading extends CurrencyConverterState {
  const CurrencyConverterLoading() : super(exchangeRate: 1);
}

class CurrencyConverterError extends CurrencyConverterState {
  final String message;
  const CurrencyConverterError({required this.message})
      : super(exchangeRate: 1);
}

class CurrencyConverterLoaded extends CurrencyConverterState {
  const CurrencyConverterLoaded({required super.exchangeRate});
}
