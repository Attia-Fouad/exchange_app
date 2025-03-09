import 'package:exchange_app/core/app_strings/app_strings.dart';
import 'package:exchange_app/core/shared_components.dart';
import 'package:exchange_app/view/home/widgets/currency_selector.dart';
import 'package:exchange_app/view/home/widgets/date_selector.dart';
import 'package:exchange_app/view/home/widgets/loading_widget.dart';
import 'package:exchange_app/view/home/widgets/table_content_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../core/services/services_locator.dart';
import 'cubit/home_cubit.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    late HomeCubit cubit;
    return BlocProvider(
      create: (context) => sl<HomeCubit>(),
      child: BlocConsumer<HomeCubit, HomeState>(
        listener: (context, state) {
          if (state is GetExchangeRateFailureState) {
            showToast(state: ToastStates.error, text: state.message);
          }
        },
        builder: (context, state) {
          cubit = BlocProvider.of<HomeCubit>(context);
          return Scaffold(
            appBar: AppBar(),
            body: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                children: [
                  // Currency Selector
                  CurrencySelector(),
                  // Date Input Fields
                  DateSelector(),
                  // Fetch Button
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        onPressed: () {
                          if (cubit.fromDateController.text.isNotEmpty &&
                              cubit.toDateController.text.isNotEmpty) {
                            cubit.getExchangeRate();
                          } else {
                            showToast(
                                state: ToastStates.error,
                                text: "Please select date");
                          }
                        },
                        child: Text(AppStrings.submit),
                      ),
                    ),
                  ),
                  if (state is GetExchangeRateSuccessState)
                    TableContentWidget(
                      data: state.data,
                    ),
                  if (state is GetExchangeRateLoadingState) LoadingWidget(),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
