import 'package:bloc/bloc.dart';
import 'package:exchange_app/models/exchange_rate_entity.dart';
import 'package:flutter/cupertino.dart';
import 'package:meta/meta.dart';

import '../../../repositories/exchange_rate_repo/exchange_rate_repo.dart';

part 'home_state.dart';

class HomeCubit extends Cubit<HomeState> {
  final ExchangeRateRepo exchangeRateRepo;

  HomeCubit({required this.exchangeRateRepo}) : super(HomeInitial());

  TextEditingController fromDateController = TextEditingController();
  TextEditingController toDateController = TextEditingController();
  String? baseCurrency = "USD"; // Default base currency
  String? targetCurrency = "EGP"; // Default target currency

  // the api does not support pagination
  getExchangeRate() async {
    emit(GetExchangeRateLoadingState());
    var response = await exchangeRateRepo.getExchangeRate(
        startDate: fromDateController.text,
        endDate: toDateController.text,
        baseCurrency: baseCurrency!,
        targetCurrency: targetCurrency!);
    response.fold((failure) {
      emit(GetExchangeRateFailureState(message: failure.message));
    }, (exchangeRate) {
      emit(GetExchangeRateSuccessState(data: exchangeRate));
    });
  }

  @override
  Future<void> close() {
    fromDateController.dispose();
    toDateController.dispose();
    return super.close();
  }
}
