
import 'package:counter_application/main/main_screen.dart';
import 'package:get/get_navigation/src/routes/get_route.dart';





class AppPages {
  static const HOME = '/';

  static final routes = [
    GetPage(
        name: HOME,
        fullscreenDialog: true,
        page: () =>  Wrapper()
    ),

  ];
}
