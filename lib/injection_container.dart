import 'package:cowvation/core/network/network_info.dart';
import 'package:cowvation/core/token/data/datasources/token_remote_data_source.dart';
import 'package:cowvation/core/token/domain/repositories/token_repository.dart';
import 'package:cowvation/core/token/domain/usecases/get_token_login.dart';
import 'package:cowvation/features/cow/data/datasources/cow_api_service.dart';
import 'package:cowvation/features/cow/data/datasources/cow_local_data_source.dart';
import 'package:cowvation/features/cow/data/datasources/cow_remote_data_source.dart';
import 'package:cowvation/features/cow/data/repositories/cow_repository_impl.dart';
import 'package:cowvation/features/cow/domain/repositories/cow_repository.dart';
import 'package:cowvation/features/cow/domain/usecases/change_cow.dart';
import 'package:cowvation/features/cow/domain/usecases/get_cow.dart';
import 'package:cowvation/features/cow/presentation/bloc/cow_bloc.dart';
import 'package:cowvation/features/cow/presentation/bloc_add/cow_add_bloc.dart';
import 'package:cowvation/features/cowlist/data/datasources/cow_list_api_service.dart';
import 'package:cowvation/features/cowlist/data/datasources/cow_list_local_data_source.dart';
import 'package:cowvation/features/cowlist/data/datasources/cow_list_remote_data_source.dart';
import 'package:cowvation/features/cowlist/data/repositories/cow_list_repository_impl.dart';
import 'package:cowvation/features/cowlist/domain/repositories/cow_list_repository.dart';
import 'package:cowvation/features/cowlist/domain/usecases/get_cow_list.dart';
import 'package:cowvation/features/cowlist/presentation/bloc/cow_list_bloc.dart';
import 'package:cowvation/core/token/data/datasources/token_api_service.dart';
import 'package:cowvation/core/token/data/datasources/token_local_data_source.dart';
import 'package:cowvation/core/token/data/repositories/token_repository_impl.dart';
import 'package:cowvation/core/token/domain/usecases/get_token.dart';
import 'package:cowvation/features/login/bloc/token_bloc.dart';
import 'package:data_connection_checker/data_connection_checker.dart';
import 'package:get_it/get_it.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

import 'features/cow/domain/usecases/add_cow.dart';


final sl = GetIt.instance;

Future<void> init() async {
  //! Features - Login
  // Bloc
  sl.registerFactory(() => TokenBloc(getTokenLogin: sl()));

  //! Features - CowList
  // Bloc
  sl.registerFactory(() => CowListBloc(getCowList: sl()));

  // Use Case
  sl.registerLazySingleton(() => GetCowList(sl()));

  // Repository
  sl.registerLazySingleton<CowListRepository>(
    () => CowListRepositoryImpl(
      remoteDataSource: sl(),
      localDataSource: sl(),
      networkInfo: sl(),
      tokenRepository: sl(),
    )
  );

  // Data Sources
  sl.registerLazySingleton<CowListLocalDataSource>(() => CowListLocalDataSourceImpl(sharedPreferences: sl()));
  sl.registerLazySingleton<CowListRemoteDataSource>(() => CowListRemoteDataSourceImpl(client: sl()));
  sl.registerLazySingleton<CowListApiService>(() => CowListApiService.create());

  //! Features - Cow
  // Bloc
  sl.registerFactory(() => CowBloc(getCow: sl()));
  sl.registerFactory(() => CowAddBloc(addCow: sl()));

  // Use Case
  sl.registerLazySingleton(() => GetCow(sl()));
  sl.registerLazySingleton(() => ChangeCow(sl()));
  sl.registerLazySingleton(() => AddCow(sl()));

  // Repository
  sl.registerLazySingleton<CowRepository>(
    () => CowRepositoryImpl(
      remoteDataSource: sl(),
      localDataSource: sl(),
      networkInfo: sl(),
      tokenRepository: sl(),
    )
  );

  // Data Sources
  sl.registerLazySingleton<CowLocalDataSource>(() => CowLocalDataSourceImpl(sharedPreferences: sl()));
  sl.registerLazySingleton<CowRemoteDataSource>(() => CowRemoteDataSourceImpl(client: sl()));
  sl.registerLazySingleton<CowApiService>(() => CowApiService.create());

  //! Core
  sl.registerLazySingleton<NetworkInfo>(() => NetworkInfoImpl(sl()));

  //! Core - Token
  // Use Case
  sl.registerLazySingleton(() => GetToken(sl()));
  sl.registerLazySingleton(() => GetTokenLogin(sl()));

  // Repository
  sl.registerLazySingleton<TokenRepository>(
    () => TokenRepositoryImpl(
      remoteDataSource: sl(),
      localDataSource: sl(),
      networkInfo: sl(),
    )
  );

  // Data Sources
  sl.registerLazySingleton<TokenLocalDataSource>(() => TokenLocalDataSourceImpl(sharedPreferences: sl()));
  sl.registerLazySingleton<TokenRemoteDataSource>(() => TokenRemoteDataSourceImpl(client: sl()));
  sl.registerLazySingleton<TokenApiService>(() => TokenApiService.create());

  //! External
  final sharedPreferences = await SharedPreferences.getInstance();
  sl.registerLazySingleton(() => sharedPreferences);
  sl.registerLazySingleton(() => http.Client());
  sl.registerLazySingleton(() => DataConnectionChecker());
}
