import 'package:skeleton/authentication/domain/entities/volunteer.dart';

class VolunteerResult {
  final List<Volunteer> volunteer;

  VolunteerResult({required this.volunteer});

  factory VolunteerResult.fromJson(Map<String, dynamic> json) {
    return VolunteerResult(
      volunteer: List<Volunteer>.from(
          json['data'].map((item) => Volunteer.fromJson(item as Map<String, dynamic>))
      ),
    );
  }
}