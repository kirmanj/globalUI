import 'package:flutter/material.dart';
import 'package:sunpower_website/utils/site_icons.dart';

class SocialMediaButton extends StatelessWidget {
  final String socialType;
  final String link;
  final double size = 18;
  const SocialMediaButton({super.key, required this.socialType, required this.link});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: (){
        // open link
      },
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Image.asset(getIconPath,width: size,height: size,),
          const SizedBox(width: 4,),
          Text(
            socialType,
            style: TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.bold,
              color: Colors.white
            ),
          )
        ],
      ),
    );
  }
  
  String get getIconPath {
    if(socialType == 'Facebook') {
      return SiteIcons.facebook;
    } else if(socialType == 'Youtube'){
      return SiteIcons.youtube;
    }
    return '';
  }
}
