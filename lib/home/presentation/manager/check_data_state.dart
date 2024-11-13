import 'package:skeleton/home/domain/entities/check_data_pilkada.dart';

abstract class CheckDataState {}

class CheckDataInitialState extends CheckDataState {}

class CheckDataLoadingState extends CheckDataState {}

class CheckDataLoadedState extends CheckDataState {
  final String? statusCode;
  final String? message;
  final List<DataPilkada>? data;

  CheckDataLoadedState({this.statusCode, this.message, this.data});
}

class CheckDataComingSoonState extends CheckDataState {
  final String? message;

  CheckDataComingSoonState(String s, {this.message});
}

class CheckDataErrorState extends CheckDataState {
  final String? statusCode;
  final String? message;

  CheckDataErrorState({this.statusCode, this.message});
}
