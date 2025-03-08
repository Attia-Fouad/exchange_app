import 'exchange_rate_entity.dart';

class ExchangeRateModel {
  final bool success;
  final String startDate;
  final String endDate;
  final String source;
  // final Map<String, Map<String, double>> quotes;
  final List<ExchangeRateDataEntity> data;

 const ExchangeRateModel({
    required this.success,
    required this.startDate,
    required this.endDate,
    required this.source,
    // required this.quotes,
    required this.data,
  });

  factory ExchangeRateModel.fromJson(Map<String, dynamic> json) {
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
        final currencyValue = currencies["USDEGP"]?.toDouble();
        // Handle null values if currencyValue does not exist
        if (currencyValue == null) return null;

        return ExchangeRateDataEntity(
          date: date,
          baseCurrency: "USD",
          targetCurrency: "EGP",
          value: currencyValue.toString(), // Convert to String if needed
        );
      })
          .where((entry) => entry != null) // Remove null entries
          .cast<ExchangeRateDataEntity>() // Ensure it's a List<ExchangeRateDataEntity>
          .toList(),

      // quotes: (json["quotes"] as Map<String, dynamic>).map((date, currencies) {
      //   return MapEntry(
      //     date,
      //     (currencies as Map<String, dynamic>)
      //         .map((key, value) => MapEntry(key, value.toDouble())),
      //   );
      // }),
    );
  }

}