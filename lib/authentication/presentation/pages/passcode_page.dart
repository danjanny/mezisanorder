import 'package:device_info_plus/device_info_plus.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:qlevar_router/qlevar_router.dart';
import '../../../base/presentation/styles/text_form_field_style.dart';
import '../../../base/presentation/styles/text_styles.dart';
import '../../../base/presentation/button/quickcount_custom_button.dart';
import '../../../base/presentation/textformfield/app_colors.dart';
import '../../../base/presentation/textformfield/quickcount_text_form_field.dart';
import '../../domain/params/login_request.dart';
import '../../domain/params/passcode_request.dart';
import '../manager/login_cubit.dart';
import '../manager/login_state.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:skeleton/route/routes.dart';

class PasscodePage extends StatefulWidget {
  const PasscodePage({Key? key}) : super(key: key);

  @override
  _PasscodePageState createState() => _PasscodePageState();
}

class _PasscodePageState extends State<PasscodePage> {
  String passcode = '';
  String _deviceId = '';
  static final DeviceInfoPlugin deviceInfoPlugin = DeviceInfoPlugin();
  final Box box = Hive.box('settings');

  @override
  void initState() {
    super.initState();
    _initPlatformState();
  }

  Future<void> _initPlatformState() async {
    var deviceData = <String, dynamic>{};

    try {
      deviceData = switch (defaultTargetPlatform) {
        TargetPlatform.android =>
            _readAndroidBuildData(await deviceInfoPlugin.androidInfo),
        TargetPlatform.iOS =>
            _readIosDeviceInfo(await deviceInfoPlugin.iosInfo),
      // Not implemented yet
        TargetPlatform.fuchsia => throw UnimplementedError(),
        TargetPlatform.linux => throw UnimplementedError(),
        TargetPlatform.macOS => throw UnimplementedError(),
        TargetPlatform.windows => throw UnimplementedError(),
      };
    } on PlatformException {
      deviceData = <String, dynamic>{
        'Error:': 'Failed to get platform version.'
      };
    }

    if (!mounted) return;

    setState(() {
      _deviceId = deviceData['id'] ?? '';
    });
  }

  Map<String, dynamic> _readIosDeviceInfo(IosDeviceInfo data) {
    return <String, dynamic>{
      'name': data.name,
      'systemName': data.systemName,
      'systemVersion': data.systemVersion,
      'model': data.model,
      'localizedModel': data.localizedModel,
      'identifierForVendor': data.identifierForVendor,
      'isPhysicalDevice': data.isPhysicalDevice,
      'utsname.sysname:': data.utsname.sysname,
      'utsname.nodename:': data.utsname.nodename,
      'utsname.release:': data.utsname.release,
      'utsname.version:': data.utsname.version,
      'utsname.machine:': data.utsname.machine,
    };
  }

  Map<String, dynamic> _readAndroidBuildData(AndroidDeviceInfo build) {
    return <String, dynamic>{
      'version.securityPatch': build.version.securityPatch,
      'version.sdkInt': build.version.sdkInt,
      'version.release': build.version.release,
      'version.previewSdkInt': build.version.previewSdkInt,
      'version.incremental': build.version.incremental,
      'version.codename': build.version.codename,
      'version.baseOS': build.version.baseOS,
      'board': build.board,
      'bootloader': build.bootloader,
      'brand': build.brand,
      'device': build.device,
      'display': build.display,
      'fingerprint': build.fingerprint,
      'hardware': build.hardware,
      'host': build.host,
      'id': build.id,
      'manufacturer': build.manufacturer,
      'model': build.model,
      'product': build.product,
      'supported32BitAbis': build.supported32BitAbis,
      'supported64BitAbis': build.supported64BitAbis,
      'supportedAbis': build.supportedAbis,
      'tags': build.tags,
      'type': build.type,
      'isPhysicalDevice': build.isPhysicalDevice,
      'systemFeatures': build.systemFeatures,
      'serialNumber': build.serialNumber,
      'isLowRamDevice': build.isLowRamDevice,
    };
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<LoginCubit, LoginState>(
      listener: (context, state) {
        if (state is PasscodeLoadedState) {
          context.read<LoginCubit>().cekUser(_deviceId);
        } else if (state is LoginErrorState) {
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
                          backgroundColor: AppColors.primaryColor,
                          minimumSize: const Size(double.infinity, 50),
                        ),
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        child: const Text('OK'),
                      ),
                    ),
                  ],
                ),
              );
            },
          );
        } else if (state is InitVolunteerLoadedState) {
          if (state.initResult == null) {
            QR.navigator.popUntilOrPush(AppRoutes.registerPath);
          } else {
            if ((box.get('locationCode1', defaultValue: '') ?? '') == '' ||
                (box.get('locationCode1', defaultValue: '') ?? '') == null) {
              QR.navigator.popUntilOrPush(AppRoutes.registerPath);
            } else {
              QR.navigator.popUntilOrPush(AppRoutes.homePath);
            }
          }
        }
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
          body: Stack(
            children: [
              SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    color: const Color(0xFFE5E5E5),
                    height: 8,
                  ),
                  const SizedBox(height: 24),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16.0),
                    child: Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            'Masukkan passcode',
                            textAlign: TextAlign.start,
                            style: TextStyle(
                              fontSize: 24,
                              fontWeight: FontWeight.bold,
                              color: Colors.black,
                            ),
                          ),
                          const Text(
                            'Passcode hanya diberikan kepada individu atau instansi yang memiliki tanggung jawab dan kewajiban terkait dengan proses penghitungan suara.',
                            textAlign: TextAlign.start,
                            style: TextStyle(
                              fontSize: 15,
                              color: Colors.grey,
                            ),
                          ),
                          const SizedBox(height: 32),
                          QuickcountTextFormField(
                            keyboardType: TextInputType.number,
                            defaultValue: passcode,
                            isObsecured: true,
                            obscureText: true,
                            titleLabel: 'Passcode',
                            inputLabel: 'Masukkan passcode',
                            onChange: (value) {
                              setState(() {
                                passcode = value;
                              });
                            },
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 32),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16.0),
                    child: QuickcountButton(
                      text: 'Lanjutkan',
                      state: QuickcountButtonState.enabled,
                      onPressed: () {
                        context.read<LoginCubit>().passcode(
                          PasscodeRequest(
                            passcode: passcode,
                          ),
                        );
                      },
                    ),
                  ),
                  const SizedBox(height: 36),
                ],
              ),
            ),
              if (state is LoginLoadingState)
                Container(
                  color: Colors.white.withOpacity(0.5),
                  child: const Center(
                    child: CircularProgressIndicator(),
                  ),
                ),
            ]
          ),
          backgroundColor: Colors.white,
        );
      },
    );
  }
}
