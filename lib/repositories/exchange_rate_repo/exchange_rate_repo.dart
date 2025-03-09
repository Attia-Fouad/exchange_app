import 'package:dartz/dartz.dart';
import 'package:exchange_app/models/exchange_rate_entity.dart';
import '../../core/networks/failures.dart';

abstract class ExchangeRateRepo {
  Future<Either<Failure, List<ExchangeRateDataEntity>>> getExchangeRate({required String startDate, required String endDate, required String baseCurrency, required String targetCurrency});
}
