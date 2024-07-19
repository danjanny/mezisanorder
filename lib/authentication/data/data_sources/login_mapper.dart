import 'package:injectable/injectable.dart';
import 'package:skeleton/authentication/data/models/user_model.dart';
import 'package:skeleton/authentication/domain/entities/user.dart';

@Injectable()
class LoginMapper {
  User fromUserModelToUser(UserModel userModel) {
    return User(
      userModel.id,
      userModel.fullName,
      userModel.username,
      userModel.email,
    );
  }
}
