import 'package:injectable/injectable.dart';
import 'package:skeleton/authentication/domain/entities/wilayah_result.dart';
import '../../models/wilayah_model.dart';


@Injectable()
class WilayahMapper {
  WilayahResult fromWilayahResponseModelToWilayahResult(WilayahResultModel wilayahResultModel) {
    return WilayahResult(
      wilayah: wilayahResultModel.data.wilayah,
    );
  }
}
