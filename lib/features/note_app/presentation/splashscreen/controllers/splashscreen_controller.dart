import 'dart:async';

import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../routes/app_routes.dart';

class SplashScreenController extends GetxController {
  var isDataLoaded = false.obs;
  var retryCount = 0.obs;
  Timer? retryTimer;
  @override
  void onReady() {
    super.onReady();
    downloadFont();
  }

  void downloadFont() async {
    try {
      await GoogleFonts.pendingFonts([
        GoogleFonts.poppins(),
        GoogleFonts.comicNeue(),
      ]);
      Get.offAllNamed(AppRoutes.home);
    } catch (e) {
      retryDownload();
    }
  }

  void retryDownload() {
    retryCount.value++;
    retryTimer?.cancel();
    retryTimer = Timer(Duration(minutes: 3), downloadFont);
  }

  @override
  void onClose() {
    retryTimer?.cancel(); // Cancel timer when controller is destroyed
    super.onClose();
  }
}
