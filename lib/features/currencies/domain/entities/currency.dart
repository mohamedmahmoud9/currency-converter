import 'package:equatable/equatable.dart';

class Currency extends Equatable {
  final String symbol;
  final String flagImage;
  final String name;
  final String symbolNative;
  final int decimalDigits;
  final int rounding;
  final String code;
  final String namePlural;

  const Currency({
    required this.symbol,
    required this.name,
    required this.flagImage,
    required this.symbolNative,
    required this.decimalDigits,
    required this.rounding,
    required this.code,
    required this.namePlural,
  });
  @override
  List<Object?> get props => [
        symbol,
        name,
        symbolNative,
        decimalDigits,
        rounding,
        code,
        namePlural,
        flagImage
      ];
}
