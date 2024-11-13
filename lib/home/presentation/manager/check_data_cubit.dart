import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:skeleton/home/domain/params/check_data_pilkada_request.dart';
import 'package:skeleton/home/domain/use_cases/check_data_pilkada_use_case.dart';

import 'check_data_state.dart';

@injectable
class CheckDataCubit extends Cubit<CheckDataState> {
  final CheckDataPilkadaUseCase _dataPilkadaUseCase;

  CheckDataCubit(this._dataPilkadaUseCase) : super(CheckDataInitialState());

  void checkData(CheckDataPilkadaRequest params) async {
    try {
      emit(CheckDataLoadingState());

      final dataPilkada = await _dataPilkadaUseCase.call(params);

      emit(CheckDataLoadedState(
          statusCode: dataPilkada?.status ?? '',
          message: dataPilkada?.message ?? '',
          data: dataPilkada?.data ?? []));
    } catch (e) {
      emit(CheckDataErrorState(statusCode: 'Error', message: e.toString()));
    }
  }
}
