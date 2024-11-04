// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:get_it/get_it.dart' as _i174;
import 'package:injectable/injectable.dart' as _i526;
import 'package:skeleton/authentication/data/data_sources/abstraction/i_login_service.dart'
    as _i1032;
import 'package:skeleton/authentication/data/data_sources/login_service_impl.dart'
    as _i991;
import 'package:skeleton/authentication/data/data_sources/mapper/init_result_mapper.dart'
    as _i626;
import 'package:skeleton/authentication/data/data_sources/mapper/passcode_mapper.dart'
    as _i276;
import 'package:skeleton/authentication/data/data_sources/mapper/volunteer_mapper.dart'
    as _i720;
import 'package:skeleton/authentication/data/data_sources/mapper/wilayah_mapper.dart'
    as _i803;
import 'package:skeleton/authentication/data/repositories/login_repository_impl.dart'
    as _i819;
import 'package:skeleton/authentication/domain/repositories/i_login_repository.dart'
    as _i652;
import 'package:skeleton/authentication/domain/use_cases/init_volunteer_use_case.dart'
    as _i427;
import 'package:skeleton/authentication/domain/use_cases/passcode_use_case.dart'
    as _i1055;
import 'package:skeleton/authentication/domain/use_cases/volunteer_use_case.dart'
    as _i939;
import 'package:skeleton/authentication/domain/use_cases/wilayah_use_case.dart'
    as _i14;
import 'package:skeleton/authentication/presentation/manager/login_cubit.dart'
    as _i212;
import 'package:skeleton/home/presentation/manager/home_cubit.dart' as _i993;

extension GetItInjectableX on _i174.GetIt {
// initializes the registration of main-scope dependencies inside of GetIt
  _i174.GetIt init({
    String? environment,
    _i526.EnvironmentFilter? environmentFilter,
  }) {
    final gh = _i526.GetItHelper(
      this,
      environment,
      environmentFilter,
    );
    gh.factory<_i993.HomeCubit>(() => _i993.HomeCubit());
    gh.factory<_i276.PasscodeMapper>(() => _i276.PasscodeMapper());
    gh.factory<_i803.WilayahMapper>(() => _i803.WilayahMapper());
    gh.factory<_i720.VolunteerMapper>(() => _i720.VolunteerMapper());
    gh.factory<_i626.InitResultMapper>(() => _i626.InitResultMapper());
    gh.factory<_i1032.ILoginService>(() => _i991.LoginServiceImpl());
    gh.factory<_i652.ILoginRepository>(() => _i819.LoginRepositoryImpl(
          gh<_i1032.ILoginService>(),
          gh<_i276.PasscodeMapper>(),
          gh<_i626.InitResultMapper>(),
          gh<_i803.WilayahMapper>(),
          gh<_i720.VolunteerMapper>(),
        ));
    gh.factory<_i939.VolunteerUseCase>(
        () => _i939.VolunteerUseCase(gh<_i652.ILoginRepository>()));
    gh.factory<_i1055.PasscodeUseCase>(
        () => _i1055.PasscodeUseCase(gh<_i652.ILoginRepository>()));
    gh.factory<_i14.WilayahUseCase>(
        () => _i14.WilayahUseCase(gh<_i652.ILoginRepository>()));
    gh.factory<_i427.InitVolunteerUseCase>(
        () => _i427.InitVolunteerUseCase(gh<_i652.ILoginRepository>()));
    gh.factory<_i212.LoginCubit>(() => _i212.LoginCubit(
          gh<_i1055.PasscodeUseCase>(),
          gh<_i427.InitVolunteerUseCase>(),
          gh<_i14.WilayahUseCase>(),
          gh<_i939.VolunteerUseCase>(),
        ));
    return this;
  }
}
