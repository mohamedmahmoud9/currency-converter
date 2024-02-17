import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../domain/entities/currency.dart';
import '../cubit/currency_converter/currency_converter_cubit.dart';
import 'currencies_ddl.dart';

class CurrencyCalulator extends StatelessWidget {
  const CurrencyCalulator({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final converterCubit = context.read<CurrencyConverterCubit>();
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 24),
      child: Column(
        children: [
          Row(
            children: [
              Expanded(
                  flex: 3,
                  child: TextFormField(
                    decoration: const InputDecoration(
                      hintText: '0.0',
                    ),
                    controller: converterCubit.baseController,
                    onChanged: (value) => converterCubit.onBaseChanged(),
                  )),
              const SizedBox(
                width: 8,
              ),
              Expanded(
                  flex: 2,
                  child: CurrenciesDropDownList(
                    onChanged: (Currency value) {
                      converterCubit.selectBaseCurrency(value);
                    },
                  )),
            ],
          ),
          const SizedBox(
            height: 16,
          ),
          Row(
            children: [
              Expanded(
                  flex: 3,
                  child: TextFormField(
                    decoration: const InputDecoration(
                      hintText: '0.0',
                    ),
                    controller: converterCubit.targetController,
                    onChanged: (value) => converterCubit.onTargetChanged(),
                  )),
              const SizedBox(
                width: 8,
              ),
              Expanded(
                  flex: 2,
                  child: CurrenciesDropDownList(
                    onChanged: (Currency value) {
                      converterCubit.selectTargetCurrency(value);
                    },
                  )),
            ],
          ),
          const SizedBox(
            height: 16,
          ),
          BlocBuilder<CurrencyConverterCubit, CurrencyConverterState>(
            builder: (BuildContext context, CurrencyConverterState state) {
              if (state is CurrencyConverterError) {
                return Text(state.message);
              }
              return Visibility(
                visible: state is! CurrencyConverterLoading,
                replacement: const CircularProgressIndicator.adaptive(),
                child: ElevatedButton.icon(
                  onPressed: () {
                    converterCubit.getExchangeRateEvent();
                  },
                  icon: const Icon(Icons.refresh),
                  label: const Text('Refresh'),
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
