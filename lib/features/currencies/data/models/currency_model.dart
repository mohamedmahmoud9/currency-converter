import 'dart:convert';

import '../../domain/entities/currency.dart';

class CurrencyModel extends Currency {
  const CurrencyModel(
      {required super.code,
      required super.name,
      required super.flagImage,
      required super.symbol,
      required super.symbolNative,
      required super.decimalDigits,
      required super.rounding,
      required super.namePlural});

  CurrencyModel copyWith({
    String? symbol,
    String? name,
    String? symbolNative,
    int? decimalDigits,
    int? rounding,
    String? code,
    String? flagImage,
    String? namePlural,
  }) =>
      CurrencyModel(
        symbol: symbol ?? this.symbol,
        name: name ?? this.name,
        flagImage: flagImage ?? this.flagImage,
        symbolNative: symbolNative ?? this.symbolNative,
        decimalDigits: decimalDigits ?? this.decimalDigits,
        rounding: rounding ?? this.rounding,
        code: code ?? this.code,
        namePlural: namePlural ?? this.namePlural,
      );

  factory CurrencyModel.fromRawJson(String str) =>
      CurrencyModel.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory CurrencyModel.fromJson(Map<String, dynamic> json) => CurrencyModel(
        symbol: json["symbol"],
        name: json["name"],
        symbolNative: json["symbol_native"],
        decimalDigits: json["decimal_digits"],
        rounding: json["rounding"],
        code: json["code"],
        namePlural: json["name_plural"],
        flagImage:
            'https://flagcdn.com/48x36/${countriesCodes[json["code"]]}.png'
                .toLowerCase(),
      );

  Map<String, dynamic> toJson() => {
        "symbol": symbol,
        "name": name,
        "symbol_native": symbolNative,
        "decimal_digits": decimalDigits,
        "rounding": rounding,
        "code": code,
        "name_plural": namePlural,
      };
}

Map<String, String> countriesCodes = {
  "EUR": "EU",
  "USD": "US",
  "JPY": "JP",
  "BGN": "BG",
  "CZK": "CZ",
  "DKK": "DK",
  "GBP": "GB",
  "HUF": "HU",
  "PLN": "PL",
  "RON": "RO",
  "SEK": "SE",
  "CHF": "CH",
  "ISK": "IS",
  "NOK": "NO",
  "HRK": "HR",
  "RUB": "RU",
  "TRY": "TR",
  "AUD": "AU",
  "BRL": "BR",
  "CAD": "CA",
  "CNY": "CN",
  "HKD": "HK",
  "IDR": "ID",
  "ILS": "IL",
  "INR": "IN",
  "KRW": "KR",
  "MXN": "MX",
  "MYR": "MY",
  "NZD": "NZ",
  "PHP": "PH",
  "SGD": "SG",
  "THB": "TH",
  "ZAR": "ZA"
};
