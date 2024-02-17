import 'package:flutter_bloc/flutter_bloc.dart';

import '../../injection_container.dart';
import 'data/datasources/currencies_local_data_source.dart';
import 'data/datasources/currencies_remote_data_source.dart';
import 'data/repositories/currencies_repository_impl.dart';
import 'domain/repositories/currencies_repositroy.dart';
import 'domain/usecases/exchange_currency.dart';
import 'domain/usecases/get_currencies.dart';
import 'domain/usecases/get_historical_exchange_rate.dart';
import 'presentation/cubit/currencies_cubit.dart';
import 'presentation/cubit/currency_converter/currency_converter_cubit.dart';
import 'presentation/cubit/historical_exchange/historical_exchange_cubit.dart';

void currenciesServiceLocator() {
  // Blocs
  sl.registerLazySingleton<CurrenciesCubit>(() => CurrenciesCubit(
        getCurrencies: sl(),
      ));
  sl.registerLazySingleton<CurrencyConverterCubit>(() => CurrencyConverterCubit(
        exchangeCurrency: sl(),
      ));
  sl.registerLazySingleton<HistoricalExchangeCubit>(
      () => HistoricalExchangeCubit(
            getHistoricalExchangeRates: sl(),
          ));
  // UseCases
  sl.registerLazySingleton<GetCurrencies>(
      () => GetCurrencies(repository: sl()));
  sl.registerLazySingleton<ExchangeCurrency>(
      () => ExchangeCurrency(repository: sl()));
  sl.registerLazySingleton<GetHistoricalExchangeRates>(
      () => GetHistoricalExchangeRates(repository: sl()));
  // Repository
  sl.registerLazySingleton<CurrenciesRepository>(() =>
      CurrenciesRepositoryImpl(remoteDataSource: sl(), localDataSource: sl()));
  // Data Sources
  sl.registerLazySingleton<CurrenciesRemoteDataSource>(
      () => CurrenciesRemoteDataSourceImpl(apiBaseHelper: sl()));
  sl.registerLazySingleton<CurrenciesLocalDataSource>(
      () => CurrenciesLocalDataSourceImpl(sharedPreferences: sl()));
}

List<BlocProvider> currenciesBlocProviders() {
  return [
    BlocProvider<CurrenciesCubit>(
      create: (context) => sl<CurrenciesCubit>()..getCurrenciesEvent(),
    ),
    BlocProvider<CurrencyConverterCubit>(
      create: (context) => sl<CurrencyConverterCubit>(),
    ),
    BlocProvider<HistoricalExchangeCubit>(
      create: (context) =>
          sl<HistoricalExchangeCubit>()..getHistoricalExchangeRatesEvent(),
    ),
  ];
}
