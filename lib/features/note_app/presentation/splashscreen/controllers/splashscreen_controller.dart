import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../routes/app_routes.dart';

class SplashScreenController extends GetxController {
  var isDataLoaded = false.obs;

  @override
  void onReady() {
    super.onReady();
    downloadFont();
  }

  @override
  void onClose() {
    // Clean up resources here
    super.onClose();
  }

  void downloadFont() async {
    // ignore: await_only_futures
    await GoogleFonts.pendingFonts([
      GoogleFonts.poppins(),
      GoogleFonts.comicNeue(),
    ]);
    Get.offAllNamed(AppRoutes.home);
  }
}
