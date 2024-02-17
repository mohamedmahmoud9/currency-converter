import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../domain/entities/currency.dart';
import '../cubit/currencies_cubit.dart';

class CurrenciesDropDownList extends StatefulWidget {
  final Function(Currency) onChanged;
  const CurrenciesDropDownList({super.key, required this.onChanged});

  @override
  State<CurrenciesDropDownList> createState() => _CurrenciesDropDownListState();
}

class _CurrenciesDropDownListState extends State<CurrenciesDropDownList> {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CurrenciesCubit, CurrenciesState>(
      builder: (context, state) {
        if (state is CurrenciesLoading) {
          return const Center(
            child: CircularProgressIndicator.adaptive(),
          );
        }
        if (state is CurrenciesError) {
          return Column(
            children: [
              Text(state.message),
              IconButton(
                  onPressed: () {
                    context.read<CurrenciesCubit>().getCurrenciesEvent();
                  },
                  icon: const Icon(Icons.refresh))
            ],
          );
        }
        if (state is CurrenciesLoaded) {
          return DropdownButtonFormField<Currency>(
            isExpanded: true,
            items: state.currencies
                .map((currency) => DropdownMenuItem(
                      value: currency,
                      child: Row(
                        children: [
                          Image.network(
                            currency.flagImage,
                            width: 24,
                          ),
                          const SizedBox(
                            width: 8,
                          ),
                          Text(currency.code),
                        ],
                      ),
                    ))
                .toList(),
            onChanged: (value) {
              if (value != null) {
                widget.onChanged(value);
              }
            },
          );
        }
        return Container();
      },
    );
  }
}
