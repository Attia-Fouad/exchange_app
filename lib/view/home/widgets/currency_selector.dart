import 'package:exchange_app/core/app_strings/app_strings.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../core/supported_currencies.dart';
import '../cubit/home_cubit.dart';

class CurrencySelector extends StatefulWidget {
  const CurrencySelector({super.key});

  @override
  State<CurrencySelector> createState() => _CurrencySelectorState();
}

class _CurrencySelectorState extends State<CurrencySelector> {
  @override
  Widget build(BuildContext context) {
    var cubit = BlocProvider.of<HomeCubit>(context);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Base Currency Dropdown
        Text(AppStrings.fromCurrency),
        DropdownButton<String>(
          value: cubit.baseCurrency,
          onChanged: (String? newValue) {
            setState(() {
              cubit.baseCurrency = newValue;
            });
          },
          items: currencies.keys.map((String currency) {
            return DropdownMenuItem<String>(
              value: currency,
              child: Text("$currency - ${currencies[currency]}"),
            );
          }).toList(),
        ),
        SizedBox(height: 20),

        // Target Currency Dropdown
        Text(AppStrings.toCurrency),
        DropdownButton<String>(
          value: cubit.targetCurrency,
          onChanged: (String? newValue) {
            setState(() {
              cubit.targetCurrency = newValue;
            });
          },
          items: currencies.keys.map((String currency) {
            return DropdownMenuItem<String>(
              value: currency,
              child: Text("$currency - ${currencies[currency]}"),
            );
          }).toList(),
        ),
      ],
    );
  }
}
