import 'package:injectable/injectable.dart';
import 'package:skeleton/authentication/data/models/passcode_model.dart';
import 'package:skeleton/authentication/data/models/user_model.dart';
import 'package:skeleton/authentication/domain/entities/passcode.dart';

import '../../models/user_result_model.dart';
import '../../../domain/entities/user_result.dart';


@Injectable()
class PasscodeMapper {
  Passcode fromPasscodeModelToPasscode(PasscodeResponseModel passcodeModel  ) {
    return Passcode(
      message: passcodeModel.responseMessage,
    );
  }
}
