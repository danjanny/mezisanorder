import 'dart:convert';

import 'package:crypto/crypto.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:qlevar_router/qlevar_router.dart';
import 'package:skeleton/authentication/presentation/manager/login_cubit.dart';
import '../../../authentication/domain/entities/volunteer.dart';
import '../../../authentication/domain/entities/volunteer_result.dart';
import '../../../authentication/domain/entities/wilayah.dart';
import '../../../authentication/presentation/manager/login_state.dart';
import '../../../authentication/presentation/pages/register_page.dart';
import '../../../base/core/app_config.dart';
import '../../../base/presentation/button/quickcount_custom_button.dart';
import '../../../base/presentation/textformfield/app_colors.dart';
import '../../../base/presentation/textformfield/quickcount_text_form_field.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:skeleton/route/routes.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:skeleton/authentication/domain/entities/wilayah_result.dart';
import 'package:skeleton/authentication/domain/params/init_volunteer_request.dart';
import 'package:device_info_plus/device_info_plus.dart';

class FormFieldData {
  final String titleLabel;
  final String inputLabel;
  List<Wilayah> dropdownItemsWilayah = [];
  List<Volunteer> dropdownItemsVolunteer = [];
  String? selectedDropdownItem;
  final String? helperText;
  String? value;
  TextInputType? type = TextInputType.text;
  bool? isWilayah;
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
      this.type,
      this.isWilayah,
      this.formFieldType,
      this.isNeedValidation = true});
}

class EditProfilePage extends StatefulWidget {
  const EditProfilePage({Key? key}) : super(key: key);

  @override
  State<EditProfilePage> createState() => _EditProfilePageState();
}

class _EditProfilePageState extends State<EditProfilePage> {
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
      serialnumber: ''
  );

  String _deviceId = '';
  static final DeviceInfoPlugin deviceInfoPlugin = DeviceInfoPlugin();
  final Box box = Hive.box('settings');
  List<Wilayah>? wilayahs;
  VolunteerResult? volunteerResult;
  String? _idInisiasi;
  String _model = '';
  int _verSdkInt = 0;
  String _fingerprint = '';
  String _serialnumber = '';
  String _brand = '';

  @override
  void initState() {
    super.initState();
    _initData();
    _initializeData();
    _initializeDataUser();
    _initFields();
  }

  Future<void> _initData() async {
    _model = generateModel(await deviceInfoPlugin.androidInfo);
    _verSdkInt = generateSdkInt(await deviceInfoPlugin.androidInfo);
    _fingerprint = generateFingerprint(await deviceInfoPlugin.androidInfo);
    _serialnumber = generateSerialNumber(await deviceInfoPlugin.androidInfo);
    _brand = generateBrand(await deviceInfoPlugin.androidInfo);
    try {
      // Generate unique device ID for Android
      if (box.get('deviceId', defaultValue: '') == '') {
        setState(() async {
          _deviceId = generateUniqueDeviceId(await deviceInfoPlugin.androidInfo);
        });

        await box.put('deviceId', _deviceId);
      } else {
        setState(() {
          _deviceId = box.get('deviceId', defaultValue: '') ?? '';
        });

      }
      print('Device ID: $_deviceId');
    } catch (e) {
      print('Error in _initData: $e');
    }
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

  String generateUniqueDeviceId(AndroidDeviceInfo build) {
    String data = build.brand + build.device + build.model + build.fingerprint + build.hardware;
    var bytes = utf8.encode(data);
    var hash = sha256.convert(bytes);
    return hash.toString();
  }

  _initFields() {
    formFields = [
      FormFieldData(
        titleLabel: "Wilayah Pilkada",
        inputLabel: "Pilih Wilayah",
        isWilayah: true,
        dropdownItemsWilayah: wilayahs ?? [],
        selectedDropdownItem: wilayahs
                ?.firstWhere(
                  (element) => element.id == paramRequest.idWilayah,
                  orElse: () =>
                      Wilayah(id: '', title: '', alias: '', jumlahCalon: ''),
                )
                .title ??
            '',
        helperText: null,
      ),
      FormFieldData(
        isWilayah: false,
        titleLabel: "Jenis Relawan",
        inputLabel: "Pilih Jenis Relawan",
        dropdownItemsVolunteer: volunteerResult?.volunteer ?? [],
        selectedDropdownItem: volunteerResult?.volunteer
                .firstWhere(
                  (element) => element.id == paramRequest.idTypeRelawan,
                  orElse: () => Volunteer(id: '', tipeRelawan: ''),
                )
                .tipeRelawan ??
            '',
        helperText: null,
      ),
      FormFieldData(
          titleLabel: "Kode Lokasi 1",
          inputLabel: "Masukkan Kode Lokasi 1",
          helperText: "Periksa kembali kode lokasi yang diberikan.",
          value: paramRequest.kodeLokasi1,
          formFieldType: "allCaps"
      ),
      FormFieldData(
          titleLabel: "Kode Lokasi 2",
          inputLabel: "Masukkan Kode Lokasi 2",
          helperText: "(Tidak wajib diisi) Periksa kembali kode lokasi yang diberikan.",
          value: paramRequest.kodeLokasi2,
          formFieldType: "allCaps",
          isNeedValidation: false
      ),
      FormFieldData(
          titleLabel: "Nama",
          inputLabel: "Masukkan Nama",
          helperText: null,
          value: paramRequest.nama,
          formFieldType: "allCaps"
      ),
      FormFieldData(
          titleLabel: "No Handphone 1",
          inputLabel: "Masukkan No Handphone 1",
          helperText: "Nomor handphone adalah nomor aktif yang dapat dihubungi",
          formFieldType: "number",
          value: paramRequest.noHandphone1),
      FormFieldData(
          titleLabel: "No Handphone 2",
          inputLabel: "Masukkan No Handphone 2",
          helperText: "Nomor handphone adalah nomor aktif yang dapat dihubungi",
          formFieldType: "number",
          value: paramRequest.noHandphone2,
          isNeedValidation: false),
    ];
  }

  void _initializeDataUser() {
    Map<dynamic, dynamic> dynamicMap =
        box.get('dataUser', defaultValue: {'nama': ''});
    Map<String, dynamic> retrievedData = Map<String, dynamic>.from(dynamicMap);
    String? idInisiasi = box.get('idInisiasi').toString();
    print('Id idInisiasi: $idInisiasi');
    InitVolunteerRequestParams? dataUser =
        InitVolunteerRequestParams.fromJson(retrievedData);

    setState(() {
      _idInisiasi = idInisiasi;
      print('Id Wilayah: ${paramRequest.idWilayah}');
      print('Id Volunteer: ${paramRequest.idTypeRelawan}');
      paramRequest = dataUser;
    });
  }

  Future<void> _initializeData() async {
    await Future.wait([
      context.read<LoginCubit>().getVolunteer(),
      context.read<LoginCubit>().getWilayah(),
      _initPlatformState(),
    ]);
  }

  Future<void> _initPlatformState() async {
    PermissionStatus status = await Permission.phone.request();
    var deviceData = <String, dynamic>{};

    try {
      deviceData = switch (defaultTargetPlatform) {
        TargetPlatform.android => await _readAndroidBuildData(await deviceInfoPlugin.androidInfo),
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
    setState(() {
      // Update paramRequest with device data
      paramRequest = paramRequest.copyWith(
        idInisiasi: _idInisiasi,
        deviceId: _deviceId,
        brand: _brand,
        model: _model,
        verSdkInt: _verSdkInt.toString(),
        fingerprint: _fingerprint,
        serialnumber: _serialnumber,
      );
    });
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
  List<FormFieldData> formFields = [];

  @override
  Widget build(BuildContext context) {
    void _updateFieldValue(
        int index, String newValue, Wilayah? wilayah, Volunteer? volunteer) {
      setState(() {
        formFields[index].value = newValue;
        print('Device Id: $_deviceId');
        print('IdInisiasis: $_idInisiasi');
        paramRequest = paramRequest.copyWith(
          deviceId: _deviceId,
          idInisiasi: _idInisiasi,
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
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text("Data telah tersimpan"),
              backgroundColor: Colors.green,
            ),
          );

          Future.delayed(const Duration(seconds: 2), () {
            QR.popUntilOrPush(AppRoutes.homePath);
          });
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
        } else if (state is WilayahLoadedState ||
            state is VolunteerLoadedState) {
          setState(() {
            if (state is WilayahLoadedState) {
              WilayahResult? wilayah = state.wilayahResult;
              print('Isinya apa wilayah? ${wilayah?.wilayah.toString()}');
              wilayahs = state.wilayahResult?.wilayah;
            }

            if (state is VolunteerLoadedState) {
              volunteerResult = state.volunteerResult;
              print(
                  'Isinya apa volunteer? ${volunteerResult?.volunteer.toString()}');
            }

            _initFields();
          });
        }
      },
      builder: (context, state) {
        return Scaffold(
          appBar: AppBar(
            backgroundColor: Colors.white,
            title: Image.asset(
              AppConfig.companyIcon,
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
                            'Edit Profil Relawan',
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
                                  inputFormatters: fieldType == 'allCaps'
                                  ? [UpperCaseTextFormatter()]
                                  : null,
                                  keyboardType: fieldType == 'number'
                                      ? TextInputType.number
                                      : TextInputType.text,
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
                                                      element?.tipeRelawan ==
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
                                                      element?.title == value,
                                                  orElse: () => Wilayah(
                                                      id: '',
                                                      title: '',
                                                      alias: '',
                                                      jumlahCalon: '')),
                                          null);
                                    },
                                    dropdownItems: fieldData.isWilayah == false
                                        ? fieldData.dropdownItemsVolunteer
                                            .map((e) => e.tipeRelawan)
                                            .toList()
                                        : fieldData.isWilayah == true
                                            ? fieldData.dropdownItemsWilayah
                                                .map((e) => e.title)
                                                .toList()
                                            : [],
                                    selectedDropdownItem:
                                        fieldData.selectedDropdownItem,
                                    showHelper: fieldData.helperText != null,
                                    helperLabel: fieldData.helperText ?? '',
                                    titleLabel: fieldData.titleLabel,
                                    inputLabel: fieldData.inputLabel,
                                    defaultValue: fieldData.value,
                                    validator: fieldData.isNeedValidation ==
                                            true
                                        ? (String? value) {
                                            if (value == null || value == "") {
                                              return "Harus diisi";
                                            }
                                            return null;
                                          }
                                        : null,
                                    onChange: (value) {
                                      _updateFieldValue(
                                          index, value, null, null);
                                    },
                                  ),
                                );
                              },
                            ),
                          ),
                        ),
                        const SizedBox(height: 36),
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
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  child: QuickcountButton(
                    text: 'Simpan Perubahan',
                    state: QuickcountButtonState.enabled,
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        InitVolunteerRequestParams param = InitVolunteerRequestParams(
                            idInisiasi: _idInisiasi ?? '',
                            idWilayah: paramRequest.idWilayah,
                            idTypeRelawan: paramRequest.idTypeRelawan,
                            kodeLokasi1: paramRequest.kodeLokasi1,
                            kodeLokasi2: paramRequest.kodeLokasi2,
                            nama: paramRequest.nama,
                            noHandphone1: paramRequest.noHandphone1,
                            noHandphone2: paramRequest.noHandphone2,
                            deviceId: _deviceId,
                            model: _model,
                            brand: _brand,
                            verSdkInt: _verSdkInt.toString(),
                            fingerprint: _fingerprint,
                            serialnumber: _serialnumber
                        );
                        context.read<LoginCubit>().editVolunteer(param);
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
