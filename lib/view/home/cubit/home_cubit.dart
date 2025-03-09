import 'package:bloc/bloc.dart';
import 'package:exchange_app/models/exchange_rate_entity.dart';
import 'package:meta/meta.dart';

import '../../../repositories/exchange_rate_repo/exchange_rate_repo.dart';

part 'home_state.dart';

class HomeCubit extends Cubit<HomeState> {
  final ExchangeRateRepo exchangeRateRepo;

  HomeCubit({required this.exchangeRateRepo}) : super(HomeInitial());

  getExchangeRate(
      {required String startDate,
      required String endDate,
      required String baseCurrency,
      required String targetCurrency}) async {
    emit(GetExchangeRateLoadingState());
    var response = await exchangeRateRepo.getExchangeRate(
        startDate: startDate,
        endDate: endDate,
        baseCurrency: baseCurrency,
        targetCurrency: targetCurrency);
    response.fold((failure) {
      emit(GetExchangeRateFailureState(message: failure.message));
    }, (exchangeRate) {
      emit(GetExchangeRateSuccessState(data: exchangeRate));
    });
  }
}
