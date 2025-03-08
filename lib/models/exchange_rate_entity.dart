class ExchangeRateDataEntity {
  final String date;
  final String baseCurrency;
  final String targetCurrency;
  final String value;

  const ExchangeRateDataEntity({
    required this.date,
    required this.baseCurrency,
    required this.targetCurrency,
    required this.value,
  });
}
