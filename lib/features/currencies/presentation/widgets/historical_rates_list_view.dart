import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

import '../../../../core/styles/values/colors.dart';
import '../cubit/historical_exchange/historical_exchange_cubit.dart';

class HistoricalRatesListView extends StatelessWidget {
  const HistoricalRatesListView({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
        decoration: const BoxDecoration(
            color: AppColors.white,
            borderRadius: BorderRadius.vertical(top: Radius.circular(20))),
        child: BlocBuilder<HistoricalExchangeCubit, HistoricalExchangeState>(
          builder: (context, state) {
            if (state is HistoricalExchangeError) {
              return Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Text(
                    state.message,
                    textAlign: TextAlign.center,
                  ),
                  IconButton(
                      onPressed: () {
                        context
                            .read<HistoricalExchangeCubit>()
                            .getHistoricalExchangeRatesEvent();
                      },
                      icon: const Icon(Icons.refresh))
                ],
              );
            }
            if (state is HistoricalExchangeLoading) {
              return const Center(
                child: CircularProgressIndicator.adaptive(),
              );
            }
            if (state is HistoricalExchangeLoaded) {
              return Column(
                children: [
                  const Text(
                    'Historical data for USD and EUR for the last 7 days',
                    style: TextStyle(
                      color: AppColors.primary,
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
                  ),
                  const SizedBox(
                    height: 12,
                  ),
                  Expanded(
                    child: ListView.separated(
                      separatorBuilder: (context, index) => const Divider(
                        color: AppColors.primary,
                        thickness: .3,
                        height: 0,
                      ),
                      itemCount: state.historicalExchangeRates.length,
                      itemBuilder: (context, index) {
                        return ListTile(
                          title: Text(DateFormat.yMMMEd().format(
                              state.historicalExchangeRates[index].date)),
                          subtitle: Text(
                            "1 USD = ${state.historicalExchangeRates[index].exchangeRate.toStringAsFixed(2)} EUR",
                          ),
                        );
                      },
                    ),
                  ),
                ],
              );
            }
            return Container();
          },
        ),
      ),
    );
  }
}
