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
    as _i8;
import 'package:skeleton/authentication/data/data_sources/login_service_impl.dart'
    as _i9;
import 'package:skeleton/authentication/data/data_sources/mapper/init_result_mapper.dart'
    as _i7;
import 'package:skeleton/authentication/data/data_sources/mapper/passcode_mapper.dart'
    as _i4;
import 'package:skeleton/authentication/data/data_sources/mapper/volunteer_mapper.dart'
    as _i6;
import 'package:skeleton/authentication/data/data_sources/mapper/wilayah_mapper.dart'
    as _i5;
import 'package:skeleton/authentication/data/repositories/login_repository_impl.dart'
    as _i11;
import 'package:skeleton/authentication/domain/repositories/i_login_repository.dart'
    as _i10;
import 'package:skeleton/authentication/domain/use_cases/cek_user_use_case.dart'
    as _i14;
import 'package:skeleton/authentication/domain/use_cases/init_volunteer_use_case.dart'
    as _i18;
import 'package:skeleton/authentication/domain/use_cases/passcode_use_case.dart'
    as _i16;
import 'package:skeleton/authentication/domain/use_cases/volunteer_use_case.dart'
    as _i15;
import 'package:skeleton/authentication/domain/use_cases/wilayah_use_case.dart'
    as _i17;
import 'package:skeleton/authentication/presentation/manager/login_cubit.dart'
    as _i19;
import 'package:skeleton/home/data/data_sources/abstraction/i_home_service.dart'
    as _i12;
import 'package:skeleton/home/data/data_sources/home_service_impl.dart' as _i13;
import 'package:skeleton/home/data/data_sources/mapper/input_result_mapper.dart'
    as _i3;
import 'package:skeleton/home/data/repositories/home_repository_impl.dart'
    as _i21;
import 'package:skeleton/home/domain/repositories/i_home_repository.dart'
    as _i20;
import 'package:skeleton/home/domain/use_cases/check_data_pilkada_use_case.dart'
    as _i23;
import 'package:skeleton/home/domain/use_cases/input_result_use_case.dart'
    as _i22;
import 'package:skeleton/home/presentation/manager/check_data_cubit.dart'
    as _i24;
import 'package:skeleton/home/presentation/manager/home_cubit.dart' as _i25;

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
    gh.factory<_i3.InputResultMapper>(() => _i3.InputResultMapper());
    gh.factory<_i4.PasscodeMapper>(() => _i4.PasscodeMapper());
    gh.factory<_i5.WilayahMapper>(() => _i5.WilayahMapper());
    gh.factory<_i6.VolunteerMapper>(() => _i6.VolunteerMapper());
    gh.factory<_i7.InitResultMapper>(() => _i7.InitResultMapper());
    gh.factory<_i8.ILoginService>(() => _i9.LoginServiceImpl());
    gh.factory<_i10.ILoginRepository>(() => _i11.LoginRepositoryImpl(
          gh<_i8.ILoginService>(),
          gh<_i4.PasscodeMapper>(),
          gh<_i7.InitResultMapper>(),
          gh<_i5.WilayahMapper>(),
          gh<_i6.VolunteerMapper>(),
        ));
    gh.factory<_i12.IHomeService>(() => _i13.HomeServiceImpl());
    gh.factory<_i14.CekUserUseCase>(
        () => _i14.CekUserUseCase(gh<_i10.ILoginRepository>()));
    gh.factory<_i15.VolunteerUseCase>(
        () => _i15.VolunteerUseCase(gh<_i10.ILoginRepository>()));
    gh.factory<_i16.PasscodeUseCase>(
        () => _i16.PasscodeUseCase(gh<_i10.ILoginRepository>()));
    gh.factory<_i17.WilayahUseCase>(
        () => _i17.WilayahUseCase(gh<_i10.ILoginRepository>()));
    gh.factory<_i18.InitVolunteerUseCase>(
        () => _i18.InitVolunteerUseCase(gh<_i10.ILoginRepository>()));
    gh.factory<_i19.LoginCubit>(() => _i19.LoginCubit(
          gh<_i16.PasscodeUseCase>(),
          gh<_i18.InitVolunteerUseCase>(),
          gh<_i17.WilayahUseCase>(),
          gh<_i15.VolunteerUseCase>(),
          gh<_i14.CekUserUseCase>(),
        ));
    gh.factory<_i20.IHomeRepository>(() => _i21.HomeRepositoryImpl(
          gh<_i12.IHomeService>(),
          gh<_i3.InputResultMapper>(),
        ));
    gh.factory<_i22.InputResultUseCase>(
        () => _i22.InputResultUseCase(gh<_i20.IHomeRepository>()));
    gh.factory<_i23.CheckDataPilkadaUseCase>(
        () => _i23.CheckDataPilkadaUseCase(gh<_i20.IHomeRepository>()));
    gh.factory<_i24.CheckDataCubit>(
        () => _i24.CheckDataCubit(gh<_i23.CheckDataPilkadaUseCase>()));
    gh.factory<_i25.HomeCubit>(
        () => _i25.HomeCubit(gh<_i22.InputResultUseCase>()));
    return this;
  }
}
