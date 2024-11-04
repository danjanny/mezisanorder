import 'package:injectable/injectable.dart';
import 'package:skeleton/authentication/data/models/volunteer_model.dart';
import 'package:skeleton/authentication/domain/entities/volunteer_result.dart';


@Injectable()
class VolunteerMapper {
  VolunteerResult fromVolunteerResponseModelToVolunteerResult(VolunteerResultModel volunteerResultModel) {
    return VolunteerResult(volunteer: volunteerResultModel.data.volunteer);
  }
}
