import 'package:qlevar_router/qlevar_router.dart';

class RootMiddleware extends QMiddleware {
  @override
  Future<bool> canPop() {
    return Future.value(false);
  }

  @override
  Future onExit() {
    return Future.value(false);
  }
}
