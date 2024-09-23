import 'package:get/route_manager.dart';
import 'package:the_match/utils/globals.dart';
import 'package:url_launcher/url_launcher.dart';

Future<void> launchInWebView(String url) async {
  final urlInURI = Uri.parse(url);
  if (!await launchUrl(urlInURI, mode: LaunchMode.inAppWebView)) {
    Get.closeAllSnackbars();
    Get.snackbar(
      "An Error Occurred",
      "Could not launch inAppWebView",
      snackPosition: SnackPosition.BOTTOM,
      colorText: SNACKBAR_ERROR_FOREGROUND_COLOR,
      backgroundColor: SNACKBAR_ERROR_BACKGROUND_COLOR,
      borderRadius: SNACKBAR_BORDER_RADIUS,
    );
  }
}
