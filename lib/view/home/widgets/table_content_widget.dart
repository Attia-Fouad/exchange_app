import 'package:flutter/material.dart';

import '../../../core/app_strings/app_strings.dart';
import '../../../models/exchange_rate_entity.dart';

class TableContentWidget extends StatelessWidget {
  final List<ExchangeRateDataEntity> data;

  const TableContentWidget({
    super.key,
    required this.data,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: DataTable(
          columns: const [
            DataColumn(label: Text(AppStrings.date)),
            DataColumn(label: Text(AppStrings.from)),
            DataColumn(label: Text(AppStrings.to)),
            DataColumn(label: Text(AppStrings.price)),
          ],
          rows: data.map((data) {
            return DataRow(cells: [
              DataCell(Text(data.date)),
              DataCell(Text(data.baseCurrency)),
              DataCell(Text(data.targetCurrency)),
              DataCell(Text(data.value)),
            ]);
          }).toList(),
        ),
      ),
    );
  }
}
