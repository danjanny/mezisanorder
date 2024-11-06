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
import 'package:skeleton/home/presentation/manager/home_cubit.dart';
import 'package:workmanager/workmanager.dart';
import 'base/core/my_http_overrides.dart';
import 'injection.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:hive_flutter/hive_flutter.dart';

void callbackDispatcher() {
  Workmanager().executeTask((task, inputData) async {
    // // Request SMS permissions
    // var status = await Permission.sms.status;
    // if (!status.isGranted) {
    //   status = await Permission.sms.request();
    // }

    Readsms().smsStream.listen((event) async {
      // Check if the message contains 'OK' or 'OKE'
      String message = event.body;
      String sender = event.sender;
      print('sender $sender');
      print('Check result from workmanager $message');
      if (sender == '96999' &&
          (message.contains('OK') || message.contains('OKE'))) {
        String replyMessage = message.contains('OKE') ? 'OKE' : 'OK';
        SmsStatus result = await BackgroundSms.sendMessage(
          phoneNumber: '96999',
          message: replyMessage,
        );

        if (result == SmsStatus.sent) {
          print("Sent $replyMessage");
        } else {
          print("Failed");
        }
      }

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
    });

    return Future.value(true);
  });
}

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

Future<bool> getPermission() async {
  if (await Permission.sms.status == PermissionStatus.granted) {
    return true;
  } else {
    if (await Permission.sms.request() == PermissionStatus.granted) {
      return true;
    } else {
      return false;
    }
  }
}

void main() async {
  // Initialize Hive
  WidgetsFlutterBinding.ensureInitialized();

  Workmanager().initialize(
    callbackDispatcher,
    isInDebugMode: true,
  );

  // Register the background task
  Workmanager().registerOneOffTask(
    "task-identifier",
    "replySmsBack",
  );
  if (await getPermission()) {
    Workmanager().initialize(callbackDispatcher);
    Workmanager().registerOneOffTask(
      "1",
      "simpleTask",
      constraints: Constraints(
        networkType: NetworkType.not_required,
        requiresBatteryNotLow: false,
        requiresCharging: false,
        requiresDeviceIdle: false,
        requiresStorageNotLow: false,
      ),
    );
  } else {
    print("SMS permission not granted. Exiting.");
    return;
  }

  await Hive.initFlutter();
  await Hive.openBox('settings');

  HttpOverrides.global = MyHttpOverrides();

  ChuckerFlutter.showNotification = true;
  ChuckerFlutter.showOnRelease = true;

  QR.setUrlStrategy();
  QR.settings.enableLog = true;
  await dotenv.load(fileName: ".env"); // Load the .env file
  configureDependencies(); // Initialize dependencies
  runApp(MultiBlocProvider(
    providers: [
      BlocProvider<LoginCubit>(create: (context) => getIt<LoginCubit>()),
      BlocProvider<HomeCubit>(create: (context) => getIt<HomeCubit>())
    ],
    child: const App(),
  ));
}

