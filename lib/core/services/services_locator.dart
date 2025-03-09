import 'package:get_it/get_it.dart';
import '../../repositories/exchange_rate_repo/exchange_rate_repo.dart';
import '../../repositories/exchange_rate_repo/exchange_rate_repo_impl.dart';
import '../../view/home/cubit/home_cubit.dart';
import '../networks/remote/dio_helper.dart';

final sl = GetIt.instance;

class ServicesLocator {
  void init() {
    // cubits
    sl.registerFactory(() => HomeCubit(exchangeRateRepo: sl<ExchangeRateRepo>(),));

    //Repository
    sl.registerLazySingleton<ExchangeRateRepo>(() => ExchangeRateRepoImpl(dioHelper: sl<DioHelper>()));



    // dependencies
    sl.registerLazySingleton<DioHelper>(() => DioHelper());
  }
}
