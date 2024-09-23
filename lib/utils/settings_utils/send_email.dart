import 'package:get/route_manager.dart';
import 'package:the_match/utils/globals.dart';
import 'package:url_launcher/url_launcher.dart';

void sendEmailToDevTeam() async {
  final String subject = Uri.encodeComponent("Report an Issue");
  final String body = Uri.encodeComponent("Please describe the issue you are facing.");

  final Uri emailLaunchUri = Uri(
    scheme: 'mailto',
    path: DEV_TEAM_EMAIL,
    query: 'subject=$subject&body=$body',
  );

  if (await canLaunchUrl(emailLaunchUri)) {
    await launchUrl(emailLaunchUri);
  } else {
    Get.closeAllSnackbars();
    const String title = 'An Error Occurred';
    const String message = 'Could not send email';
    Get.snackbar(
      title,
      message,
      snackPosition: SnackPosition.BOTTOM,
      backgroundColor: SNACKBAR_ERROR_BACKGROUND_COLOR,
      borderRadius: SNACKBAR_BORDER_RADIUS,
      colorText: SNACKBAR_ERROR_FOREGROUND_COLOR,
      );
  }
}
