import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import '../../core/networks/failures.dart';
import '../../core/networks/remote/api_constants.dart';
import '../../core/networks/remote/dio_helper.dart';
import '../../models/exchange_rate_entity.dart';
import '../../models/exchange_rate_model.dart';
import 'exchange_rate_repo.dart';

class ExchangeRateRepoImpl implements ExchangeRateRepo {
  final DioHelper dioHelper;

  ExchangeRateRepoImpl({required this.dioHelper});

  @override
  Future<Either<Failure, List<ExchangeRateDataEntity>>> getExchangeRate(
      {required String startDate,
      required String endDate,
      required String baseCurrency,
      required String targetCurrency}) async {
    try {
      var response = await dioHelper.getData(
        url: ApiConstants.exchangeRate,
        query: {
          'start_date': startDate,
          'end_date': endDate,
          'source': baseCurrency.toUpperCase(),
          'access_key': ApiConstants.accessKey,
        },
      );
      if (response.statusCode == 200) {
        ExchangeRateModel model = ExchangeRateModel.fromJson(
            json: response.data,
            baseCurrency: baseCurrency,
            targetCurrency: targetCurrency);

        return right(model.data);
      }
    } catch (error) {
      if (error is DioException) {
        return left(ServerFailure.fromDioError(error));
      }
      if (kDebugMode) {
        print("Error when getExchangeRate $error");
      }
    }
    return left(ServerFailure('insufficient data'));
  }
}
