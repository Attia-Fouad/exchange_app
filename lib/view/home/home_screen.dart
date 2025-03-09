import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../core/services/services_locator.dart';
import 'cubit/home_cubit.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => sl<HomeCubit>(),
      // ..getExchangeRate(startDate: "2024-12-01", endDate: "2025-01-04", baseCurrency: "usd", targetCurrency: "egp"),
      child: BlocConsumer<HomeCubit, HomeState>(
        listener: (context, state) {
          if(state is GetExchangeRateSuccessState)
            {
              print("data succesfuly coem ${state.data.length}");
              print("data is  ${state.data}");
            }

        },
        builder: (context, state) {
          return Scaffold(
            body: Column(
              children: [
                ElevatedButton(onPressed: (){

                }, child: Text("test")),
              ],
            ),
          );
        },
      ),
    );
  }
}
