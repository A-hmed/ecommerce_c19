// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format width=80

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes

import 'package:dio/dio.dart' as _i361;
import 'package:get_it/get_it.dart' as _i174;
import 'package:injectable/injectable.dart' as _i526;

import '../../features/auth/data/repository/auth_repository_impl.dart' as _i409;
import '../../features/auth/data/repository/data_sources/auth_remote_data_source.dart'
    as _i408;
import '../../features/auth/data/repository/data_sources/auth_remote_data_source_impl.dart'
    as _i1068;
import '../../features/auth/domain/repository/auth_repository.dart' as _i961;
import '../../features/auth/domain/usecase/login_usecase.dart' as _i911;
import '../../features/auth/domain/usecase/register_usecase.dart' as _i769;
import '../../features/auth/ui/screens/login/cubit/login_cubit.dart' as _i413;
import '../../features/auth/ui/screens/register/cubit/register_cubit.dart'
    as _i113;
import '../../features/commerce/data/mappers/categories_mapper.dart' as _i340;
import '../../features/commerce/data/mappers/products_mapper.dart' as _i192;
import '../../features/commerce/data/repository/home_repository/data_soruces/home_remote_data_source/home_remote_data_source.dart'
    as _i524;
import '../../features/commerce/data/repository/home_repository/data_soruces/home_remote_data_source/home_remote_data_source_impl.dart'
    as _i403;
import '../../features/commerce/data/repository/home_repository/home_repository_impl.dart'
    as _i386;
import '../../features/commerce/data/usecase/get_categories_usecase.dart'
    as _i505;
import '../../features/commerce/data/usecase/get_products_usecase.dart'
    as _i110;
import '../../features/commerce/data/usecase/get_sub_categories_usecase.dart'
    as _i668;
import '../../features/commerce/domain/repository/home_repository.dart'
    as _i457;
import '../../features/commerce/ui/screens/main_tabs_screen/tabs/categories/cubit/categories_cubit.dart'
    as _i1045;
import '../../features/commerce/ui/screens/main_tabs_screen/tabs/home/cubit/home_cubit.dart'
    as _i104;
import '../../features/commerce/ui/screens/products_screen/cubit/products_cubit.dart'
    as _i441;
import '../../features/network/api/api_services.dart' as _i392;
import '../shared_pref_utils/shared_pref_utils.dart' as _i420;
import 'network_module.dart' as _i567;

extension GetItInjectableX on _i174.GetIt {
  // initializes the registration of main-scope dependencies inside of GetIt
  _i174.GetIt init({
    String? environment,
    _i526.EnvironmentFilter? environmentFilter,
  }) {
    final gh = _i526.GetItHelper(this, environment, environmentFilter);
    final networkModule = _$NetworkModule();
    gh.factory<_i361.Dio>(() => networkModule.dio);
    gh.factory<_i340.CategoriesMapper>(() => _i340.CategoriesMapper());
    gh.factory<_i192.ProductsMapper>(() => _i192.ProductsMapper());
    gh.singleton<_i420.SharedPrefUtils>(() => _i420.SharedPrefUtils());
    gh.factory<_i392.ApiServices>(() => _i392.ApiServices(gh<_i361.Dio>()));
    gh.factory<_i524.HomeRemoteDataSource>(
      () => _i403.HomeRemoteDataSourceImpl(gh<_i392.ApiServices>()),
    );
    gh.factory<_i408.AuthRemoteDataSource>(
      () => _i1068.AuthRemoteDataSourceImpl(gh<_i392.ApiServices>()),
    );
    gh.factory<_i457.HomeRepository>(
      () => _i386.HomeRepositoryImpl(
        gh<_i524.HomeRemoteDataSource>(),
        gh<_i340.CategoriesMapper>(),
        gh<_i192.ProductsMapper>(),
      ),
    );
    gh.factory<_i961.AuthRepository>(
      () => _i409.AuthRepositoryImpl(
        gh<_i408.AuthRemoteDataSource>(),
        gh<_i420.SharedPrefUtils>(),
      ),
    );
    gh.factory<_i505.GetCategoriesUseCase>(
      () => _i505.GetCategoriesUseCase(gh<_i457.HomeRepository>()),
    );
    gh.factory<_i110.GetProductsUseCase>(
      () => _i110.GetProductsUseCase(gh<_i457.HomeRepository>()),
    );
    gh.factory<_i668.GetSubCategoriesUseCase>(
      () => _i668.GetSubCategoriesUseCase(gh<_i457.HomeRepository>()),
    );
    gh.factory<_i911.LoginUseCase>(
      () => _i911.LoginUseCase(gh<_i961.AuthRepository>()),
    );
    gh.factory<_i769.RegisterUseCase>(
      () => _i769.RegisterUseCase(gh<_i961.AuthRepository>()),
    );
    gh.factory<_i441.ProductsCubit>(
      () => _i441.ProductsCubit(gh<_i110.GetProductsUseCase>()),
    );
    gh.factory<_i413.LoginCubit>(
      () => _i413.LoginCubit(gh<_i911.LoginUseCase>()),
    );
    gh.factory<_i104.HomeCubit>(
      () => _i104.HomeCubit(
        gh<_i505.GetCategoriesUseCase>(),
        gh<_i110.GetProductsUseCase>(),
      ),
    );
    gh.factory<_i1045.CategoriesCubit>(
      () => _i1045.CategoriesCubit(
        gh<_i505.GetCategoriesUseCase>(),
        gh<_i668.GetSubCategoriesUseCase>(),
      ),
    );
    gh.factory<_i113.RegisterCubit>(
      () => _i113.RegisterCubit(gh<_i769.RegisterUseCase>()),
    );
    return this;
  }
}

class _$NetworkModule extends _i567.NetworkModule {}
