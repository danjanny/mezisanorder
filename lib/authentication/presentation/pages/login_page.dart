import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:skeleton/authentication/presentation/manager/login_cubit.dart';
import 'package:skeleton/authentication/presentation/manager/login_state.dart';

import '../../domain/params/login_request.dart';

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

    context.read<LoginCubit>().login(LoginRequest(username: username, password: password));
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
            BlocBuilder<LoginCubit, LoginState>(builder: (context, state) {
              if (state is LoginLoadingState) {
                return const Center(child: CircularProgressIndicator());
              } else if (state is LoginLoadedState) {
                return Center(
                    child: Column(
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
      floatingActionButton: FloatingActionButton(
        onPressed: _fetchApi,
        tooltip: 'Fetch Api',
        child: const Icon(Icons.add),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
