import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:qlevar_router/qlevar_router.dart';
import 'package:skeleton/authentication/domain/params/init_volunteer_request.dart';
import '../../../base/presentation/styles/text_form_field_style.dart';
import '../../../base/presentation/styles/text_styles.dart';
import '../../../base/presentation/button/quickcount_custom_button.dart';
import '../../../base/presentation/textformfield/app_colors.dart';
import '../../../base/presentation/textformfield/quickcount_text_form_field.dart';
import '../manager/login_cubit.dart';
import '../manager/login_state.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:skeleton/route/routes.dart';

class FormFieldData {
  final String titleLabel;
  final String inputLabel;
  final List<String> dropdownItems;
  final String? selectedDropdownItem;
  final String? helperText;
  String? value;

  FormFieldData({
    required this.titleLabel,
    required this.inputLabel,
    this.dropdownItems = const [],
    this.selectedDropdownItem,
    this.helperText,
    this.value
  });
}

class RegisterPage extends StatefulWidget {
  const RegisterPage({Key? key}) : super(key: key);

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  InitVolunteerRequestParams paramRequest = InitVolunteerRequestParams(
    idWilayah: '',
    idTypeRelawan: '',
    kodeLokasi1: '',
    kodeLokasi2: '',
    nama: '',
    noHandphone1: '',
    noHandphone2: '',
    deviceId: ''
  );

  @override
  Widget build(BuildContext context) {
    final List<FormFieldData> formFields = [
      FormFieldData(
        titleLabel: "Wilayah Pilkada",
        inputLabel: "Pilih Wilayah",
        dropdownItems: ["Wilayah A", "Wilayah B", "Wilayah C"],
        helperText: null,
      ),
      FormFieldData(
        titleLabel: "Jenis Relawan",
        inputLabel: "Pilih Jenis Relawan",
        dropdownItems: ["Relawan A", "Relawan B", "Relawan C"],
        helperText: null,
      ),
      FormFieldData(
        titleLabel: "Kode Lokasi 1",
        inputLabel: "Masukkan Kode Lokasi 1",
        dropdownItems: [],
        helperText: "Helper text for Kode Lokasi 1",
      ),
      FormFieldData(
        titleLabel: "Kode Lokasi 2",
        inputLabel: "Masukkan Kode Lokasi 2",
        dropdownItems: [],
        helperText: "Helper text for Kode Lokasi 2",
      ),
      FormFieldData(
        titleLabel: "Nama",
        inputLabel: "Masukkan Nama",
        dropdownItems: [],
        helperText: null,
      ),
      FormFieldData(
        titleLabel: "No Handphone 1",
        inputLabel: "Masukkan No Handphone 1",
        dropdownItems: [],
        helperText: "Helper text for No Handphone 1",
      ),
      FormFieldData(
        titleLabel: "No Handphone 2",
        inputLabel: "Masukkan No Handphone 2",
        dropdownItems: [],
        helperText: "Helper text for No Handphone 2",
      ),
    ];

    void _updateFieldValue(int index, String newValue) {
      setState(() {
        formFields[index].value = newValue;
        switch (index) {
          case 0:
            paramRequest = paramRequest.copyWith(idWilayah: newValue);
            break;
          case 1:
            paramRequest = paramRequest.copyWith(idTypeRelawan: newValue);
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
                    child: ListView.builder(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: formFields.length,
                      itemBuilder: (context, index) {
                        final fieldData = formFields[index];
                        return Padding(
                          padding: const EdgeInsets.only(bottom: 16.0),
                          child: QuickcountTextFormField(
                            showDropdown: fieldData.dropdownItems.isNotEmpty,
                            onDropdownChanged: (String? value) {
                              _updateFieldValue(index, value ?? '');
                            },
                            dropdownItems: fieldData.dropdownItems,
                            selectedDropdownItem: fieldData.selectedDropdownItem,
                            showHelper: fieldData.helperText != null,
                            helperLabel: fieldData.helperText ?? '',
                            titleLabel: fieldData.titleLabel,
                            inputLabel: fieldData.inputLabel,
                            defaultValue: fieldData.value,
                            onChange: (value) {
                              _updateFieldValue(index, value);
                            },
                          ),
                        );
                      },
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16.0),
                    child: QuickcountButton(
                      text: 'Lanjutkan',
                      state: QuickcountButtonState.enabled,
                      onPressed: () {
                        context.read<LoginCubit>().initVolunteer(paramRequest);
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
