import 'dart:async';

import 'package:background_sms/background_sms.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:qlevar_router/qlevar_router.dart';
import 'package:readsms/readsms.dart';
import 'package:skeleton/base/core/app_config.dart';
import 'package:skeleton/home/domain/params/input_result_param.dart';
import 'package:skeleton/route/routes.dart';
import '../../../authentication/domain/entities/init_result.dart';
import '../../../base/presentation/button/quickcount_custom_button.dart';
import '../../../base/presentation/textformfield/app_colors.dart';
import '../../../base/presentation/textformfield/quickcount_text_form_field.dart';
import '../../../injection.dart';
import '../manager/home_cubit.dart';
import '../manager/home_state.dart';

class FormFieldData {
  final String titleLabel;
  final String inputLabel;
  final List<String> dropdownItems;
  String? selectedDropdownItem;
  final String? helperText;
  String? value;
  String? formType;
  bool? isNeedValidation;

  FormFieldData(
      {required this.titleLabel,
      required this.inputLabel,
      this.dropdownItems = const [],
      this.selectedDropdownItem,
      this.helperText,
      this.value,
      this.formType,
      this.isNeedValidation = false});
}

class InputResultPage extends StatefulWidget {
  const InputResultPage({Key? key}) : super(key: key);

  @override
  State<InputResultPage> createState() => _InputResultPageState();
}

class _InputResultPageState extends State<InputResultPage> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  final Box box = Hive.box('settings');
  List<CalonData>? listCalon;

  final _plugin = Readsms();

  List<String> dropdownItems = [];
  bool _isSmsReplySent = false;
  bool _isSubmitTapped = false;

  StreamSubscription? _smsSubscription;

  @override
  void initState() {
    super.initState();
    _initializeData();
    _requestSmsPermission();
    _readSms();
  }

  void _readSms() {
    getPermission().then((value) {
      if (value) {
        _plugin.read();
        _smsSubscription = _plugin.smsStream.listen((event) {
          if (!mounted) return; // Check if the widget is still mounted
          setState(() {
            // Check if the message contains 'OK' or 'OKE'
            String message = event.body;
            String sender = event.sender;
            print('Check result $message');
            if (sender == '96999' &&
                (message.contains('OK') || message.contains('OKE'))) {
              String replyMessage = message.contains('OKE') ? 'OKE' : 'OK';
              sendSmsCustomHasilPilkada(replyMessage);
            }
          });
        });
      }
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
          setState(() {
            _isSmsReplySent = true;
          });
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

  void _requestSmsPermission() async {
    if (await Permission.sms.request().isGranted) {
      print('SMS Granted');
    } else {
      print('SMS Not Granted');
    }
  }

  void onTimeout() {
    setState(() {
      print('Timeout nih...');
    });
  }

  void _initializeData() {
    List<dynamic> retrievedData = box.get('dataCalon', defaultValue: []);

    List<Map<String, dynamic>> dataCalon = List<Map<String, dynamic>>.from(
        retrievedData.map((item) => Map<String, dynamic>.from(item)));

    setState(() {
      listCalon = dataCalon.map((item) {
        return CalonData(
          noUrut: item['no_urut'] as String?,
          pasangan: item['pasangan'] as String?,
          id: '',
          idWilayah: '',
        );
      }).toList();

      listCalon?.sort((a, b) {
        final noUrutA = int.tryParse(a.noUrut ?? '0') ?? 0;
        final noUrutB = int.tryParse(b.noUrut ?? '0') ?? 0;
        return noUrutA.compareTo(noUrutB);
      });

      dropdownItems = [
        box.get('locationCode1', defaultValue: '') ?? '',
        box.get('locationCode2', defaultValue: '') ?? '',
      ];
      dropdownItems = dropdownItems.toSet().toList();
      int? totalCalon =
          box.get('jumlahCalon', defaultValue: 0); // Adjust default type
      print('Check initResult: $totalCalon');

      formFields = [
        FormFieldData(
          titleLabel: "Riil / Latihan",
          inputLabel: "Riil / Latihan",
          dropdownItems: ['Riil', 'Latihan'],
          selectedDropdownItem: 'Riil',
          helperText: null,
        ),
        FormFieldData(
          titleLabel: "Kode Lokasi",
          inputLabel: "Pilih Kode Lokasi",
          dropdownItems: dropdownItems,
          selectedDropdownItem:
          dropdownItems.isNotEmpty ? dropdownItems.first : null,
          helperText: null,
        ),
        // Add form fields for each calon
        ...?listCalon?.map((calon) => FormFieldData(
            titleLabel: calon.pasangan ?? "Pasangan",
            inputLabel:
            "Masukkan perolehan pasangan no urut ${calon.noUrut ?? ""}",
            dropdownItems: [],
            helperText: "Periksa kembali hasil perolehan",
            formType: "number",
            isNeedValidation: true)),
        FormFieldData(
            titleLabel: "Suara tidak sah",
            inputLabel: "Masukkan jumlah suara tidak sah",
            dropdownItems: [],
            helperText: null,
            formType: "number",
            isNeedValidation: true),
        FormFieldData(
            titleLabel: "DPT (Daftar Pemilih Tetap)",
            inputLabel: "Masukkan jumlah DPT",
            dropdownItems: [],
            helperText:
            "DPT tidak boleh lebih kecil dari keseluruhan jumlah suara",
            formType: "number",
            isNeedValidation: true),
      ];
    });
  }

  List<FormFieldData> formFields = [];

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => getIt<HomeCubit>(),
      child: BlocConsumer<HomeCubit, HomeState>(
        listener: (context, state) {
          if (state is HomeErrorState) {
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
          } else if (state is HomeLoadedState) {
            print('Home loaded state: ${state.statusCode}');
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
                            print('isSmsReplySent: $_isSmsReplySent');
                            // when succes then remove list calon
                            if (state.statusCode?.toLowerCase() == 'ok') {
                              _resetFields();
                            }
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
          }
        },
        builder: (context, state) {
          return PopScope(
            canPop: true,
            onPopInvokedWithResult: (_, __) {
              print('isSmsReplySent: $_isSmsReplySent');
              /*
              if (_isSubmitTapped) {
                return showWarningIncompleteTask(context);
              } else {
                QR.popUntilOrPush(AppRoutes.homePath);
              }
               */
            },
            child: Scaffold(
              appBar: AppBar(
                backgroundColor: Colors.white,
                // automaticallyImplyLeading: false,
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
                      child: Form(
                        key: _formKey,
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
                                'Hasil Pilkada',
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
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 16.0),
                              child: ListView.builder(
                                key: ValueKey(formFields),
                                shrinkWrap: true,
                                physics: const NeverScrollableScrollPhysics(),
                                itemCount: formFields.length,
                                itemBuilder: (context, index) {
                                  final fieldData = formFields[index];
                                  final isNeedValidation =
                                      fieldData.isNeedValidation;
                                  return Padding(
                                    padding:
                                        const EdgeInsets.only(bottom: 16.0),
                                    child: QuickcountTextFormField(
                                      keyboardType:
                                          fieldData.dropdownItems.isEmpty
                                              ? TextInputType.number
                                              : TextInputType.text,
                                      showDropdown:
                                          fieldData.dropdownItems.isNotEmpty,
                                      onDropdownChanged: (String? value) {
                                        formFields[index].selectedDropdownItem =
                                            value;
                                        formFields[index].value = value;
                                      },
                                      defaultValue: formFields[index].value,
                                      dropdownItems: fieldData.dropdownItems,
                                      selectedDropdownItem:
                                          fieldData.selectedDropdownItem,
                                      showHelper: fieldData.helperText != null,
                                      helperLabel: fieldData.helperText ?? '',
                                      titleLabel: fieldData.titleLabel,
                                      inputLabel: fieldData.inputLabel,
                                      onChange: (val) {
                                        formFields[index].value = val;
                                      },
                                      validator: isNeedValidation == true
                                          ? (String? value) {
                                              if (value == null ||
                                                  value == "") {
                                                return "Harus diisi";
                                              }

                                              return null;
                                            }
                                          : null,
                                      // validator: isNeedValidation == true ? () {} : null,
                                    ),
                                  );
                                },
                              ),
                            ),
                            // const SizedBox(height: 36),
                          ],
                        ),
                      ),
                    )),
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
                        text: 'Kirim Hasil',
                        state: QuickcountButtonState.enabled,
                        onPressed: () {
                          if (_formKey.currentState!.validate()) {
                            submitData(context, onPressed: () {
                              Navigator.pop(context);
                              _isSubmitTapped = true;
                              // TODO: Implement SMS sending
                              String? riilLat =
                                  formFields[0].selectedDropdownItem;
                              String? dpt =
                                  formFields[formFields.length - 1].value;
                              String? suaraTidakSah =
                                  formFields[formFields.length - 2].value;

                              int totalVotes =
                                  int.tryParse(suaraTidakSah ?? '0') ?? 0;

                              for (int i = 0;
                                  i < (listCalon?.length ?? 0);
                                  i++) {
                                final calonResult = int.tryParse(
                                        formFields[i + 2].value ?? '0') ??
                                    0;
                                totalVotes += (calonResult);
                              }

                              // Convert DPT to integer for comparison
                              int dptValue = int.tryParse(dpt ?? '0') ?? 0;
                              if (dptValue < totalVotes) {
                                // Show an error message if DPT is smaller
                                ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(
                                    content: Text(
                                        "Jumlah DPT tidak boleh lebih kecil dari total suara lain. Tanyakan jumlah DPT kepada petugas TPS"),
                                    backgroundColor: Colors.red,
                                  ),
                                );
                                return;
                              }

                              if (dptValue == 0) {
                                // Show an error message if DPT is smaller
                                ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(
                                    content: Text(
                                        "Jumlah DPT tidak boleh lebih kecil dari total suara lain. Tanyakan jumlah DPT kepada petugas TPS"),
                                    backgroundColor: Colors.red,
                                  ),
                                );
                                return;
                              }

                              String? jenisInput =
                                  riilLat?.toLowerCase() == 'riil' ? 'R' : 'L';

                              // Validate DPT
                              if (dptValue < totalVotes || dptValue == 0) {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(
                                    content: Text(
                                      "Jumlah DPT tidak boleh lebih kecil dari total suara lain. Tanyakan jumlah DPT kepada petugas TPS",
                                    ),
                                    backgroundColor: Colors.red,
                                  ),
                                );
                                return;
                              }

                              // Send data
                              InputResultParam inputResultParam =
                                  InputResultParam(
                                riilLatihan: jenisInput,
                                idInisiasi: box
                                    .get('idInisiasi', defaultValue: '')
                                    .toString(),
                                kodeLokasi: formFields[1].selectedDropdownItem,
                                suaraTidakSah: suaraTidakSah,
                                dpt: dpt,
                              );

                              for (int i = 0;
                                  i < (listCalon?.length ?? 0);
                                  i++) {
                                final calonResult = formFields[i + 2].value;
                                if (calonResult == null) {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    const SnackBar(
                                      content: Text(
                                        "Mohon isi perolehan suara calon",
                                      ),
                                      backgroundColor: Colors.red,
                                    ),
                                  );
                                  return;
                                }
                                inputResultParam.addCalonResult(
                                    i + 1, calonResult ?? '');
                              }

                              // Trigger the result input
                              context
                                  .read<HomeCubit>()
                                  .inputResult(inputResultParam);
                            });
                          }
                        }),
                  ),
                ),
                if (state is HomeLoadingState)
                  Container(
                    color: Colors.white.withOpacity(0.5),
                    child: const Center(
                      child: CircularProgressIndicator(),
                    ),
                  ),
              ]),
              backgroundColor: Colors.white,
            ),
          );
        },
      ),
    );
  }

  void showWarningIncompleteTask(BuildContext context) async {
    showModalBottomSheet(
      context: context,
      builder: (context) {
        return Container(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: [
              const Text('Yakin keluar dari halaman?',
                textAlign: TextAlign.center,
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 20
                ),
              ),
              const SizedBox(height: 16.0),
              const Text(
                'Periksa kembali SMS anda pastikan terkirim jika muncul pesan “OKE”',
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 16.0),
              Row(
                children: [
                  Expanded(
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        foregroundColor: Colors.white,
                        backgroundColor: AppColors.dangerMain,
                        minimumSize: const Size(double.infinity, 50),
                      ),
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      child: const Text('Batal'),
                    ),
                  ),
                  const SizedBox(width: 8), // Added spacing between buttons
                  Expanded(
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        foregroundColor: Colors.white,
                        backgroundColor: AppColors.primaryColor,
                        minimumSize: const Size(double.infinity, 50),
                      ),
                      onPressed: () {
                        QR.popUntilOrPush(AppRoutes.homePath);
                        Navigator.pop(context);
                      },
                      child: const Text('Yakin'),
                    ),
                  ),
                ],
              ),
            ],
          ),
        );
      },
    );
  }

  _resetFields() {
    setState(() {
      print('Before: ${formFields.map((field) => field.value).toList()}');

      // Create a new list with the updated values
      formFields = formFields.map((field) {
        if (field.formType == 'number') {
          print('Resetting value for ${field.titleLabel}');
          // Reset field value and dropdown selection
          return FormFieldData(
            titleLabel: field.titleLabel,
            inputLabel: field.inputLabel,
            dropdownItems: field.dropdownItems,
            selectedDropdownItem: '',  // Reset dropdown selection
            helperText: field.helperText,
            value: '',  // Reset field value
            formType: field.formType,
            isNeedValidation: field.isNeedValidation,
          );
        }
        return field;  // Return other fields unchanged
      }).toList();

      print('After: ${formFields.map((field) => field.value).toList()}');
    });
  }


  void submitData(BuildContext context, {VoidCallback? onPressed}) async {
    showModalBottomSheet(
      context: context,
      builder: (context) {
        return Container(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Text('Yakin mengirim data?',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 20
                ),
              ),
              const SizedBox(height: 16.0),
              const Text('Periksa kembali data yang akan dikirim dan pastikan nomor anda menggunakan Telkomsel atau Indosat.',
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 16.0),
              Row(
                children: [
                  Expanded(
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        minimumSize: const Size(double.infinity, 50),
                        side: const BorderSide(color: AppColors.primaryColor, width: 1), // Border color and width
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(25), // Optional: Border radius
                        ),
                      ),
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      child: const Text('Batal', style: TextStyle(
                        color: AppColors.primaryColor,
                      ),),
                    ),
                  ),
                  const SizedBox(width: 8), // Added spacing between buttons
                  Expanded(
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        foregroundColor: Colors.white,
                        backgroundColor: AppColors.primaryColor,
                        minimumSize: const Size(double.infinity, 50),
                      ),
                      onPressed: onPressed,
                      child: const Text('Ya'),
                    ),
                  ),
                ],
              ),
            ],
          ),
        );
      },
    );
  }
}
