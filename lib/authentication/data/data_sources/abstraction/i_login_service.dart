import 'package:http/http.dart' as http;
import '../../../domain/params/init_volunteer_request.dart';
import '../../../domain/params/passcode_request.dart';

abstract class ILoginService {
  Future<http.Response> initVolunteer(InitVolunteerRequestParams initVolunteerRequestParams);
  Future<http.Response> submitPasscode(PasscodeRequest passcodeRequest);
  Future<http.Response> getWilayah();
  Future<http.Response> getVolunteer();
}
