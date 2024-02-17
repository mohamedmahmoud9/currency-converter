import '../../domain/entities/historical_exchange_rate.dart';

class HistoricalExchangeRateModel extends HistoricalExchangeRate {
  HistoricalExchangeRateModel({
    required super.date,
    required super.exchangeRate,
  });
}
