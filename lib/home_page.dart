import 'package:expense_trucker/shared/components/components.dart';
import 'package:expense_trucker/shared/cubit/cubit.dart';
import 'package:expense_trucker/shared/cubit/states.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit, AppStates>(
      listener: (context, state) {
        // TODO: implement listener
      },
      builder: (context, state) {
        var cubit = AppCubit.get(context);
        addNewExpense() {
          showDialog(
              context: context,
              builder: (context) => AlertDialog(
                    title: const Text('Add new expense'),
                    content: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        //for name
                        TextField(
                          decoration: const InputDecoration(labelText: 'Name '),
                          controller: cubit.expenseName,
                        ),
                        //for amount
                        TextField(
                          controller: cubit.expenseAmount,
                          keyboardType: TextInputType.number,
                          decoration: const InputDecoration(labelText: 'LE'),
                        ),
                      ],
                    ),
                    actions: [
                      MaterialButton(
                        onPressed: () {
                          cubit.saveButton(context);
                        },
                        child: const Text('Save'),
                      ),
                      MaterialButton(
                        onPressed: () {
                          cubit.cancelButton(context);
                        },
                        child: const Text('Cancel'),
                      ),
                    ],
                  ));
        }

        return Scaffold(
          floatingActionButton: FloatingActionButton(
            onPressed: () {
              addNewExpense();
            },
            child: const Icon(Icons.add),
          ),
          body: ListView(
            children: [
              //weekly summary
              
              // expense list
              ListView.builder(
                shrinkWrap: true,
              itemCount: cubit.overAllExpense.length,
              itemBuilder: (context, index) => ExpenseTile(
                  name: cubit.overAllExpense[index].name,
                  amount: cubit.overAllExpense[index].amount,
                  dateTime: cubit.overAllExpense[index].dateTime))
            ],
          ),
        );
      },
    );
  }
}
