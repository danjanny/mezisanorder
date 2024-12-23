import 'package:background_sms/background_sms.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:injectable/injectable.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:skeleton/home/domain/params/input_result_param.dart';
import 'package:skeleton/home/domain/use_cases/input_result_use_case.dart';
import '../../../authentication/domain/params/init_volunteer_request.dart';
import '../../../base/data/data_sources/error_exception.dart';
import '../../domain/entities/input_result.dart';
import 'home_state.dart';

@injectable
class HomeCubit extends Cubit<HomeState> {
  final InputResultUseCase _inputResultUseCase;

  List<String> listNomorTelkomsel = [
    "0852",
    "0853",
    "0811",
    "0812",
    "0813",
    "0821",
    "0822",
    "0851",
    "0823"
  ];

  HomeCubit(this._inputResultUseCase) : super(HomeInitialState());

  Future<void> onSave() async {
    emit(HomeComingSoonState('Fitur ini akan segera hadir'));
  }

  // Future<void> sendSmsHasilPilkada(InputResultParam inputParam) async {
  //   var box = Hive.box('settings');
  //   String? idTypeRelawan = await box.get('idTypeRelawan',
  //       defaultValue: "1"); // default is Enumerator (1)
  //   String idTypeRelawanCode = (idTypeRelawan == "1")
  //       ? "Q"
  //       : (idTypeRelawan == "2")
  //           ? "S"
  //           : "1";
  //
  //   String formattedMessage = inputParam.toSmsFormattedString(
  //       idTypeRelawanCode); // convert inputParam into sms formatted string
  //
  //   print(formattedMessage);
  //
  //   String recipientPhoneNumber = '96999';
  //
  //   SmsSender sender = SmsSender();
  //   SmsMessage message = SmsMessage(recipientPhoneNumber, formattedMessage);
  //   sender.sendSms(message);
  // }

  // Future<void> sendSmsHasilPilkada(InputResultParam inputParam) async {
  //   var box = Hive.box('settings');
  //   String? idTypeRelawan = await box.get('idTypeRelawan',
  //       defaultValue: "1"); // default is Enumerator (1)
  //   String idTypeRelawanCode = (idTypeRelawan == "1")
  //       ? "Q"
  //       : (idTypeRelawan == "2")
  //           ? "S"
  //           : "1";
  //
  //   String formattedMessage = inputParam.toSmsFormattedString(
  //       idTypeRelawanCode); // convert inputParam into sms formatted string
  //
  //   print(formattedMessage);
  //
  //   String recipientPhoneNumber = '96999';
  //
  //   // Request SMS permission
  //   if (await Permission.sms.request().isGranted) {
  //     try {
  //       String result = await sendSMS(
  //         message: formattedMessage,
  //         recipients: [recipientPhoneNumber],
  //       );
  //       print(result);
  //     } catch (error) {
  //       print("Failed to send SMS: $error");
  //     }
  //   } else {
  //     print("SMS permission not granted");
  //   }
  // }

  Future<void> sendSmsCustomHasilPilkada(String message) async {
    var box = Hive.box('settings');
    print(message);

    String recipientPhoneNumber = '96999';
    if (await Permission.sms.request().isGranted) {
      try {
        SmsStatus result = await BackgroundSms.sendMessage(
          phoneNumber: recipientPhoneNumber,
          message: message,
        );
        if (result == SmsStatus.sent) {
          print("Sent");
        } else {
          print("Failed");
        }
      } catch (error) {
        print("Failed to send SMS: $error");
      }
    } else {
      print("SMS permission not granted");
    }
  }

  Future<void> sendSmsHasilPilkada(InputResultParam inputParam) async {
    var box = Hive.box('settings');
    String? idTypeRelawan = await box.get('idTypeRelawan',
        defaultValue: "1"); // default is Enumerator (1)
    String idTypeRelawanCode = (idTypeRelawan == "1")
        ? "Q"
        : (idTypeRelawan == "2")
            ? "S"
            : "1";

    String formattedMessage = inputParam.toSmsFormattedString(
        idTypeRelawanCode); // convert inputParam into sms formatted string

    print(formattedMessage);

    String recipientPhoneNumber = '96999';

    // Request SMS permission
    if (await Permission.sms.request().isGranted) {
      try {
        SmsStatus result = await BackgroundSms.sendMessage(
          phoneNumber: recipientPhoneNumber,
          message: formattedMessage,
        );
        if (result == SmsStatus.sent) {
          print("Sent");
        } else {
          print("Failed");
        }
      } catch (error) {
        print("Failed to send SMS: $error");
      }
    } else {
      print("SMS permission not granted");
    }
  }

  Future<void> inputResult(InputResultParam inputParam) async {
    emit(HomeLoadingState());
    print("request input: ${inputParam.toJson()}");
    try {
      emit(HomeLoadingState());

      // fetch user data
      final userData = await _initializeDataUser();

      // send hasil pilkada to sms gateway
      await sendSmsHasilPilkada(inputParam);

      // send hasil pilkada to API
      InputResult? result = await _inputResultUseCase.call(inputParam);
      print("result input: ${result?.status}");
      print("result input: ${result?.message}");
      if (result?.status?.toLowerCase() == "ok") {
        emit(HomeLoadedState(statusCode: result?.status, message: result?.message));
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

  Future<InitVolunteerRequestParams> _initializeDataUser() async {
    final Box box = Hive.box('settings');
    Map<dynamic, dynamic> dynamicMap =
        box.get('dataUser', defaultValue: {'nama': ''});
    Map<String, dynamic> retrievedData = Map<String, dynamic>.from(dynamicMap);
    InitVolunteerRequestParams? dataUser =
        InitVolunteerRequestParams.fromJson(retrievedData);
    return dataUser;
  }
}
