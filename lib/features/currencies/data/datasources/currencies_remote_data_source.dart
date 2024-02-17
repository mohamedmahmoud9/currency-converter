import 'package:intl/intl.dart';

import '../../../../core/util/api_basehelper.dart';
import '../../domain/entities/currency.dart';
import '../models/currency_model.dart';
import '../models/exchange_result_model.dart';
import '../models/historical_exchange_rate_model.dart';

abstract class CurrenciesRemoteDataSource {
  Future<List<CurrencyModel>> getCurrencies();
  Future<ExchangeResultModel> exchangeCurrencies(
      {required Currency base, required Currency target});
  Future<List<HistoricalExchangeRateModel>> getHistoricalExchangeRates();
}

class CurrenciesRemoteDataSourceImpl implements CurrenciesRemoteDataSource {
  final ApiBaseHelper apiBaseHelper;

  CurrenciesRemoteDataSourceImpl({required this.apiBaseHelper});
  @override
  Future<List<CurrencyModel>> getCurrencies() async {
    try {
      final data = await apiBaseHelper.get(url: '/currencies');
      return (data['data'] as Map<String, dynamic>)
          .entries
          .map((e) => CurrencyModel.fromJson(e.value))
          .toList();
    } catch (error) {
      rethrow;
    }
  }

  @override
  Future<ExchangeResultModel> exchangeCurrencies(
      {required Currency base, required Currency target}) async {
    try {
      final data = await apiBaseHelper.get(url: '/latest', queryParameters: {
        'base_currency': base.code,
        'currencies': target.code
      });
      return ExchangeResultModel(
          exchangeRate: (data['data'][target.code] as num).toDouble());
    } catch (error) {
      rethrow;
    }
  }

  @override
  Future<List<HistoricalExchangeRateModel>> getHistoricalExchangeRates() async {
    try {
      final data = await Future.wait(List.generate(
          7,
          (index) => apiBaseHelper.get(url: '/historical', queryParameters: {
                'base_currency': 'USD',
                'date': DateFormat(
                  'yyyy-MM-dd',
                ).format(DateTime.now().subtract(Duration(days: 7 - index))),
                'currencies': 'EUR'
              })));
      List<HistoricalExchangeRateModel> response = [];
      for (var element in data) {
        response.addAll((element['data'] as Map<String, dynamic>).entries.map(
            (e) => HistoricalExchangeRateModel(
                date: DateTime.parse(e.key),
                exchangeRate: (e.value['EUR'] as num).toDouble())));
      }
      return response.reversed.toList();
    } catch (error) {
      rethrow;
    }
  }
}
