import 'package:injectable/injectable.dart';
import 'package:skeleton/authentication/data/models/init_volunteer_model.dart';
import '../../../domain/entities/init_result.dart';

@Injectable()
class InitResultMapper {
  InitResult fromInitResultModelToInitResult(InitVolunteerResponseModel initVolunteerResponseModel) {
    return InitResult(
      message: initVolunteerResponseModel.responseMessage,
      status: initVolunteerResponseModel.responseCode,
      data: initVolunteerResponseModel.data?.data,
    );
  }
}
