import 'package:skeleton/authentication/domain/entities/init_result.dart';
import 'package:skeleton/authentication/domain/entities/wilayah_result.dart';
import 'package:skeleton/authentication/domain/params/init_volunteer_request.dart';
import '../entities/passcode.dart';
import '../entities/volunteer_result.dart';
import '../params/passcode_request.dart';

abstract class ILoginRepository {
  Future<InitResult?> initVolunteer(InitVolunteerRequestParams request);
  Future<Passcode?> submitPasscode(PasscodeRequest request);
  Future<WilayahResult?> getWilayah();
  Future<VolunteerResult?> getVolunteer();
}