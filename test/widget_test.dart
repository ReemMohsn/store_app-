import 'dart:async';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:stor_app/core/constants/api_end_points.dart';
import 'package:stor_app/core/constants/app_strings.dart';
import 'package:stor_app/core/dependency_injection/injection_container.dart';
import 'package:stor_app/core/services/api_service.dart';
import 'package:stor_app/core/services/shared_preferences_service.dart';
import 'package:stor_app/features/auth/presentation/view_model/auth_cubit.dart';
import 'package:stor_app/features/auth/presentation/view_model/auth_state.dart';
import 'package:stor_app/features/home/data/repositories/home_repository.dart';
import 'package:stor_app/features/home/presentation/view_model/home_cubit.dart';
import 'package:stor_app/features/home/presentation/view_model/home_state.dart';
import 'package:stor_app/main.dart';

const _account = {'id': 1, 'username': 'emilys', 'accessToken': 'test-token'};

void main() {
  late _FakePreferences preferences;
  late _FakeApiService api;

  setUp(() async {
    await sl.reset();
    await initDependencies();
    preferences = _FakePreferences();
    api = _FakeApiService(preferences);
    await sl.unregister<SharedPreferencesService>();
    sl.registerSingleton<SharedPreferencesService>(preferences);
    await sl.unregister<ApiService>();
    sl.registerSingleton<ApiService>(api);
  });

  tearDown(() async => sl.reset());

  testWidgets('sign in stores the token and loads products once', (
    tester,
  ) async {
    await tester.pumpWidget(const StoreApp());
    await tester.pumpAndSettle();
    expect(find.text(AppStrings.loginTitle), findsOneWidget);
    expect(
      Directionality.of(tester.element(find.byType(TextFormField).first)),
      TextDirection.rtl,
    );

    await tester.tap(find.text(AppStrings.signIn));
    await tester.pumpAndSettle();

    expect(api.postedPath, ApiEndPoints.login);
    expect(api.postedData, {'username': 'emilys', 'password': 'emilyspass'});
    expect(preferences.token, 'test-token');
    expect(api.productRequests, 1);
    expect(find.text(AppStrings.products), findsOneWidget);
    expect(find.text(AppStrings.loginTitle), findsNothing);
    expect(
      Directionality.of(tester.element(find.byType(GridView))),
      TextDirection.rtl,
    );

    await tester.tap(find.byIcon(Icons.refresh));
    await tester.pumpAndSettle();
    expect(api.productRequests, 2);
  });

  testWidgets('invalid credentials use the shared error message', (
    tester,
  ) async {
    api.onSignIn = () async {
      final options = RequestOptions(path: ApiEndPoints.login);
      throw DioException(
        requestOptions: options,
        type: DioExceptionType.badResponse,
        response: Response<dynamic>(
          requestOptions: options,
          statusCode: 400,
          data: {'message': 'Invalid credentials'},
        ),
      );
    };

    await tester.pumpWidget(const StoreApp());
    await tester.pumpAndSettle();
    await tester.tap(find.text(AppStrings.signIn));
    await tester.pumpAndSettle();

    expect(find.text('Invalid credentials'), findsOneWidget);
    expect(find.text(AppStrings.loginTitle), findsOneWidget);
    expect(preferences.token, isNull);
    expect(api.productRequests, 0);
    expect(
      tester.widget<FilledButton>(find.byType(FilledButton)).onPressed,
      isNotNull,
    );
  });

  testWidgets('sign in requires a username and password', (tester) async {
    await tester.pumpWidget(const StoreApp());
    await tester.pumpAndSettle();
    final fields = find.byType(TextFormField);
    await tester.enterText(fields.first, ' ');
    await tester.enterText(fields.last, '');
    await tester.tap(find.text(AppStrings.signIn));
    await tester.pumpAndSettle();

    expect(find.text(AppStrings.enterUsername), findsOneWidget);
    expect(
      find.text(AppStrings.requiredField(AppStrings.thisField)),
      findsOneWidget,
    );
    expect(api.postedPath, isNull);

    await tester.enterText(fields.first, ' a ');
    await tester.enterText(fields.last, '123');
    await tester.tap(find.text(AppStrings.signIn));
    await tester.pumpAndSettle();
    expect(api.postedData, {'username': 'a', 'password': '123'});
    expect(find.text(AppStrings.products), findsOneWidget);
  });

  testWidgets('a failed products request can be retried', (tester) async {
    api.onProducts = () async {
      throw DioException(
        requestOptions: RequestOptions(path: ApiEndPoints.products),
        type: DioExceptionType.connectionError,
      );
    };
    await tester.pumpWidget(const StoreApp());
    await tester.pumpAndSettle();
    await tester.tap(find.text(AppStrings.signIn));
    await tester.pumpAndSettle();

    expect(
      find.text(AppStrings.noInternetConnectionPleaseTryAgain),
      findsOneWidget,
    );
    expect(api.productRequests, 1);

    api.onProducts = () async => {'products': <Object>[]};
    await tester.tap(find.text(AppStrings.retry));
    await tester.pumpAndSettle();
    expect(api.productRequests, 2);
    expect(find.byType(GridView), findsOneWidget);
    expect(find.text(AppStrings.retry), findsNothing);
  });

  test('a malformed login response never produces login success', () async {
    api.onSignIn = () async => <String, dynamic>{};
    final cubit = sl<AuthCubit>();
    addTearDown(cubit.close);

    await cubit.signIn(username: 'emilys', password: 'emilyspass');

    expect(cubit.state, isA<LoginFailure>());
    expect(
      (cubit.state as LoginFailure).errorMessage,
      AppStrings.theReturnedDataCouldNotBeProcessedPleaseTryAgain,
    );
    expect(preferences.token, isNull);
  });

  test('login success waits until token storage finishes', () async {
    final storage = Completer<void>();
    preferences.beforeSave = () => storage.future;
    final cubit = sl<AuthCubit>();
    addTearDown(cubit.close);

    final signIn = cubit.signIn(username: 'emilys', password: 'emilyspass');
    await Future<void>.delayed(Duration.zero);
    expect(cubit.state, isA<LoginLoading>());
    expect(preferences.token, isNull);

    storage.complete();
    await signIn;
    expect(cubit.state, isA<LoginSuccess>());
    expect(preferences.token, 'test-token');
  });

  test('products keep their existing data mapping', () async {
    api.onProducts = () async => {
      'products': [
        {
          'id': 7,
          'title': 'Product',
          'description': 'Description',
          'price': 12,
          'thumbnail': 'thumbnail.png',
        },
        {'id': 8, 'price': 2.5, 'imageUrl': 'fallback.png'},
      ],
    };

    final result = await sl<HomeRepository>().getProducts();
    result.fold((failure) => fail(failure.message), (products) {
      expect(products, hasLength(2));
      expect(products.first.id, '7');
      expect(products.first.title, 'Product');
      expect(products.first.description, 'Description');
      expect(products.first.price, 12.0);
      expect(products.first.imageUrl, 'thumbnail.png');
      expect(products.last.title, AppStrings.product);
      expect(products.last.price, 2.5);
      expect(products.last.imageUrl, 'fallback.png');
    });
  });

  test(
    'malformed products are handled by the shared request handler',
    () async {
      api.onProducts = () async => {'products': 'invalid'};
      final cubit = sl<HomeCubit>();
      addTearDown(cubit.close);

      await cubit.getProducts();

      expect(cubit.state, isA<HomeFailure>());
      expect(
        (cubit.state as HomeFailure).errorMessage,
        AppStrings.theReturnedDataCouldNotBeProcessedPleaseTryAgain,
      );
    },
  );

  test(
    'completing requests after closing cubits does not emit states',
    () async {
      final loginResponse = Completer<Object?>();
      api.onSignIn = () => loginResponse.future;
      final auth = sl<AuthCubit>();
      final signIn = auth.signIn(username: 'emilys', password: 'emilyspass');
      await auth.close();
      loginResponse.complete(_account);
      await signIn;
      expect(auth.state, isA<LoginLoading>());

      final productsResponse = Completer<Object?>();
      api.onProducts = () => productsResponse.future;
      final home = sl<HomeCubit>();
      final getProducts = home.getProducts();
      await home.close();
      productsResponse.complete({'products': <Object>[]});
      await getProducts;
      expect(home.state, isA<HomeLoading>());
    },
  );
}

class _FakePreferences implements SharedPreferencesService {
  String? token;
  bool onboardingCompleted = false;
  Future<void> Function()? beforeSave;

  @override
  Future<bool> get isOnboardingCompleted async => onboardingCompleted;

  @override
  Future<void> setOnboardingCompleted() async {
    onboardingCompleted = true;
  }

  @override
  Future<String?> get accessToken async => token;

  @override
  Future<void> setAccessToken(String token) async {
    await beforeSave?.call();
    this.token = token;
  }
}

class _FakeApiService extends ApiService {
  _FakeApiService(super.preferencesService);

  Future<Object?> Function() onSignIn = () async => _account;
  Future<Object?> Function() onProducts = () async => {'products': <Object>[]};
  String? postedPath;
  Object? postedData;
  int productRequests = 0;

  @override
  Future<Response<dynamic>> post(
    String path, {
    Object? data,
    Map<String, dynamic>? queryParameters,
  }) async {
    postedPath = path;
    postedData = data;
    // Let the loading dialog mount before the simulated request finishes.
    await Future<void>.delayed(const Duration(milliseconds: 200));
    return Response<dynamic>(
      requestOptions: RequestOptions(path: path),
      data: await onSignIn(),
      statusCode: 200,
    );
  }

  @override
  Future<Response<dynamic>> get(
    String path, {
    Map<String, dynamic>? queryParameters,
  }) async {
    expect(path, ApiEndPoints.products);
    productRequests++;
    return Response<dynamic>(
      requestOptions: RequestOptions(path: path),
      data: await onProducts(),
      statusCode: 200,
    );
  }
}
