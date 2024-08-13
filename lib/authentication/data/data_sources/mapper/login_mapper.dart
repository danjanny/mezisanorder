import 'package:injectable/injectable.dart';
import 'package:skeleton/authentication/data/models/user_model.dart';
import 'package:skeleton/authentication/domain/entities/user.dart';

import '../../models/user_result_model.dart';
import '../../../domain/entities/user_result.dart';

@Injectable()
class LoginMapper {
  User fromUserModelToUser(UserResponseModel userModel) {
    return User(
      id: userModel.data?.id,
      fullName: userModel.data?.fullName,
      username: userModel.data?.username,
      email: userModel.data?.email,
    );
  }

  UserResult mapUserResultModelToUserResult(UserResultModel model) {
    List<User>? users = model.items!
        .map((userModel) => User(
              id: userModel.id,
              fullName: userModel.fullName,
              username: userModel.username,
              email: userModel.email,
            ))
        .toList();

    return UserResult(items: users);
  }
}
