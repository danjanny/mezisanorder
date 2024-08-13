import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:qlevar_router/qlevar_router.dart';
import 'package:skeleton/app.dart';
import 'package:skeleton/authentication/domain/use_cases/login_use_case.dart';
import 'package:skeleton/authentication/presentation/manager/login_cubit.dart';
import 'authentication/presentation/pages/home_page.dart';
import 'injection.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  QR.setUrlStrategy();
  QR.settings.enableLog = false;
  await dotenv.load(fileName: ".env"); // Load the .env file
  configureDependencies(); // Initialize dependencies
  runApp(MultiBlocProvider(
    providers: [
      BlocProvider<LoginCubit>(create: (context) => getIt<LoginCubit>())
    ],
    child: const App(),
  ));
}