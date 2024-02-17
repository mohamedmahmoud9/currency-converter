import 'package:flutter/material.dart';

import '../../../../core/styles/values/colors.dart';
import '../widgets/currency_calulator.dart';
import '../widgets/historical_rates_list_view.dart';

class CurrencyConverterApp extends StatefulWidget {
  const CurrencyConverterApp({super.key});

  @override
  State<CurrencyConverterApp> createState() => _CurrencyConverterAppState();
}

class _CurrencyConverterAppState extends State<CurrencyConverterApp> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: AppColors.primary,
        appBar: AppBar(
          title: const Text('Currency Converter'),
        ),
        body: const Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [CurrencyCalulator(), HistoricalRatesListView()],
        ));
  }
}
