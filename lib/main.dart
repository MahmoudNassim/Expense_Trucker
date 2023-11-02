import 'package:expense_trucker/home_page.dart';
import 'package:expense_trucker/shared/bloc_observer.dart';
import 'package:expense_trucker/shared/cubit/cubit.dart';
import 'package:expense_trucker/shared/cubit/states.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() {
  Bloc.observer = MyBlocObserver();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return  BlocProvider(
      create: (context) => AppCubit(),
      child: BlocConsumer<AppCubit , AppStates>(
        listener: (context, state) {
          // TODO: implement listener
        },
        builder: (context, state) {
          return const MaterialApp(
            debugShowCheckedModeBanner: false,
            home: HomePage(),
          );
        },
      ),
    );
  }
}
