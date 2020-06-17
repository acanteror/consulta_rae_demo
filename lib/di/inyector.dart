import 'package:get/get.dart';
import 'package:rae_test/api/rae_api.dart';
import 'package:rae_test/service/rae_service.dart';
import 'package:http/http.dart' as http;


void configureInyector() {
  Get.lazyPut<RaeApi>(() => RaeApiImpl(client: http.Client()));
  Get.lazyPut<RaeService>(() => RaeServiceImpl(raeApi: RaeApiImpl()));
}