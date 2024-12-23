import 'dart:convert';
import 'package:crypto/crypto.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:qlevar_router/qlevar_router.dart';
import 'package:skeleton/authentication/domain/entities/wilayah_result.dart';
import 'package:skeleton/authentication/domain/params/init_volunteer_request.dart';
import '../../../base/presentation/button/quickcount_custom_button.dart';
import '../../../base/presentation/textformfield/app_colors.dart';
import '../../../base/presentation/textformfield/quickcount_text_form_field.dart';
import '../../domain/entities/volunteer.dart';
import '../../domain/entities/volunteer_result.dart';
import '../../domain/entities/wilayah.dart';
import '../manager/login_cubit.dart';
import '../manager/login_state.dart';
import 'package:skeleton/route/routes.dart';
import 'package:device_info_plus/device_info_plus.dart';
import 'package:mobile_device_identifier/mobile_device_identifier.dart';

class FormFieldData {
  final String titleLabel;
  final String inputLabel;
  List<Wilayah> dropdownItemsWilayah = [];
  List<Volunteer> dropdownItemsVolunteer = [];
  final String? selectedDropdownItem;
  final String? helperText;
  String? value;
  String? formFieldType;
  bool? isNeedValidation;

  FormFieldData(
      {required this.titleLabel,
      required this.inputLabel,
      this.dropdownItemsVolunteer = const [],
      this.dropdownItemsWilayah = const [],
      this.selectedDropdownItem,
      this.helperText,
      this.value,
      this.formFieldType,
      this.isNeedValidation = true});
}

class RegisterPage extends StatefulWidget {
  const RegisterPage({Key? key}) : super(key: key);

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  InitVolunteerRequestParams paramRequest = InitVolunteerRequestParams(
      idInisiasi: '',
      idWilayah: '',
      idTypeRelawan: '',
      kodeLokasi1: '',
      kodeLokasi2: '',
      nama: '',
      noHandphone1: '',
      noHandphone2: '',
      deviceId: '',
      model: '',
      brand: '',
      verSdkInt: '',
      fingerprint: '',
      serialnumber: '');
  String _deviceId = '';
  String _model = '';
  int _verSdkInt = 0;
  String _fingerprint = '';
  String _serialnumber = '';
  String _brand = '';
  static final DeviceInfoPlugin deviceInfoPlugin = DeviceInfoPlugin();
  String _uuid = '';
  WilayahResult? wilayahResult;
  VolunteerResult? volunteerResult;

  @override
  void initState() {
    super.initState();
    _initializeData();
    getData();
  }

  Future<void> _initializeData() async {
    await Future.wait([
      context.read<LoginCubit>().getVolunteer(),
      context.read<LoginCubit>().getWilayah(),
      _initPlatformState(),
    ]);
  }

  Future<void> _initData() async {
    try {
      _deviceId = generateUniqueDeviceId(await deviceInfoPlugin.androidInfo);
      _model = generateModel(await deviceInfoPlugin.androidInfo);
      _verSdkInt = generateSdkInt(await deviceInfoPlugin.androidInfo);
      _fingerprint = generateFingerprint(await deviceInfoPlugin.androidInfo);
      _serialnumber = generateSerialNumber(await deviceInfoPlugin.androidInfo);
      _brand = generateBrand(await deviceInfoPlugin.androidInfo);
      print('Device ID: $_deviceId');
    } catch (e) {
      print('Error in _initData: $e');
    }
  }

  Future<void> _initPlatformState() async {
    var deviceData = <String, dynamic>{};

    try {
      deviceData = switch (defaultTargetPlatform) {
        TargetPlatform.android =>
          await _readAndroidBuildData(await deviceInfoPlugin.androidInfo),
        TargetPlatform.iOS => throw UnimplementedError(),
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

    setState(() async {
      // Generate unique device ID for Android
      _deviceId = generateUniqueDeviceId(await deviceInfoPlugin.androidInfo);
      print("Device ID: " + _deviceId);
      // Update paramRequest with device data
      paramRequest = paramRequest.copyWith(
        deviceId: _deviceId,
        brand: _brand,
        model: _model,
        verSdkInt: _verSdkInt.toString(),
        fingerprint: _fingerprint,
        serialnumber: _serialnumber,
      );
    });
  }

  String generateBrand(AndroidDeviceInfo build) {
    return build.brand;
  }

  String generateModel(AndroidDeviceInfo build) {
    return build.model;
  }

  int generateSdkInt(AndroidDeviceInfo build) {
    return build.version.sdkInt;
  }

  String generateFingerprint(AndroidDeviceInfo build) {
    return build.fingerprint;
  }

  String generateSerialNumber(AndroidDeviceInfo build) {
    return build.serialNumber;
  }

  getData() async {
    await generateDeviceId();
    _initData();
  }

  final _mobileDeviceIdentifierPlugin = MobileDeviceIdentifier();

  Future<String?> generateDeviceId() async {
    String deviceId;
    try {
      deviceId = await _mobileDeviceIdentifierPlugin.getDeviceId() ??
          'Unknown platform version';
    } on PlatformException {
      deviceId = 'Failed to get platform version.';
    }
    setState(() {
      _uuid = deviceId;
    });
  }

  String generateUniqueDeviceId(AndroidDeviceInfo build) {
    String data = _uuid +
        build.id +
        build.brand +
        build.device +
        build.model +
        build.fingerprint +
        build.hardware;
    var bytes = utf8.encode(data);
    var hash = sha256.convert(bytes);
    print('Device ID beneran: ${_uuid}');
    print('Build ID beneran: ${build.id}');
    print('Device ID hasil beneran: ${hash.toString()}');
    return hash.toString();
  }

  Map<String, dynamic> _readAndroidBuildData(AndroidDeviceInfo build) {
    String uniqueDeviceId = generateUniqueDeviceId(build);
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
      'uniqueDeviceId': uniqueDeviceId,
    };
  }

  @override
  Widget build(BuildContext context) {
    final List<FormFieldData> formFields = [
      FormFieldData(
        titleLabel: "Wilayah Pilkada",
        inputLabel: "Pilih Wilayah",
        dropdownItemsWilayah: wilayahResult?.wilayah ??
            [Wilayah(id: '', title: '', alias: '', jumlahCalon: '')],
        helperText: null,
      ),
      FormFieldData(
        titleLabel: "Jenis Relawan",
        inputLabel: "Pilih Jenis Relawan",
        dropdownItemsVolunteer:
            volunteerResult?.volunteer ?? [Volunteer(id: '', tipeRelawan: '')],
        helperText: null,
      ),
      FormFieldData(
          titleLabel: "Kode Lokasi 1",
          inputLabel: "Masukkan Kode Lokasi 1",
          helperText: "Periksa kembali kode lokasi yang diberikan.",
          formFieldType: "allCaps"),
      FormFieldData(
          titleLabel: "Kode Lokasi 2",
          inputLabel: "Masukkan Kode Lokasi 2",
          helperText:
              "(Tidak wajib diisi) Periksa kembali kode lokasi yang diberikan.",
          formFieldType: "allCaps",
          isNeedValidation: false),
      FormFieldData(
          titleLabel: "Nama",
          inputLabel: "Masukkan Nama",
          helperText: null,
          formFieldType: "allCaps"),
      FormFieldData(
          titleLabel: "No Handphone 1",
          inputLabel: "Masukkan No Handphone 1",
          helperText: "Nomor handphone adalah nomor aktif yang dapat dihubungi",
          formFieldType: "number"),
      FormFieldData(
          titleLabel: "No Handphone 2",
          inputLabel: "Masukkan No Handphone 2",
          helperText: "Nomor handphone adalah nomor aktif yang dapat dihubungi",
          formFieldType: "number",
          isNeedValidation: false),
    ];

    void _updateFieldValue(
        int index, String newValue, Wilayah? wilayah, Volunteer? volunteer) {
      setState(() {
        formFields[index].value = newValue;
        print('Device Id: $_deviceId');
        paramRequest = paramRequest.copyWith(
          deviceId: _deviceId,
          brand: _brand,
          model: _model,
          verSdkInt: _verSdkInt.toString(),
          fingerprint: _fingerprint,
          serialnumber: _serialnumber,
        );

        switch (index) {
          case 0:
            paramRequest = paramRequest.copyWith(idWilayah: wilayah?.id);
            break;
          case 1:
            paramRequest = paramRequest.copyWith(idTypeRelawan: volunteer?.id);
            break;
          case 2:
            paramRequest = paramRequest.copyWith(kodeLokasi1: newValue);
            break;
          case 3:
            paramRequest = paramRequest.copyWith(kodeLokasi2: newValue);
            break;
          case 4:
            paramRequest = paramRequest.copyWith(nama: newValue);
            break;
          case 5:
            paramRequest = paramRequest.copyWith(noHandphone1: newValue);
            break;
          case 6:
            paramRequest = paramRequest.copyWith(noHandphone2: newValue);
            break;
        }
      });
    }

    return BlocConsumer<LoginCubit, LoginState>(
      listener: (context, state) {
        if (state is InitVolunteerLoadedState) {
          QR.navigator.popUntilOrPush(AppRoutes.homePath);
        } else if (state is LoginErrorState) {
          showModalBottomSheet(
            isDismissible: false,
            enableDrag: false,
            context: context,
            builder: (context) {
              return Container(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(state.message ?? 'General Error'),
                    const SizedBox(height: 16.0),
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
        } else if (state is WilayahLoadedState) {
          setState(() {
            wilayahResult = state.wilayahResult;
            formFields[0].dropdownItemsWilayah = wilayahResult?.wilayah ?? [];
          });
        } else if (state is VolunteerLoadedState) {
          setState(() {
            volunteerResult = state.volunteerResult;
            formFields[1].dropdownItemsVolunteer =
                volunteerResult?.volunteer ?? [];
          });
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
          body: Stack(children: [
            Column(
              children: [
                Expanded(
                  child: SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          color: const Color(0xFFE5E5E5),
                          height: 8,
                        ),
                        const SizedBox(height: 24),
                        const Padding(
                          padding: EdgeInsets.symmetric(horizontal: 16.0),
                          child: Text(
                            'Daftar Inisiasi Relawan',
                            textAlign: TextAlign.start,
                            style: TextStyle(
                              fontSize: 24,
                              fontWeight: FontWeight.bold,
                              color: Colors.black,
                            ),
                          ),
                        ),
                        const SizedBox(height: 32),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 16.0),
                          child: Form(
                            key: _formKey,
                            child: ListView.builder(
                              shrinkWrap: true,
                              physics: const NeverScrollableScrollPhysics(),
                              itemCount: formFields.length,
                              itemBuilder: (context, index) {
                                final fieldData = formFields[index];
                                final fieldType = fieldData.formFieldType;
                                final isNeedValidation =
                                    fieldData.isNeedValidation;
                                return Padding(
                                  padding: const EdgeInsets.only(bottom: 16.0),
                                  child: QuickcountTextFormField(
                                    validator: isNeedValidation == true
                                        ? (String? value) {
                                            if (value == "" || value!.isEmpty) {
                                              return "Harus diisi";
                                            }

                                            return null;
                                          }
                                        : null,
                                    showDropdown: fieldData
                                            .dropdownItemsVolunteer
                                            .isNotEmpty ||
                                        fieldData
                                            .dropdownItemsWilayah.isNotEmpty,
                                    onDropdownChanged: (String? value) {
                                      _updateFieldValue(
                                          index,
                                          value ?? '',
                                          null,
                                          fieldData.dropdownItemsVolunteer
                                              .firstWhere(
                                                  (element) =>
                                                      element.tipeRelawan ==
                                                      value,
                                                  orElse: () => Volunteer(
                                                      id: '',
                                                      tipeRelawan: '')));
                                      _updateFieldValue(
                                          index,
                                          value ?? '',
                                          fieldData.dropdownItemsWilayah
                                              .firstWhere(
                                                  (element) =>
                                                      element.title == value,
                                                  orElse: () => Wilayah(
                                                      id: '',
                                                      title: '',
                                                      alias: '',
                                                      jumlahCalon: '')),
                                          null);
                                    },
                                    dropdownItems: fieldData
                                            .dropdownItemsVolunteer.isNotEmpty
                                        ? fieldData.dropdownItemsVolunteer
                                            .map((e) => e.tipeRelawan)
                                            .toList()
                                        : fieldData.dropdownItemsWilayah
                                            .map((e) => e.title)
                                            .toList(),
                                    selectedDropdownItem:
                                        fieldData.selectedDropdownItem,
                                    showHelper: fieldData.helperText != null,
                                    helperLabel: fieldData.helperText ?? '',
                                    titleLabel: fieldData.titleLabel,
                                    inputLabel: fieldData.inputLabel,
                                    defaultValue: fieldData.value,
                                    onChange: (value) {
                                      _updateFieldValue(
                                          index, value, null, null);
                                    },
                                    inputFormatters: fieldType == 'allCaps'
                                        ? [UpperCaseTextFormatter()]
                                        : null,
                                    keyboardType: fieldType == 'number'
                                        ? TextInputType.number
                                        : TextInputType.text,
                                  ),
                                );
                              },
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 80),
              ],
            ),
            Positioned(
                bottom: 15,
                left: 0,
                right: 0,
                child: // i want to make this widget are positioned bottom of the stack
                    Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  child: QuickcountButton(
                    text: 'Lanjutkan',
                    state: QuickcountButtonState.enabled,
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        context.read<LoginCubit>().initVolunteer(paramRequest);
                      }
                    },
                  ),
                )),
            if (state is LoginLoadingState)
              Container(
                color: Colors.white.withOpacity(0.5),
                child: const Center(
                  child: CircularProgressIndicator(),
                ),
              ),
          ]),
          backgroundColor: Colors.white,
        );
      },
    );
  }
}

class UpperCaseTextFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
    TextEditingValue oldValue,
    TextEditingValue newValue,
  ) {
    return newValue.copyWith(
      text: newValue.text.toUpperCase(),
      selection: newValue.selection,
    );
  }
}
