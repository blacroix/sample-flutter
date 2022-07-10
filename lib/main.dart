import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sample/app_router.gr.dart';
import 'package:sample/injection.dart';
import 'package:sample/presentation/cart/cart_bloc.dart';

void main() {
  configureDependencies();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  final _appRouter = getIt<AppRouter>();
  final _cartBloc = getIt<CartBloc>();

  MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) => BlocProvider(
      create: (context) => _cartBloc,
      child: MaterialApp.router(
        routeInformationParser: _appRouter.defaultRouteParser(),
        routerDelegate: _appRouter.delegate(),
      ));
}
