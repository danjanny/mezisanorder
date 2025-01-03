import 'package:http/src/response.dart';
import 'package:injectable/injectable.dart';
import 'package:skeleton/base/data/data_sources/base_http_service.dart';
import 'package:skeleton/order/data/data_sources/abstractions/i_order_service.dart';
import 'package:skeleton/order/domain/params/order_request_param.dart';

@Injectable(as: IOrderService)
class OrderServiceImpl extends BaseHttpService implements IOrderService {
  @override
  Future<Response> submit(OrderRequestParam params) async {
    final body = params.toJson();
    return await fetchPost(
        '/macros/s/AKfycbzTFdjBnzBeKZ1_5OaOFL4WVEOeEEpxbkfAX8GHVGP5QPQK5iJj5we_sxFvGl-8/exec',
        body: body);
  }
}
