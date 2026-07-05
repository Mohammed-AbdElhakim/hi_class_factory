import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../network/dio_client.dart';
import '../network/network_info.dart';
import '../services/logger_service.dart';
import '../storage/local_storage.dart';
import '../../features/auth/data/datasource/auth_local_data_source.dart';
import '../../features/auth/data/datasource/auth_remote_data_source.dart';
import '../../features/auth/data/repositories/auth_repository_impl.dart';
import '../../features/auth/domain/repositories/auth_repository.dart';
import '../../features/auth/domain/usecases/login_usecase.dart';
import '../../features/auth/presentation/bloc/auth_bloc.dart';
import '../../features/home/data/datasource/home_remote_data_source.dart';
import '../../features/home/data/repositories/home_repository_impl.dart';
import '../../features/home/domain/repositories/home_repository.dart';
import '../../features/home/domain/usecases/get_home_data_usecase.dart';
import '../../features/home/presentation/bloc/home_bloc.dart';
import '../../features/onboarding/data/datasource/onboarding_local_data_source.dart';
import '../../features/onboarding/data/repositories/onboarding_repository_impl.dart';
import '../../features/onboarding/domain/repositories/onboarding_repository.dart';
import '../../features/onboarding/domain/usecases/complete_onboarding_usecase.dart';
import '../../features/onboarding/presentation/bloc/onboarding_bloc.dart';
import '../../features/profile/data/datasource/profile_remote_data_source.dart';
import '../../features/profile/data/repositories/profile_repository_impl.dart';
import '../../features/profile/domain/repositories/profile_repository.dart';
import '../../features/profile/domain/usecases/get_profile_usecase.dart';
import '../../features/profile/presentation/bloc/profile_bloc.dart';
import '../../features/settings/data/datasource/settings_local_data_source.dart';
import '../../features/settings/data/repositories/settings_repository_impl.dart';
import '../../features/settings/domain/repositories/settings_repository.dart';
import '../../features/settings/domain/usecases/get_settings_usecase.dart';
import '../../features/settings/presentation/bloc/settings_bloc.dart';
import '../../features/splash/data/datasource/splash_local_data_source.dart';
import '../../features/splash/data/repositories/splash_repository_impl.dart';
import '../../features/splash/domain/repositories/splash_repository.dart';
import '../../features/splash/domain/usecases/check_auth_status_usecase.dart';
import '../../features/splash/presentation/bloc/splash_bloc.dart';

final GetIt getIt = GetIt.instance;

Future<void> configureDependencies() async {
  if (getIt.isRegistered<SharedPreferences>()) {
    return;
  }

  final sharedPreferences = await SharedPreferences.getInstance();
  getIt.registerSingleton<SharedPreferences>(sharedPreferences);

  getIt.registerLazySingleton<Dio>(() => Dio());
  getIt.registerLazySingleton<DioClient>(() => DioClient(getIt<Dio>()));
  getIt.registerLazySingleton<LoggerService>(() => LoggerServiceImpl());
  getIt.registerLazySingleton<NetworkInfo>(() => NetworkInfoImpl());
  getIt.registerLazySingleton<LocalStorage>(
    () => LocalStorageImpl(getIt<SharedPreferences>()),
  );

  getIt.registerFactory<AuthRemoteDataSource>(
    () => AuthRemoteDataSource(getIt<Dio>()),
  );
  getIt.registerFactory<HomeRemoteDataSource>(
    () => HomeRemoteDataSource(getIt<Dio>()),
  );
  getIt.registerFactory<ProfileRemoteDataSource>(
    () => ProfileRemoteDataSource(getIt<Dio>()),
  );

  getIt.registerLazySingleton<AuthLocalDataSource>(
    () => AuthLocalDataSourceImpl(getIt<LocalStorage>()),
  );
  getIt.registerLazySingleton<SettingsLocalDataSource>(
    () => SettingsLocalDataSourceImpl(getIt<LocalStorage>()),
  );
  getIt.registerLazySingleton<OnboardingLocalDataSource>(
    () => OnboardingLocalDataSourceImpl(getIt<LocalStorage>()),
  );
  getIt.registerLazySingleton<SplashLocalDataSource>(
    () => SplashLocalDataSourceImpl(getIt<LocalStorage>()),
  );

  getIt.registerLazySingleton<AuthRepository>(
    () => AuthRepositoryImpl(
      getIt<AuthRemoteDataSource>(),
      getIt<AuthLocalDataSource>(),
    ),
  );
  getIt.registerLazySingleton<HomeRepository>(
    () => HomeRepositoryImpl(getIt<HomeRemoteDataSource>()),
  );
  getIt.registerLazySingleton<ProfileRepository>(
    () => ProfileRepositoryImpl(getIt<ProfileRemoteDataSource>()),
  );
  getIt.registerLazySingleton<SettingsRepository>(
    () => SettingsRepositoryImpl(getIt<SettingsLocalDataSource>()),
  );
  getIt.registerLazySingleton<OnboardingRepository>(
    () => OnboardingRepositoryImpl(getIt<OnboardingLocalDataSource>()),
  );
  getIt.registerLazySingleton<SplashRepository>(
    () => SplashRepositoryImpl(getIt<SplashLocalDataSource>()),
  );

  getIt.registerLazySingleton(() => LoginUsecase(getIt<AuthRepository>()));
  getIt.registerLazySingleton(
    () => GetHomeDataUsecase(getIt<HomeRepository>()),
  );
  getIt.registerLazySingleton(
    () => GetProfileUsecase(getIt<ProfileRepository>()),
  );
  getIt.registerLazySingleton(
    () => GetSettingsUsecase(getIt<SettingsRepository>()),
  );
  getIt.registerLazySingleton(
    () => CompleteOnboardingUsecase(getIt<OnboardingRepository>()),
  );
  getIt.registerLazySingleton(
    () => CheckAuthStatusUsecase(getIt<SplashRepository>()),
  );

  getIt.registerFactory(() => AuthBloc(getIt<LoginUsecase>()));
  getIt.registerFactory(() => HomeBloc(getIt<GetHomeDataUsecase>()));
  getIt.registerFactory(() => ProfileBloc(getIt<GetProfileUsecase>()));
  getIt.registerFactory(() => SettingsBloc(getIt<GetSettingsUsecase>()));
  getIt.registerFactory(OnboardingBloc.new);
  getIt.registerFactory(SplashBloc.new);
}
