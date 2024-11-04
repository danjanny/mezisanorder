import 'dart:io';
import 'package:chucker_flutter/chucker_flutter.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:qlevar_router/qlevar_router.dart';
import 'package:skeleton/app.dart';
import 'package:skeleton/authentication/presentation/manager/login_cubit.dart';
import 'package:sms_advanced/sms_advanced.dart';
import 'package:workmanager/workmanager.dart';
import 'authentication/domain/entities/init_result.dart';
import 'base/core/my_http_overrides.dart';
import 'injection.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:hive_flutter/hive_flutter.dart';

void callbackDispatcher() {
  Workmanager().executeTask((task, inputData) async {
    // This is the background task
    SmsReceiver receiver = SmsReceiver();
    receiver.onSmsReceived?.listen((SmsMessage msg) {
      // Handle received SMS
      print('Received SMS: ${msg.body}');
      // Check if the message contains 'OK' or 'OKE'
      if (msg.body != null &&
          (msg.body!.contains('OK') || msg.body!.contains('OKE'))) {
        String replyMessage = msg.body!.contains('OKE') ? 'OKE' : 'OK';

        // Reply to the SMS
        SmsSender sender = SmsSender();
        sender.sendSms(SmsMessage('96999', replyMessage));
      }
    });
    return Future.value(true);
  });
}

void requestPermissions() async {
  await Permission.sms.request();
}

void main() async {
  // Initialize Hive
  WidgetsFlutterBinding.ensureInitialized();

  requestPermissions();

  // workmanager : handle receive sms process in the background
  Workmanager().initialize(
    callbackDispatcher,
    isInDebugMode: true, // Set to false in production
  );
  Workmanager().registerOneOffTask(
    "1",
    "simpleTask",
  );

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
