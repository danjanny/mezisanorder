import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:skeleton/home/domain/params/input_result_param.dart';
import '../../../authentication/domain/entities/init_result.dart';
import '../../../base/presentation/button/quickcount_custom_button.dart';
import '../../../base/presentation/textformfield/app_colors.dart';
import '../../../base/presentation/textformfield/quickcount_text_form_field.dart';
import '../../../injection.dart';
import '../manager/home_cubit.dart';
import '../manager/home_state.dart';
import 'package:hive_flutter/hive_flutter.dart';

class FormFieldData {
  final String titleLabel;
  final String inputLabel;
  final List<String> dropdownItems;
  String? selectedDropdownItem;
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

class InputResultPage extends StatefulWidget {
  const InputResultPage({Key? key}) : super(key: key);

  @override
  State<InputResultPage> createState() => _InputResultPageState();
}

class _InputResultPageState extends State<InputResultPage> {
  final Box box = Hive.box('settings');
  List<CalonData>? listCalon;

  List<String> dropdownItems = [];

  @override
  void initState() {
    super.initState();
    _initializeData();
  }

  void _initializeData() {
    List<dynamic> retrievedData = box.get('dataCalon', defaultValue: []);

    // Ensure we cast each item in the retrieved data to a Map<String, dynamic>
    List<Map<String, dynamic>> dataCalon = List<Map<String, dynamic>>.from(
        retrievedData.map((item) => Map<String, dynamic>.from(item))
    );

    setState(() {
      listCalon = dataCalon.map((item) {
        return CalonData(
          noUrut: item['no_urut'] as String?,
          pasangan: item['pasangan'] as String?,
          id: '',
          idWilayah: '',
        );
      }).toList();

      dropdownItems = [
        box.get('locationCode1', defaultValue: '') ?? '',
        box.get('locationCode2', defaultValue: '') ?? '',
      ];
      int? totalCalon = box.get('jumlahCalon', defaultValue: 0); // Adjust default type
      print('Check initResult: $totalCalon');
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
          // Define the initial form fields
          formFields = [
            FormFieldData(
              titleLabel: "Kode Lokasi",
              inputLabel: "Pilih Kode Lokasi",
              dropdownItems: dropdownItems,
              selectedDropdownItem: dropdownItems.isNotEmpty ? dropdownItems.first : null,
              helperText: null,
            ),
            // Add form fields for each calon
            ...?listCalon?.map((calon) => FormFieldData(
              titleLabel: calon.pasangan ?? "Pasangan",
              inputLabel: "Masukkan perolehan ${calon.pasangan ?? "Pasangan"}",
              dropdownItems: [],
              helperText: "Periksa kembali hasil perolehan",
            )),
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
                        physics: const NeverScrollableScrollPhysics(),
                        itemCount: formFields.length,
                        itemBuilder: (context, index) {
                          final fieldData = formFields[index];
                          return Padding(
                            padding: const EdgeInsets.only(bottom: 16.0),
                            child: QuickcountTextFormField(
                              showDropdown: fieldData.dropdownItems.isNotEmpty,
                              onDropdownChanged: (String? value) {
                                formFields[index].selectedDropdownItem = value;
                                formFields[index].value = value;
                              },
                              defaultValue: formFields[index].value,
                              dropdownItems: fieldData.dropdownItems,
                              selectedDropdownItem: fieldData.selectedDropdownItem,
                              showHelper: fieldData.helperText != null,
                              helperLabel: fieldData.helperText ?? '',
                              titleLabel: fieldData.titleLabel,
                              inputLabel: fieldData.inputLabel,
                              onChange: (val) {
                                formFields[index].value = val;
                              },
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

                          String? dpt = formFields[formFields.length - 1].value;
                          String? suaraTidakSah = formFields[formFields.length - 2].value;

                          int totalVotes = int.tryParse(suaraTidakSah ?? '0') ?? 0;

                          for (int i = 0; i < (listCalon?.length ?? 0); i++) {
                            final calonResult = int.tryParse(formFields[i + 1].value ?? '0') ?? 0;
                            totalVotes += (calonResult);
                          }

                          // Convert DPT to integer for comparison
                          int dptValue = int.tryParse(dpt ?? '0') ?? 0;

                          // Validate that DPT is not less than total votes
                          print('Jumlah DPT: $dptValue');
                          print('Jumlah Vote: $totalVotes');
                          if (dptValue < totalVotes) {
                            // Show an error message if DPT is smaller
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: Text("Jumlah DPT tidak boleh lebih kecil dari total suara lain"),
                                backgroundColor: Colors.red,
                              ),
                            );
                            return;
                          }

                          InputResultParam inputResultParam = InputResultParam(
                            idInisiasi: box.get('idInisiasi', defaultValue: '').toString(),
                            kodeLokasi: formFields[0].selectedDropdownItem,
                            suaraTidakSah: formFields[formFields.length - 1].value,
                            dpt: formFields[formFields.length - 1].value,
                          );

                          for (int i = 0; i < (listCalon?.length ?? 0); i++) {
                            final calonResult = formFields[i + 1].value;
                            inputResultParam.addCalonResult(i + 1, calonResult ?? '');
                          }
                          context.read<HomeCubit>().inputResult(inputResultParam);
                        },
                      ),
                    ),
                    const SizedBox(height: 36),
                  ],
                ),
              ),
                if (state is HomeLoadingState)
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
      ),
    );
  }
}
