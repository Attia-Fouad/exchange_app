import 'exchange_rate_entity.dart';

class ExchangeRateModel {
  final bool success;
  final String startDate;
  final String endDate;
  final String source;
  final List<ExchangeRateDataEntity> data;

  const ExchangeRateModel({
    required this.success,
    required this.startDate,
    required this.endDate,
    required this.source,
    required this.data,
  });

  factory ExchangeRateModel.fromJson({
    required Map<String, dynamic> json,
    required String baseCurrency,
    required String targetCurrency,
  }) {
    return ExchangeRateModel(
      success: json["success"],
      startDate: json["start_date"],
      endDate: json["end_date"],
      source: json["source"],
      data: (json["quotes"] as Map<String, dynamic>)
          .entries
          .map((entry) {
            final date = entry.key; // Extract date
            final currencies = entry.value as Map<String, dynamic>;
            final currencyValue = currencies[
                    "${baseCurrency.toUpperCase()}${targetCurrency.toUpperCase()}"]
                ?.toDouble();
            // Handle null values if currencyValue does not exist
            if (currencyValue == null) return null;

            return ExchangeRateDataEntity(
              date: date,
              baseCurrency: baseCurrency.toUpperCase(),
              targetCurrency: targetCurrency.toUpperCase(),
              value: currencyValue.toString(), // Convert to String if needed
            );
          })
          .where((entry) => entry != null) // Remove null entries
          .cast<
              ExchangeRateDataEntity>() // Ensure it's a List<ExchangeRateDataEntity>
          .toList(),
    );
  }
}
