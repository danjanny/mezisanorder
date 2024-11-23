import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:skeleton/home/domain/entities/check_data_pilkada.dart';
import 'package:skeleton/home/presentation/manager/check_data_cubit.dart';
import 'package:skeleton/home/presentation/manager/check_data_state.dart';
import '../../../base/core/app_config.dart';
import '../../../base/presentation/styles/text_styles.dart';
import 'package:intl/intl.dart';
import '../../domain/params/check_data_pilkada_request.dart';

class HistoryInputPage extends StatefulWidget {
  @override
  State<HistoryInputPage> createState() => _HistoryInputPageState();
}

class _HistoryInputPageState extends State<HistoryInputPage> {
  final Box box = Hive.box('settings');

  @override
  void initState() {
    super.initState();
    print('Initializingg');
    String? idInisasi = box.get('idInisiasi').toString();
    context.read<CheckDataCubit>().checkData(CheckDataPilkadaRequest(idInisiasi: idInisasi.toString()));
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<CheckDataCubit, CheckDataState>(
      listener: (context, state) {
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
          body: Stack(
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Container(
                      color: const Color(0xFFE5E5E5),
                      height: 8,
                    ),
                    const SizedBox(height: 24),
                    const Padding(
                      padding: EdgeInsets.symmetric(horizontal: 16.0),
                      child: Text(
                        'Riwayat Input',
                        textAlign: TextAlign.start,
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                        ),
                      ),
                    ),
                    const SizedBox(height: 10),
                    Expanded(
                      child: (state is CheckDataLoadedState && (state.data?.length ?? 0) > 0)
                          ?
                      ListView.builder(
                        itemCount: state.data?.length,
                        itemBuilder: (context, index) {
                          List<DataPilkada>? data;
                          data = state.data;
                          return CustomHistoryCell(
                            locationCode: data?[index].kodeLokasi ?? '-',
                            date: formatDate(data?[index].tanggal ?? '-'),
                            isReal: data?[index].riilLat?.contains('Riil') ?? false,
                            sms: data?[index].sms ?? '-'
                          );
                        },
                      ) :
                      Center(
                        child: Text(
                          (state is CheckDataLoadingState) ? '' : 'Belum ada riwayat input',
                          style: TextStyles.body16Bold,
                        ),
                      ),
                    ),
                  ],
                ),
                if (state is CheckDataLoadingState)
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

class CustomHistoryCell extends StatelessWidget {
  final String locationCode;
  final String date;
  final bool isReal;
  final String sms;

  const CustomHistoryCell({
    required this.locationCode,
    required this.date,
    required this.isReal,
    required this.sms,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: isReal
            ? const Color(0xFF30AB20).withOpacity(0.1)
            : const Color(0xFFFFC2C2).withOpacity(0.1),
        border: Border.all(
          color: isReal ? const Color(0xFF30AB20) : const Color(0xFFFFC2C2),
          width: 1,
        ),
        borderRadius: BorderRadius.circular(10),
      ),
      margin: const EdgeInsets.all(8),
      child: Padding(
        padding: const EdgeInsets.all(8),
        child: Column(
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  width: 80,
                  padding: const EdgeInsets.symmetric(vertical: 2, horizontal: 8),
                  decoration: BoxDecoration(
                    color: isReal ? const Color(0xFF30AB20) : const Color(0xFFFFC2C2),
                    borderRadius: BorderRadius.circular(9.0),
                  ),
                  child: Text(
                    isReal ? 'Riil' : 'Latihan',
                    textAlign: TextAlign.center,
                    style: TextStyles.body12Regular.copyWith(
                      color: isReal ? Colors.white : const Color(0xFF8E8E93),
                    ),
                  ),
                ),
                const Expanded(child: SizedBox()),
                Text(
                  date,
                  style: TextStyles.body12Regular.copyWith(
                    color: const Color(0xFF8E8E93),
                  ),
                  textAlign: TextAlign.right,
                ),
              ],
            ),
            const SizedBox(height: 12),
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  'Kode lokasi: ',
                  style: TextStyles.body12Regular.copyWith(
                    color: const Color(0xFF8E8E93),
                  ),
                ),
                const SizedBox(width: 6),
                Text(
                  locationCode,
                  style: TextStyles.body16Bold.copyWith(
                    color: Colors.black,
                  ),
                ),
              ],
            ),
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  'SMS: ',
                  style: TextStyles.body12Regular.copyWith(
                    color: const Color(0xFF8E8E93),
                  ),
                ),
                const SizedBox(width: 6),
                Text(
                  sms,
                  style: TextStyles.body16Bold.copyWith(
                    color: Colors.black,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

String formatDate(String dateString) {
  DateTime dateTime = DateTime.parse(dateString);

  String formattedDate = DateFormat("EEEE, dd MMMM yyyy HH:mm").format(dateTime);

  Map<int, String> daysOfWeek = {
    DateTime.monday: 'Senin',
    DateTime.tuesday: 'Selasa',
    DateTime.wednesday: 'Rabu',
    DateTime.thursday: 'Kamis',
    DateTime.friday: 'Jumat',
    DateTime.saturday: 'Sabtu',
    DateTime.sunday: 'Minggu',
  };

  formattedDate = formattedDate.replaceFirst(DateFormat("EEEE").format(dateTime), daysOfWeek[dateTime.weekday]!);

  return formattedDate;
}