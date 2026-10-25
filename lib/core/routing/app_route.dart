import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:stor_app/core/dependency_injection/injection_container.dart';
import 'package:stor_app/core/routing/routes.dart';
import 'package:stor_app/features/auth/presentation/view_model/auth_cubit.dart';
import 'package:stor_app/features/auth/presentation/views/login_view.dart';
import 'package:stor_app/features/home/presentation/view_model/home_cubit.dart';
import 'package:stor_app/features/home/presentation/views/products_view.dart';

class AppRouter {
  Route<dynamic>? generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case AppRoute.login:
        return MaterialPageRoute(
          settings: settings,
          builder: (_) => BlocProvider(
            create: (_) => sl<AuthCubit>(),
            child: const LoginView(),
          ),
        );

      case AppRoute.products:
        return MaterialPageRoute(
          settings: settings,
          builder: (_) => BlocProvider(
            create: (_) => sl<HomeCubit>()..getProducts(),
            child: const ProductsView(),
          ),
        );

      default:
        return null;
    }
  }
}
