import 'package:flutter/material.dart';
import 'package:stor_app/core/constants/app_strings.dart';
import 'package:stor_app/core/dependency_injection/injection_container.dart';
import 'package:stor_app/core/routing/app_route.dart';
import 'package:stor_app/core/routing/navigator_key.dart';
import 'package:stor_app/core/routing/routes.dart';
import 'package:stor_app/core/themes/app_theme.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await initDependencies();
  runApp(const StoreApp());
}

class StoreApp extends StatelessWidget {
  const StoreApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: AppStrings.appName,
      theme: AppTheme.lightTheme,
      locale: const Locale('ar'),
      navigatorKey: NavigatorKey.navigatorKey,
      onGenerateRoute: AppRouter().generateRoute,
      initialRoute: AppRoute.login,
      builder: (context, child) =>
          Directionality(textDirection: TextDirection.rtl, child: child!),
    );
  }
}
