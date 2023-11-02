import 'package:bloc/bloc.dart';
import 'package:expense_trucker/datetime/date_time_helper.dart';
import 'package:expense_trucker/models/expense_item.dart';
import 'package:expense_trucker/shared/cubit/states.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AppCubit extends Cubit<AppStates> {
  AppCubit() : super(AppInitialState());

  static AppCubit get(context) => BlocProvider.of(context);

  //List of expenses
  List<ExpenseItem> overAllExpense = [];
  // get all expenses
  List<ExpenseItem> getExpenseList() {
    return overAllExpense;
  }

  //add new expenses
  void addNewExpense(ExpenseItem newExpense) {
    overAllExpense.add(newExpense);
  }

  // delete expenses
  void deleteExpense(ExpenseItem expense) {
    overAllExpense.remove(expense);
  }
  // get weekyday from DateTime object

  String getDayName(DateTime dateTime) {
    switch (dateTime.weekday) {
      case 1:
        return 'Mon';
      case 2:
        return 'Tus';
      case 3:
        return 'Wed';
      case 4:
        return 'Thu';
      case 5:
        return 'Fri';
      case 6:
        return 'Sat';
      case 7:
        return 'Sun';
      default:
        return '';
    }
  }

  //get the sunday
  DateTime startOfWeekDate() {
    DateTime? startOfWeek;
    DateTime today = DateTime.now();
    // go Backwards to get sunday
    for (var i = 0; i < 7; i++) {
      if (getDayName(today.subtract(Duration(days: i))) == 'Sun') {
        startOfWeek = today.subtract(Duration(days: i));
      }
    }
    return startOfWeek!;
  }
  //Convert overallexpenses to daily summary expenses [food ,2023/10/2 ,20] into [2023/10/2 : 20]

  calculateDailysummary() {
    Map<String, double> dailySummary = {
      //datTime (yyyymmdd) : amount
    };
    for (var expense in overAllExpense) {
      String date = convertDateTimeToString(expense.dateTime!);
      double amount = double.parse(expense.amount!);
      if (dailySummary.containsKey(date)) {
        var currentAmount = dailySummary[date]!;
        currentAmount += amount;
        dailySummary[date] = currentAmount;
      } else {
        dailySummary.addAll({date: amount});
      }
    }
    return dailySummary;
  }

  TextEditingController expenseName = TextEditingController();
  TextEditingController expenseAmount = TextEditingController();

  void clear() {
    expenseName.clear();
    expenseAmount.clear();
  }

  saveButton(context) {
    ExpenseItem newExpense = ExpenseItem(name: expenseName.text, amount: expenseAmount.text, dateTime: DateTime.now());
    addNewExpense(newExpense);
    emit(AppSaveExpense());
    Navigator.pop(context);
    clear();
  }

  cancelButton(context) {
    Navigator.pop(context);
    emit(AppCancelExpense());
    clear();
  }
}
