import 'package:flutter/material.dart';
import 'package:sunpower_website/utils/AppColors.dart';

class AboutUs extends StatelessWidget {
  const AboutUs({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: MediaQuery.of(context).size.width * 0.05,
        vertical: 8
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 24,),
          Stack(
            children: [
              Padding(
                padding: const EdgeInsets.only(
                  bottom: 2
                ),
                child: Text("About Us",style: TextStyle(
                  fontSize: 36,
                ),),
              ),
              Positioned(
                bottom: 0,
                left: 0,
                right: 0,
                child: Container(
                  height: 1,
                  color: AppColors.primaryColor,
                ),
              )
            ],
          ),
          const SizedBox(height: 12,),
          Text("""The WAŚ Company is located in Poland’s fastest growing sub-region, Lower Silesia, and specialises in manufacturing lamps and retro-reflectors used in the automotive industry. We have been on the market since 1979, constantly developing our manufacturing processes and products we offer. We use the latest state-of-the-art technology in the industry so that we can provide innovative solutions for automotive lighting. We combine innovation with environmental awareness, attention to new trends and a thorough analysis of our customers' needs.

Please take a look at what we have to offer - choose one of the main categories below or use an advanced search engine.""",
          style: TextStyle(
            fontSize: 18,height: 1.8
          ),
            textAlign: TextAlign.justify,

          )
        ],
      ),
    );
  }
}
