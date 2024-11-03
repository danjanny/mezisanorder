import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:qlevar_router/qlevar_router.dart';
import '../../../base/presentation/styles/text_form_field_style.dart';
import '../../../base/presentation/styles/text_styles.dart';
import '../../../base/presentation/button/quickcount_custom_button.dart';
import '../../../base/presentation/textformfield/quickcount_text_form_field.dart';
import '../manager/home_cubit.dart';
import '../manager/home_state.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:skeleton/route/routes.dart';

class FormFieldData {
  final String titleLabel;
  final String inputLabel;
  final List<String> dropdownItems;
  final String? selectedDropdownItem;
  final String? helperText;

  FormFieldData({
    required this.titleLabel,
    required this.inputLabel,
    this.dropdownItems = const [],
    this.selectedDropdownItem,
    this.helperText,
  });
}

class InputResultPage extends StatelessWidget {
  const InputResultPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => HomeCubit(),
      child: BlocConsumer<HomeCubit, HomeState>(
        listener: (context, state) {
          // TODO: Handle state change
        },
        builder: (context, state) {
          final List<FormFieldData> formFields = [
            FormFieldData(
              titleLabel: "Kode Lokasi",
              inputLabel: "Pilih Kode Lokasi",
              dropdownItems: ["Wilayah A", "Wilayah B", "Wilayah C"],
              helperText: null,
            ),
            FormFieldData(
              titleLabel: "Perolehan pasangan 1",
              inputLabel: "Masukkan perolehan pasangan 1",
              dropdownItems: [],
              helperText: "Periksa kembali hasil perolehan",
            ),FormFieldData(
              titleLabel: "Perolehan pasangan 2",
              inputLabel: "Masukkan perolehan pasangan 2",
              dropdownItems: [],
              helperText: "Periksa kembali hasil perolehan",
            ),
            FormFieldData(
              titleLabel: "Suara tidak sah",
              inputLabel: "Masukkan jumlah suara tidak sah",
              dropdownItems: [],
              helperText: null,
            ),
            FormFieldData(
              titleLabel: "DPT (Daftar Pemilih Tetap)",
              inputLabel: "Masukkan jumlah DPT",
              dropdownItems: [],
              helperText: "DPT tidak boleh lebih kecil dari keseluruhan jumlah suara",
            ),
          ];

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
            body: SingleChildScrollView(
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
                    padding: const EdgeInsets.symmetric(horizontal: 16.0),
                    child: ListView.builder(
                      shrinkWrap: true,
                      physics: NeverScrollableScrollPhysics(),
                      itemCount: formFields.length,
                      itemBuilder: (context, index) {
                        final fieldData = formFields[index];
                        return Padding(
                          padding: const EdgeInsets.only(bottom: 16.0),
                          child: QuickcountTextFormField(
                            showDropdown: fieldData.dropdownItems.isNotEmpty,
                            onDropdownChanged: (String? value) {},
                            dropdownItems: fieldData.dropdownItems,
                            selectedDropdownItem: fieldData.selectedDropdownItem,
                            showHelper: fieldData.helperText != null,
                            helperLabel: fieldData.helperText ?? '',
                            titleLabel: fieldData.titleLabel,
                            inputLabel: fieldData.inputLabel,
                          ),
                        );
                      },
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16.0),
                    child: QuickcountButton(
                      text: 'Kirim Hasil',
                      state: QuickcountButtonState.enabled,
                      onPressed: () {
                        // TODO: Implement SMS sending
                      },
                    ),
                  ),
                  const SizedBox(height: 36),
                ],
              ),
            ),
            backgroundColor: Colors.white,
          );
        },
      ),
    );
  }
}
