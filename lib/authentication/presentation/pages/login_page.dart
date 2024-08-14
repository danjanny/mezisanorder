import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../base/presentation/styles/text_form_field_style.dart';
import '../../../base/presentation/styles/text_styles.dart';
import '../../domain/params/login_request.dart';
import '../manager/login_cubit.dart';
import '../manager/login_state.dart';

class LoginPage extends StatelessWidget {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocConsumer<LoginCubit, LoginState>(
        listener: (context, state) {
          if (state is LoginErrorState) {
            _usernameController.clear();
            _passwordController.clear();

            showModalBottomSheet(
              context: context,
              builder: (context) {
                return Container(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(state.message ?? 'General Error'),
                      SizedBox(height: 16.0),
                      SizedBox(
                        width: double.infinity,
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            foregroundColor: Colors.white,
                            backgroundColor: Colors.blue,
                            minimumSize: Size(double.infinity,
                                50), // full width and height 50
                          ),
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          child: Text('OK'),
                        ),
                      ),
                    ],
                  ),
                );
              },
            );
          }
        },
        builder: (context, state) {
          if (state is LoginLoadingState) {
            return Center(child: CircularProgressIndicator());
          }

          return Center(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(16.0),
              child: Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Username', style: TextStyles.body12Medium),
                    SizedBox(height: 10),
                    TextFormField(
                      controller: _usernameController,
                      decoration: TextFormFieldStyle.getDecoration(
                        TextFormFieldStatus.disabled,
                        'Enter your username',
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter your username';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 16.0),
                    Text('Password', style: TextStyles.body12Medium),
                    SizedBox(height: 10),
                    TextFormField(
                      controller: _passwordController,
                      decoration: TextFormFieldStyle.getDecoration(
                        TextFormFieldStatus.defaultStatus,
                        'Enter your password',
                      ),
                      obscureText: true,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter your password';
                        }
                        return null;
                      },
                    ),
                    SizedBox(height: 16.0),
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          foregroundColor: Colors.white,
                          backgroundColor: Colors.blue, // text color
                          minimumSize: Size(
                              double.infinity, 50), // full width and height 50
                        ),
                        onPressed: () {
                          if (_formKey.currentState!.validate()) {
                            final loginRequest = LoginRequest(
                              username: _usernameController.text,
                              password: _passwordController.text,
                            );
                            context.read<LoginCubit>().login(loginRequest);
                          }
                        },
                        child: const Text('Submit'),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
