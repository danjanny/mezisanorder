import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:skeleton/authentication/domain/entities/user_result.dart';
import 'package:skeleton/base/data/data_sources/error_exception.dart';

import 'home_state.dart';

@injectable
class HomeCubit extends Cubit<HomeState> {
  HomeCubit() : super(HomeInitialState());
}
