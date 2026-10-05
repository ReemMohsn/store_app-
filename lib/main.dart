import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:stor_app/core/routing/app_route.dart';
import 'package:stor_app/features/auth/presentation/view_model/auth_cubit.dart';
import 'package:stor_app/features/auth/presentation/views/login_view.dart';

void main() {
  runApp(const StoreApp());
}

class StoreApp extends StatelessWidget {
  const StoreApp({super.key});

  @override
  Widget build(BuildContext context) {
    const primaryColor = Color(0xff2563eb);
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'متجري',
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(seedColor: primaryColor),
        scaffoldBackgroundColor: const Color(0xfff8fafc),
        inputDecorationTheme: InputDecorationTheme(
          filled: true,
          fillColor: Colors.white,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(14),
            borderSide: BorderSide.none,
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(14),
            borderSide: const BorderSide(color: Color(0xffe2e8f0)),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(14),
            borderSide: const BorderSide(color: primaryColor, width: 1.5),
          ),
        ),
        cardTheme: CardThemeData(
          color: Colors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
        ),
      ),
      locale: const Locale('ar'),
      navigatorKey: navigatorKey,
      onGenerateRoute: AppRouter().generateRoute,
      initialRoute: AppRoute.login,
      home: Directionality(
        textDirection: TextDirection.rtl,
        child: LoginView(),
      ),
    );
  }
}

// Backward-compatible app name for existing integrations.
typedef MyApp = StoreApp;
