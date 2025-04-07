import 'package:url_launcher/url_launcher.dart';

void openPdf({required String pdfUrl}) async {
  Uri url = Uri.parse(pdfUrl);
  if (await canLaunchUrl(url)) {
    await launchUrl(url, mode: LaunchMode.inAppBrowserView);
  } else {
    print("Could not launch $pdfUrl");
  }
}