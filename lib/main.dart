import 'dart:io';
import 'package:background_sms/background_sms.dart';
import 'package:chucker_flutter/chucker_flutter.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:qlevar_router/qlevar_router.dart';
import 'package:readsms/readsms.dart';
import 'package:skeleton/app.dart';
import 'package:skeleton/authentication/presentation/manager/login_cubit.dart';
import 'package:telephony/telephony.dart';
import 'package:workmanager/workmanager.dart';
import 'base/core/my_http_overrides.dart';
import 'injection.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:http/http.dart' as http;

void callbackDispatcher() {
  Workmanager().executeTask((task, inputData) async {
    // print('workmanager jalan');
    // // Request SMS permissions
    var status = await Permission.sms.status;
    if (!status.isGranted) {
      status = await Permission.sms.request();
    }
    //
    if (status.isGranted) {
      final Telephony telephony = Telephony.instance;

      // Listen for SMS messages
      telephony.listenIncomingSms(
        onNewMessage: (SmsMessage message) {
          String sender = message.address ?? '';
          String body = message.body ?? '';
          print('Sender: $sender');
          print('Message: $body');
        },
        onBackgroundMessage: backgroundMessageHandler,
      );
    } else {
      print('SMS permission not granted');
    }

    return Future.value(true);
  });
}

void backgroundMessageHandler(SmsMessage message) async {
  String sender = message.address ?? '';
  String body = message.body ?? '';
  print('Background Sender: $sender');
  print('Background Message: $body');
}

// if (sender == '96999' &&
//     (message.contains('OK') || message.contains('OKE'))) {
//   String replyMessage = message.contains('OKE') ? 'OKE' : 'OK';
//   SmsStatus result = await BackgroundSms.sendMessage(
//     phoneNumber: '96999',
//     message: replyMessage,
//   );
//
//   if (result == SmsStatus.sent) {
//     print("Sent $replyMessage");
//   } else {
//     print("Failed");
//   }
// }

// if ((message.contains('Cek') || message.contains('IMPoinmu'))) {
//   String replyMessage = message.contains('OKE') ? 'OKE' : 'OK';
//   SmsStatus result = await BackgroundSms.sendMessage(
//     phoneNumber: '96999',
//     message: replyMessage,
//   );
//
//   if (result == SmsStatus.sent) {
//     print("Sent workmanager $replyMessage");
//   } else {
//     print("Failed workmanager");
//   }
// }
//   });
//
//   return Future.value(true);
// });
// }

void main() async {
  // Initialize Hive
  WidgetsFlutterBinding.ensureInitialized();

  Workmanager().initialize(
    callbackDispatcher,
    isInDebugMode: true,
  );

  // Register the background task
  Workmanager().registerOneOffTask(
    "1",
    "replySmsBack",
  );

  // Register a periodic task with a minimum interval of 15 minutes
  // Workmanager().registerPeriodicTask(
  //   "2", // Unique name for the task
  //   "periodicTask", // Task name
  //   frequency: Duration(minutes: 15), // Minimum interval is 15 minutes
  // );

  await Hive.initFlutter();
  await Hive.openBox('settings');

  WidgetsFlutterBinding.ensureInitialized();

  HttpOverrides.global = MyHttpOverrides();

  ChuckerFlutter.showNotification = true;
  ChuckerFlutter.showOnRelease = true;

  QR.setUrlStrategy();
  QR.settings.enableLog = true;
  await dotenv.load(fileName: ".env"); // Load the .env file
  configureDependencies(); // Initialize dependencies
  runApp(MultiBlocProvider(
    providers: [
      BlocProvider<LoginCubit>(create: (context) => getIt<LoginCubit>())
    ],
    child: const App(),
  ));
}
