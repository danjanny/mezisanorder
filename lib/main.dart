import 'dart:io';
import 'package:background_sms/background_sms.dart';
import 'package:chucker_flutter/chucker_flutter.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:qlevar_router/qlevar_router.dart';
import 'package:skeleton/app.dart';
import 'package:skeleton/authentication/presentation/manager/login_cubit.dart';
import 'package:sms_receiver/sms_receiver.dart';
import 'package:workmanager/workmanager.dart';
import 'base/core/my_http_overrides.dart';
import 'injection.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:hive_flutter/hive_flutter.dart';

void callbackDispatcher() {
  Workmanager().executeTask((task, inputData) async {
    // Request SMS permissions
    if (await Permission.sms.request().isGranted) {
      // This is the background task
      SmsReceiver receiver = SmsReceiver((String? message) async {
        // Handle received SMS
        print('Received SMS: $message');
        // Check if the message contains 'OK' or 'OKE'
        if (message != null &&
            (message.contains('OK') || message.contains('OKE'))) {
          String replyMessage = message.contains('OKE') ? 'OKE' : 'OK';

          // Reply to the SMS using background_sms to 96999
          SmsStatus result = await BackgroundSms.sendMessage(
            phoneNumber: '96999',
            message: replyMessage,
          );
          if (result == SmsStatus.sent) {
            print("Reply Sent");
          } else {
            print("Failed to send reply");
          }
        }
      });

      // Start listening for SMS
      await receiver.startListening();
    } else {
      print("SMS permission not granted");
    }
    return Future.value(true);
  });
}

void requestPermissions() async {
  await Permission.sms.request();
}

void main() async {
  // Initialize Hive
  WidgetsFlutterBinding.ensureInitialized();

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
