import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:url_launcher/url_launcher_string.dart';

class DownloadApp extends StatefulWidget {
  const DownloadApp({super.key});

  @override
  State<DownloadApp> createState() => _DownloadAppState();
}

class _DownloadAppState extends State<DownloadApp> {
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    return Container(
      padding: EdgeInsets.all(32),
      color: Colors.grey.shade100,
      child: Wrap(
        crossAxisAlignment: WrapCrossAlignment.center,
        children: [
          SizedBox(
            width: width >= 630 ?  width - 400 : double.infinity,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Get the App and Stay Connected",
                  style: TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: 22
                  ),
                ),
                const SizedBox(height: 8,),
                Text(
                  "Install our app to manage your services, track orders, and stay updated — anytime, anywhere.",
                  style: TextStyle(
                      fontWeight: FontWeight.w500,
                      fontSize: 18
                  ),
                ),
                const SizedBox(height: 8,),
                Row(
                  children: [
                    InkWell(
                      onTap:(){
                        _launchUrl("https://play.google.com/store/apps/details?id=com.sunpower.guideware");
                      },
                      child: Image.asset(
                          "assets/icons/google_play.png",
                        width: 100,
                      ),
                    ),
                    const SizedBox(width: 14,),
                    InkWell(
                      onTap:(){
                        _launchUrl("https://apps.apple.com/us/app/auto-truck-store/id6444180377");
                      },
                      child: Image.asset(
                        "assets/icons/app_store.png",
                        width: 100,
                      ),
                    ),
                  ],
                )
              ],
            ),
          ),
          SizedBox(
            width: 300,
            child: Image.asset(
              "assets/images/Mobiles.png",
              fit: BoxFit.contain,
              width: 300,
            ),
          )

        ],
      ),
    );
  }

  Future<void> _launchUrl(String url) async {
    if (!await launchUrlString(url)) {
      throw Exception('Could not launch $url');
    }
  }
}
