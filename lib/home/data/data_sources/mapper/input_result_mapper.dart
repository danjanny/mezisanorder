import 'package:injectable/injectable.dart';
import '../../../domain/entities/input_result.dart';
import '../../models/input_model.dart';

@Injectable()
class InputResultMapper {
  InputResult fromInputModelToInputResult(InputResultModel inputResult) {
    return InputResult(
      message: inputResult.responseMessage,
      status: inputResult.responseCode,
    );
  }
}
