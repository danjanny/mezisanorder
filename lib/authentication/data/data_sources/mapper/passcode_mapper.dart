import 'package:injectable/injectable.dart';
import 'package:skeleton/authentication/data/models/passcode_model.dart';
import 'package:skeleton/authentication/domain/entities/passcode.dart';

@Injectable()
class PasscodeMapper {
  Passcode fromPasscodeModelToPasscode(PasscodeResponseModel passcodeModel  ) {
    return Passcode(
      message: passcodeModel.responseMessage,
      status: passcodeModel.responseCode,
    );
  }
}
