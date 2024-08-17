import 'package:dio/dio.dart';

mixin DioConfigService {
  final Dio dio = Dio(BaseOptions(
    connectTimeout: const Duration(seconds: 10),
    receiveTimeout: const Duration(seconds: 10),
    sendTimeout: const Duration(seconds: 10),
    validateStatus: (status) => true,
    headers: {'Content-Type': 'application/json'},
  ));
}

class DioImplement with DioConfigService {
  Dio get dioImp => dio;
}
