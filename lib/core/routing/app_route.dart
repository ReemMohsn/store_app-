import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:stor_app/features/auth/presentation/view_model/auth_cubit.dart';
import 'package:stor_app/features/auth/presentation/views/login_view.dart';
import 'package:stor_app/features/home/presentation/view_model/auth_cubit.dart';
import 'package:stor_app/features/home/presentation/views/products_view.dart';

final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

class AppRouter {
  Route? generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case AppRoute.login:
        return MaterialPageRoute(
          settings: settings,
          builder: (_) =>
              BlocProvider(create: (_) => AuthCubit(Dio()), child: LoginView()),
        );

      case AppRoute.products:
        return MaterialPageRoute(
          settings: settings,
          builder: (_) => BlocProvider(
            create: (_) => ProductsCubit(Dio())..getProducts(),
            child: ProductsView(),
          ),
        );

      default:
        return null;
    }
  }
}

class AppRoute {
  static const String login = '/login';
  static const String products = '/products';
}
