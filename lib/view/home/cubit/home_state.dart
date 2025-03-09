part of 'home_cubit.dart';

@immutable
sealed class HomeState {}

final class HomeInitial extends HomeState {}

final class GetExchangeRateLoadingState extends HomeState {}

final class GetExchangeRateSuccessState extends HomeState {
  final List<ExchangeRateDataEntity> data;

  GetExchangeRateSuccessState({required this.data});
}

final class GetExchangeRateFailureState extends HomeState {
  final String message;

  GetExchangeRateFailureState({required this.message});
}
