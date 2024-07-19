import 'dart:io';

import 'package:injectable/injectable.dart';
import 'package:skeleton/authentication/data/data_sources/abstraction/i_login_service.dart';
import 'package:skeleton/authentication/data/data_sources/login_mapper.dart';
import 'package:skeleton/authentication/data/data_sources/login_service_impl.dart';
import 'package:skeleton/authentication/data/models/user_model.dart';
import 'package:skeleton/authentication/domain/entities/user.dart';
import 'package:skeleton/base/data/repositories/base_repository.dart';
import '../../domain/repositories/i_login_repository.dart';
import '../models/request/login_request.dart';
import 'package:http/http.dart' as http;

@injectable
class LoginRepositoryImpl extends BaseRepository implements ILoginRepository {
  final ILoginService _loginService;
  final LoginMapper _loginMapper;

  LoginRepositoryImpl(this._loginService, this._loginMapper);

  @override
  Future<User?> submitLogin(LoginRequest loginRequest) async {
    final response =
        await executeRequest(() => _loginService.submitLogin(loginRequest));
    handleResponse(response);
    final userModel = UserModel.fromJson(decodeResponseBody(response));
    final user = _loginMapper.fromUserModelToUser(userModel);
    return user;
  }
}
