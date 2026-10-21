import 'package:get_it/get_it.dart';
import 'package:stor_app/core/services/api_service.dart';
import 'package:stor_app/core/services/shared_preferences_service.dart';
import 'package:stor_app/features/auth/data/data_sources/auth_remote_data_source.dart';
import 'package:stor_app/features/auth/data/repositories/auth_repository.dart';
import 'package:stor_app/features/auth/presentation/view_model/auth_cubit.dart';
import 'package:stor_app/features/home/data/data_sources/home_remote_data_source.dart';
import 'package:stor_app/features/home/data/repositories/home_repository.dart';
import 'package:stor_app/features/home/presentation/view_model/home_cubit.dart';

final sl = GetIt.instance;

Future<void> initDependencies() async {
  // Core Services
  sl.registerLazySingleton<SharedPreferencesService>(
    () => SharedPreferencesService(),
  );
  sl.registerLazySingleton<ApiService>(
    () => ApiService(sl<SharedPreferencesService>()),
  );

  // Auth Feature
  sl.registerLazySingleton<AuthRemoteDataSource>(
    () => AuthRemoteDataSource(sl<ApiService>()),
  );
  sl.registerLazySingleton<AuthRepository>(
    () => AuthRepository(
      sl<AuthRemoteDataSource>(),
      sl<SharedPreferencesService>(),
    ),
  );
  sl.registerFactory<AuthCubit>(() => AuthCubit(sl<AuthRepository>()));

  // Home Feature
  sl.registerLazySingleton<HomeRemoteDataSource>(
    () => HomeRemoteDataSource(sl<ApiService>()),
  );
  sl.registerLazySingleton<HomeRepository>(
    () => HomeRepository(sl<HomeRemoteDataSource>()),
  );
  sl.registerFactory<HomeCubit>(() => HomeCubit(sl<HomeRepository>()));
}
