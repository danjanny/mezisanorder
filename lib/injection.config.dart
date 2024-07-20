// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:get_it/get_it.dart' as _i1;
import 'package:injectable/injectable.dart' as _i2;
import 'package:skeleton/authentication/data/data_sources/abstraction/i_login_service.dart'
    as _i4;
import 'package:skeleton/authentication/data/data_sources/login_service_impl.dart'
    as _i5;
import 'package:skeleton/authentication/data/data_sources/mapper/login_mapper.dart'
    as _i3;
import 'package:skeleton/authentication/data/repositories/login_repository_impl.dart'
    as _i7;
import 'package:skeleton/authentication/domain/repositories/i_login_repository.dart'
    as _i6;
import 'package:skeleton/authentication/domain/use_cases/login_use_case.dart'
    as _i8;

extension GetItInjectableX on _i1.GetIt {
// initializes the registration of main-scope dependencies inside of GetIt
  _i1.GetIt init({
    String? environment,
    _i2.EnvironmentFilter? environmentFilter,
  }) {
    final gh = _i2.GetItHelper(
      this,
      environment,
      environmentFilter,
    );
    gh.factory<_i3.LoginMapper>(() => _i3.LoginMapper());
    gh.factory<_i4.ILoginService>(() => _i5.LoginServiceImpl());
    gh.factory<_i6.ILoginRepository>(() => _i7.LoginRepositoryImpl(
          gh<_i4.ILoginService>(),
          gh<_i3.LoginMapper>(),
        ));
    gh.factory<_i8.LoginUseCase>(
        () => _i8.LoginUseCase(gh<_i6.ILoginRepository>()));
    return this;
  }
}
