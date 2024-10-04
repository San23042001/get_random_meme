// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:connectivity_plus/connectivity_plus.dart' as _i895;
import 'package:dio/dio.dart' as _i361;
import 'package:get_it/get_it.dart' as _i174;
import 'package:injectable/injectable.dart' as _i526;

import '../core/api/api_client.dart' as _i424;
import '../core/api/injection_module.dart' as _i821;
import '../core/token_service.dart' as _i486;
import '../data/data_sources/remote/meme_remote_data_source.dart' as _i936;
import '../data/data_sources/remote/random_remote_data_source.dart' as _i757;
import '../data/local/auth_local_data_source.dart' as _i643;
import '../data/local/meme_local_data_source.dart' as _i493;
import '../data/local/token_local_data_source.dart' as _i1028;
import '../data/repository/auth_repository_impl.dart' as _i461;
import '../data/repository/meme_repository_impl.dart' as _i775;
import '../data/repository/random_meme_repository_impl.dart' as _i149;
import '../data/repository/token_repository_impl.dart' as _i802;
import '../domain/meme_controller.dart' as _i448;
import '../domain/repository/auth_repository.dart' as _i306;
import '../domain/repository/meme_repository.dart' as _i803;
import '../domain/repository/random_meme_repository.dart' as _i120;
import '../domain/repository/token_repository.dart' as _i388;
import '../presentation/cubit/auth_cubit/auth_cubit.dart' as _i224;
import '../presentation/cubit/google_signin_cubit/google_signin_cubit.dart'
    as _i376;
import '../presentation/cubit/meme_cubit/meme_cubit_cubit.dart' as _i939;
import '../presentation/cubit/random_meme/random_meme_cubit.dart' as _i315;
import '../presentation/routes/app_router.dart' as _i591;

// initializes the registration of main-scope dependencies inside of GetIt
_i174.GetIt $initGetIt(
  _i174.GetIt getIt, {
  String? environment,
  _i526.EnvironmentFilter? environmentFilter,
}) {
  final gh = _i526.GetItHelper(
    getIt,
    environment,
    environmentFilter,
  );
  final injectionModule = _$InjectionModule();
  gh.lazySingleton<_i895.Connectivity>(() => injectionModule.connectivity());
  gh.lazySingleton<_i448.MemeDomainController>(
      () => _i448.MemeDomainController());
  gh.lazySingleton<_i591.AppRouter>(() => _i591.AppRouter());
  gh.lazySingleton<_i493.MemeLocalDataSource>(
      () => _i493.MemeLocalDataSourceImpl());
  gh.lazySingleton<_i1028.TokenLocalDataSource>(
      () => _i1028.TokenLocalDataSourceImpl());
  gh.factory<String>(
    () => injectionModule.baseUrl,
    instanceName: 'baseUrl',
  );
  gh.lazySingleton<_i361.Dio>(
      () => injectionModule.dio(gh<String>(instanceName: 'baseUrl')));
  gh.lazySingleton<_i643.AuthLocalDataSource>(
      () => _i643.AuthLocalDataSourceImpl());
  gh.lazySingleton<_i306.AuthRepository>(() => _i461.AuthRepositoryImpl(
        gh<_i643.AuthLocalDataSource>(),
        gh<_i1028.TokenLocalDataSource>(),
      ));
  gh.lazySingleton<_i224.AuthCubit>(
      () => _i224.AuthCubit(gh<_i306.AuthRepository>()));
  gh.lazySingleton<_i388.TokenRepository>(
      () => _i802.TokenRepositoryImpl(gh<_i1028.TokenLocalDataSource>()));
  gh.lazySingleton<_i486.TokenService>(
      () => _i486.TokenService(gh<_i388.TokenRepository>()));
  gh.lazySingleton<_i424.ApiClient>(() => _i424.ApiClient(
        gh<_i361.Dio>(),
        gh<_i486.TokenService>(),
      ));
  gh.lazySingleton<_i376.GoogleSigninCubit>(() => _i376.GoogleSigninCubit(
        gh<_i306.AuthRepository>(),
        gh<_i388.TokenRepository>(),
      ));
  gh.lazySingleton<_i936.MemeRemoteDataSource>(
      () => _i936.MemeRemoteDataSourceImpl(gh<_i424.ApiClient>()));
  gh.lazySingleton<_i757.RandomMemeRemoteDataSource>(
      () => _i757.RandomMemeRemoteDataSourceImpl(gh<_i424.ApiClient>()));
  gh.lazySingleton<_i803.MemeRepository>(
      () => _i775.MemeRepositoryImpl(gh<_i936.MemeRemoteDataSource>()));
  gh.lazySingleton<_i120.RandomMemeRepository>(() =>
      _i149.RandomMemeRepositoryImpl(gh<_i757.RandomMemeRemoteDataSource>()));
  gh.factory<_i315.RandomMemeCubit>(
      () => _i315.RandomMemeCubit(gh<_i120.RandomMemeRepository>()));
  gh.factory<_i939.MemeCubitCubit>(
      () => _i939.MemeCubitCubit(gh<_i803.MemeRepository>()));
  return getIt;
}

class _$InjectionModule extends _i821.InjectionModule {}
