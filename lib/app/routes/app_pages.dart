import 'package:get/get.dart';

import '../modules/home/bindings/home_binding.dart';
import '../modules/home/create_edit_profile/bindings/create_edit_profile_binding.dart';
import '../modules/home/create_edit_profile/views/create_edit_profile_view.dart';
import '../modules/home/views/home_view.dart';
import '../modules/login/bindings/login_binding.dart';
import '../modules/login/otp/bindings/otp_binding.dart';
import '../modules/login/otp/views/otp_view.dart';
import '../modules/login/views/login_view.dart';

part 'app_routes.dart';

class AppPages {
  AppPages._();

  static const INITIAL = Routes.HOME;

  static final routes = [
    GetPage(
      name: _Paths.HOME,
      page: () => HomeView(),
      binding: HomeBinding(),
      children: [
        GetPage(
          transition: Transition.fadeIn,
          name: _Paths.CREATE_EDIT_PROFILE,
          page: () => CreateEditProfileView(),
          binding: CreateEditProfileBinding(),
        ),
      ],
    ),
    GetPage(
      name: _Paths.LOGIN,
      page: () => LoginView(),
      binding: LoginBinding(),
      children: [
        GetPage(
          transition: Transition.fadeIn,
          name: _Paths.OTP,
          page: () => OtpView(),
          binding: OtpBinding(),
        ),
      ],
    ),
  ];
}
