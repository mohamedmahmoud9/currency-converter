import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

import '../../../../../core/error/failures.dart';
import '../../../domain/entities/currency.dart';
import '../../../domain/entities/exchange_result.dart';
import '../../../domain/usecases/exchange_currency.dart';

part 'currency_converter_state.dart';

class CurrencyConverterCubit extends Cubit<CurrencyConverterState> {
  final ExchangeCurrency exchangeCurrency;
  CurrencyConverterCubit({required this.exchangeCurrency})
      : super(const CurrencyConverterState(exchangeRate: 1));

  Currency? selectedBaseCurrency;
  Currency? selectedTargetCurrency;
  void selectBaseCurrency(Currency currency) {
    selectedBaseCurrency = currency;
    getExchangeRateEvent();
  }

  void selectTargetCurrency(Currency currency) {
    selectedTargetCurrency = currency;
    getExchangeRateEvent();
  }

  Future<void> getExchangeRateEvent() async {
    if (selectedBaseCurrency == null || selectedTargetCurrency == null) {
      return;
    }
    emit(const CurrencyConverterLoading());
    final Either<Failure, ExchangeResult> result = await exchangeCurrency(
        ExchangeCurrencyParams(
            base: selectedBaseCurrency!, target: selectedTargetCurrency!));
    result.fold(
      (failure) => emit(CurrencyConverterError(message: failure.message)),
      (exchangeResult) {
        emit(
            CurrencyConverterLoaded(exchangeRate: exchangeResult.exchangeRate));
        onBaseChanged();
      },
    );
  }

  TextEditingController baseController = TextEditingController();
  TextEditingController targetController = TextEditingController();
  void onBaseChanged() {
    final double exchangeRate = state.exchangeRate;
    final double? baseValue = double.tryParse(baseController.text);
    if (baseValue != null) {
      targetController.text = (baseValue * exchangeRate).toString();
    }
  }

  void onTargetChanged() {
    final double exchangeRate = 1 / state.exchangeRate;
    final double? targetValue = double.tryParse(targetController.text);
    if (targetValue != null) {
      baseController.text = (targetValue * exchangeRate).toString();
    }
  }
}
