import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:qlevar_router/qlevar_router.dart';
import 'package:skeleton/authentication/presentation/manager/login_cubit.dart';
import 'package:skeleton/authentication/presentation/manager/login_state.dart';
import 'package:skeleton/route/routes.dart';

import '../../domain/params/login_request.dart';
import 'dart:js' as js;
import 'package:js/js.dart';
import 'js_bridge.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  void _fetchApi() {
    const username = 'exampleUser';
    const password = 'examplePass';

    context
        .read<LoginCubit>()
        .login(LoginRequest(username: username, password: password));
  }

  void _fetchResultApi() {
    const username = 'exampleUser';
    const password = 'examplePass';

    context
        .read<LoginCubit>()
        .loginResult(LoginRequest(username: username, password: password));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            BlocConsumer<LoginCubit, LoginState>(listener: (context, state) {
              if (state is LoginLoadedState) {
                var bottomSheetController = showBottomSheet(
                  context: context,
                  builder: (context) {
                    return Container(
                      color: Colors.blue[100],
                      height: 200,
                      child: const Center(
                        child: Text('Data has successfully loaded'),
                      ),
                    );
                  },
                );
                Future.delayed(const Duration(seconds: 2), () {
                  bottomSheetController.close();
                  QR.to(AppRoutes.homePath);
                });
              }
            }, builder: (context, state) {
              if (state is LoginLoadingState) {
                return const Center(child: CircularProgressIndicator());
              } else if (state is LoginLoadedState) {
                return Center(
                    child: Column(
                  children: [
                    if (state.user != null)
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            'LoginSuccess : ${state.user.toString()}',
                            style: Theme.of(context).textTheme.bodySmall,
                          ),
                          const SizedBox(
                            height: 20.0,
                          ),
                          Text(
                            'Name : ${state.user?.fullName}',
                            style: Theme.of(context).textTheme.bodyLarge,
                          ),
                          Text(
                            'Email : ${state.user?.email}',
                            style: Theme.of(context).textTheme.bodyMedium,
                          ),
                        ],
                      ),
                    const SizedBox(height: 20.0),
                    if (state.userResult != null &&
                        state.userResult!.items != null)
                      ...state.userResult!.items!.map((item) => Column(
                            children: [
                              Text(
                                'Name : ${item.fullName}',
                                style: Theme.of(context).textTheme.bodyLarge,
                              ),
                              Text(
                                'Email : ${item.email}',
                                style: Theme.of(context).textTheme.bodyMedium,
                              ),
                              const SizedBox(
                                height: 20.0,
                              ),
                            ],
                          )),
                  ],
                ));
              } else if (state is LoginErrorState) {
                return Text(
                  'Error: ${state.message}',
                  style: Theme.of(context).textTheme.bodyMedium,
                );
              } else {
                return Container();
              }
            }),
          ],
        ),
      ),
      floatingActionButton: Stack(
        children: <Widget>[
          Positioned(
            bottom: 80.0,
            right: 10.0,
            child: FloatingActionButton(
              onPressed: _fetchResultApi, // First FAB action
              tooltip: 'Fetch API',
              child: const Icon(Icons.refresh),
            ),
          ),
          Positioned(
            bottom: 10.0,
            right: 10.0,
            child: FloatingActionButton(
              onPressed: _captureEntirePage, // Second FAB action
              tooltip: 'Screen Capture',
              child: const Icon(Icons.camera_alt),
            ),
          ),
        ],
      ),
    );
  }

  @override
  void initState() {
    super.initState();
  }

  void _captureEntirePage() {
    final greeting = greet('Flutter Web App Developer');
    print(greeting);
  }
}
