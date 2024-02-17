import 'package:shared_preferences/shared_preferences.dart';

import '../../../../core/error/exceptions.dart';
import '../models/currency_model.dart';

abstract class CurrenciesLocalDataSource {
  Future<List<CurrencyModel>?> getCurrencies();

  Future<bool> cacheCurrencies(List<CurrencyModel> currencies);
}

const currenciesKey = 'CURRENCIES';

class CurrenciesLocalDataSourceImpl implements CurrenciesLocalDataSource {
  final SharedPreferences sharedPreferences;

  CurrenciesLocalDataSourceImpl({required this.sharedPreferences});
  @override
  Future<List<CurrencyModel>?> getCurrencies() async {
    try {
      final currencies = sharedPreferences.getStringList(currenciesKey);
      return currencies?.map((e) => CurrencyModel.fromRawJson(e)).toList();
    } catch (error) {
      throw CacheException();
    }
  }

  @override
  Future<bool> cacheCurrencies(List<CurrencyModel> currencies) async {
    try {
      return await sharedPreferences.setStringList(
          currenciesKey, currencies.map((e) => e.toRawJson()).toList());
    } catch (error) {
      throw CacheException();
    }
  }
}
