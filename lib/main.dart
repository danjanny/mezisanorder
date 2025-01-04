import 'dart:io';
import 'package:chucker_flutter/chucker_flutter.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:path_provider/path_provider.dart';
import 'package:qlevar_router/qlevar_router.dart';
import 'package:skeleton/app.dart';
import 'package:skeleton/order/presentation/manager/order_cubit.dart';
import 'base/core/my_http_overrides.dart';
import 'injection.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:hive_flutter/hive_flutter.dart';

void main() async {
  // Initialize Hive
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();
  await Hive.openBox('settings');

  HttpOverrides.global = MyHttpOverrides();

  // Hydrated cubit init
  final storage = await HydratedStorage.build(
    storageDirectory: kIsWeb
        ? HydratedStorage.webStorageDirectory
        : await getApplicationDocumentsDirectory(),
  );
  HydratedBloc.storage = storage;

  ChuckerFlutter.showNotification = false;
  ChuckerFlutter.showOnRelease = false;
  QR.setUrlStrategy();
  QR.settings.enableLog = false;
  await dotenv.load(fileName: ".env"); // Load the .env file
  configureDependencies(); // Initialize dependencies
  runApp(MultiBlocProvider(
    providers: [
      BlocProvider<OrderCubit>(create: (context) => getIt<OrderCubit>()),
    ],
    child: const App(),
  ));
}
