import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

import '../cubit/home_cubit.dart';

class DateSelector extends StatefulWidget {
  const DateSelector({super.key});

  @override
  State<DateSelector> createState() => _DateSelectorState();
}

class _DateSelectorState extends State<DateSelector> {
  @override
  Widget build(BuildContext context) {
    var cubit = BlocProvider.of<HomeCubit>(context);
    return Row(
      children: [
        // From Date
        Expanded(
          child: TextFormField(
            onTap: () => _selectDate(context, cubit.fromDateController),
            controller: cubit.fromDateController,
            decoration: InputDecoration(
              labelText: "From Date",
              suffixIcon: IconButton(
                icon: Icon(Icons.calendar_today),
                onPressed: () => _selectDate(context, cubit.fromDateController),
              ),
            ),
            readOnly: true,
          ),
        ),
        SizedBox(width: 10),

        // To Date
        Expanded(
          child: TextFormField(
            onTap: () => _selectDate(context, cubit.toDateController),
            controller: cubit.toDateController,
            decoration: InputDecoration(
              labelText: "To Date",
              suffixIcon: IconButton(
                icon: Icon(Icons.calendar_today),
                onPressed: () => _selectDate(context, cubit.toDateController),
              ),
            ),
            readOnly: true,
          ),
        ),
        SizedBox(width: 10),
      ],
    );
  }

  Future<void> _selectDate(
      BuildContext context, TextEditingController controller) async {
    DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime.now(),
    );

    if (picked != null) {
      setState(() {
        controller.text = DateFormat('yyyy-MM-dd').format(picked);
      });
    }
  }
}
