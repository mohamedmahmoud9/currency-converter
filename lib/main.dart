import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'core/styles/app_theme.dart';
import 'features/currencies/currencies_inject.dart';
import 'features/currencies/presentation/pages/currency_converter_app.dart';
import 'injection_container.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await ServiceLocator.init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [...currenciesBlocProviders()],
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: MaterialAppTheme.mainThemeData,
        home: const CurrencyConverterApp(),
      ),
    );
  }
}
