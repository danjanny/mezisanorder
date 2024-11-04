import 'package:injectable/injectable.dart';
import 'package:skeleton/authentication/data/data_sources/abstraction/i_login_service.dart';
import 'package:skeleton/authentication/data/data_sources/mapper/passcode_mapper.dart';
import 'package:skeleton/authentication/data/data_sources/mapper/wilayah_mapper.dart';
import 'package:skeleton/authentication/data/models/passcode_model.dart';
import 'package:skeleton/authentication/data/models/wilayah_model.dart';
import 'package:skeleton/authentication/domain/entities/init_result.dart';
import 'package:skeleton/authentication/domain/entities/passcode.dart';
import 'package:skeleton/authentication/domain/entities/volunteer_result.dart';
import 'package:skeleton/authentication/domain/entities/wilayah_result.dart';
import 'package:skeleton/authentication/domain/params/init_volunteer_request.dart';
import 'package:skeleton/authentication/domain/params/passcode_request.dart';
import 'package:skeleton/base/data/repositories/base_repository.dart';
import 'package:skeleton/home/data/data_sources/abstraction/i_home_service.dart';
import 'package:skeleton/home/data/data_sources/mapper/input_result_mapper.dart';
import '../../domain/entities/input_result.dart';
import '../../domain/params/input_result_param.dart';
import '../../domain/repositories/i_home_repository.dart';
import '../models/input_model.dart';

@Injectable(as: IHomeRepository)
class HomeRepositoryImpl extends BaseRepository implements IHomeRepository {
  final IHomeService _homeService;
  final InputResultMapper _inputResultMapper;

  HomeRepositoryImpl(this._homeService, this._inputResultMapper);

  @override
  Future<InputResult?> initResult(InputResultParam request) async {
    final response =  await executeRequest(() =>  _homeService.initResult(request));
    handleResponse(response);
    final input = InputResultModel.fromJson(decodeResponseBody(response));
    final inputResult = _inputResultMapper.fromInputModelToInputResult(input);
    return inputResult;
  }
}
