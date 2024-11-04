import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:skeleton/home/domain/params/input_result_param.dart';
import 'package:skeleton/home/domain/use_cases/input_result_use_case.dart';
import '../../../base/data/data_sources/error_exception.dart';
import '../../domain/entities/input_result.dart';
import 'home_state.dart';

@injectable
class HomeCubit extends Cubit<HomeState> {
  final InputResultUseCase _inputResultUseCase;

  HomeCubit(this._inputResultUseCase)
      : super(HomeInitialState());

  Future<void> onSave() async {
    emit(HomeComingSoonState('Fitur ini akan segera hadir'));
  }

  Future<void> inputResult(InputResultParam inputParam) async {
    emit(HomeLoadingState());
    print("request input: ${inputParam.toJson()}");
    try {
      emit(HomeLoadingState());
      InputResult? result = await _inputResultUseCase.call(inputParam);
      print("result input: ${result?.status}");
      print("result input: ${result?.message}");
      if (result?.status?.toLowerCase() == "ok") {
        emit(HomeLoadedState(message: result?.message));
      } else {
        emit(HomeErrorState(message: result?.message));
      }
    } on HttpResponseException catch (e) {
      emit(HomeErrorState(
          statusCode: '${e.statusCode} ${e.status}', message: e.message));
    } catch (e) {
      emit(HomeErrorState(message: 'General Error : $e'));
    }
  }
}
