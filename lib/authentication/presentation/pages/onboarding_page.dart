import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:qlevar_router/qlevar_router.dart';
import '../../../base/presentation/button/quickcount_custom_button.dart';
import '../manager/login_cubit.dart';
import '../manager/login_state.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:skeleton/route/routes.dart';
import 'package:hive_flutter/hive_flutter.dart';

class OnboardingPage extends StatefulWidget {
  const OnboardingPage({Key? key}) : super(key: key);

  @override
  State<OnboardingPage> createState() => _OnboardingPageState();
}

class _OnboardingPageState extends State<OnboardingPage> {
  var box = Hive.box('settings');

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<LoginCubit, LoginState>(
      listener: (context, state) {
      },
      builder: (context, state) {
        return Scaffold(
          appBar: AppBar(
            backgroundColor: Colors.white,
            title: Image.asset(
              'assets/images/company_logo.png',
              width: 200,
              height: 100,
            ),
            centerTitle: true,
            toolbarHeight: 80,
          ),
          body: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Column(
              children: [
                Expanded(
                  child: Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SvgPicture.asset(
                          'assets/images/illustration_voting.svg',
                          width: double.infinity,
                          height: 300,
                          fit: BoxFit.contain,
                        ),
                        const SizedBox(height: 40),
                        const Text(
                          'Quick Count Pilkada 2024',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 34,
                            fontWeight: FontWeight.bold,
                            color: Colors.black,
                          ),
                        ),
                        const SizedBox(height: 22),
                        const Text(
                          'Masuk ke akun Anda untuk memulai. Pantau dan analisis hasil pemilihan dengan cepat dan akurat.',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.normal,
                            color: Colors.grey,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                QuickcountButton(
                  text: 'Mulai',
                  state: QuickcountButtonState.enabled,
                  onPressed: () {
                    box.get('isPasscodeFilled', defaultValue: false) ? QR.to(AppRoutes.registerPath) : QR.to(AppRoutes.passcodePath);

                  },
                ),
                const SizedBox(height: 36),
              ],
            ),
          ),
          backgroundColor: Colors.white,
        );
      },
    );
  }
}