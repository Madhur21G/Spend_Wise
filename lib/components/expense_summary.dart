import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:spend_wise/bar%20graph/bar_graph.dart';
import 'package:spend_wise/data/expense_data.dart';
import 'package:spend_wise/datetime/date_time_helper.dart';

class ExpenseSummary extends StatelessWidget {
  final DateTime startOfWeek;
  const ExpenseSummary({
    super.key,
    required this.startOfWeek,
  });

  double calculateMax(
      ExpenseData value,
      String sunday,
      String monday,
      String tuesday,
      String wednesday,
      String thursday,
      String friday,
      String saturday,
  ){
    double? max = 100;

    List<double> values = [
      value.calculatedailyExpenseSummary()[sunday] ?? 0,
      value.calculatedailyExpenseSummary()[monday] ?? 0,
      value.calculatedailyExpenseSummary()[tuesday] ?? 0,
      value.calculatedailyExpenseSummary()[wednesday] ?? 0,
      value.calculatedailyExpenseSummary()[thursday] ?? 0,
      value.calculatedailyExpenseSummary()[friday] ?? 0,
      value.calculatedailyExpenseSummary()[saturday] ?? 0,
    ];
    values.sort();
    max = values.last * 1.1;
    return max == 0 ? 100 : max;
  }

  String calculateWeekTotal(
      ExpenseData value,
      String sunday,
      String monday,
      String tuesday,
      String wednesday,
      String thursday,
      String friday,
      String saturday,
  ) {
    List<double> values = [
      value.calculatedailyExpenseSummary()[sunday] ?? 0,
      value.calculatedailyExpenseSummary()[monday] ?? 0,
      value.calculatedailyExpenseSummary()[tuesday] ?? 0,
      value.calculatedailyExpenseSummary()[wednesday] ?? 0,
      value.calculatedailyExpenseSummary()[thursday] ?? 0,
      value.calculatedailyExpenseSummary()[friday] ?? 0,
      value.calculatedailyExpenseSummary()[saturday] ?? 0,
    ];

    double total = 0;
    for(int i = 0; i < values.length; i++){
      total += values[i];
    }
    return total.toStringAsFixed(2);
  }

  @override
  Widget build(BuildContext context) {

    String sunday =
      convertDateTimetoString(startOfWeek.add(const Duration(days: 0)));
    String monday =
      convertDateTimetoString(startOfWeek.add(const Duration(days: 1)));
    String tuesday =
      convertDateTimetoString(startOfWeek.add(const Duration(days: 2)));
    String wednesday =
      convertDateTimetoString(startOfWeek.add(const Duration(days: 3)));
    String thursday =
      convertDateTimetoString(startOfWeek.add(const Duration(days: 4)));
    String friday =
      convertDateTimetoString(startOfWeek.add(const Duration(days: 5)));
    String saturday =
      convertDateTimetoString(startOfWeek.add(const Duration(days: 6)));

    return Consumer<ExpenseData>(
        builder: (context,value,child) => Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(25.0),
              child: Row(
                children: [
                  const Text(
                    'Week Total: ',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  Text('\$${calculateWeekTotal(value, sunday, monday, tuesday, wednesday, thursday, friday, saturday)}'),
                ],
              ),
            ),
            SizedBox(
              height: 200,
              child: MyBarGraph(
                  maxY: calculateMax(value, sunday, monday, tuesday, wednesday,
                      thursday, friday, saturday),
                  sunAmount: value.calculatedailyExpenseSummary()[sunday] ?? 0,
                  monAmount: value.calculatedailyExpenseSummary()[monday] ?? 0,
                  tuesAmount: value.calculatedailyExpenseSummary()[tuesday] ?? 0,
                  wedAmount: value.calculatedailyExpenseSummary()[wednesday] ?? 0,
                  thursAmount: value.calculatedailyExpenseSummary()[thursday] ?? 0,
                  friAmount: value.calculatedailyExpenseSummary()[friday] ?? 0,
                  satAmount: value.calculatedailyExpenseSummary()[saturday] ?? 0,
              ),
            ),
          ],
        ),
    );
  }
}
