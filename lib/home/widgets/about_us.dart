import 'package:flutter/material.dart';
import 'package:sunpower_website/utils/AppColors.dart';

class AboutUs extends StatelessWidget {
  const AboutUs({super.key});

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;

    double horizontalPadding =
        width > 1200
            ? width * 0.18
            : width > 800
            ? width * 0.1
            : 16;

    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: (width * 0.18).clamp(8.0, 100.0),
        vertical: 8,
      ),
      child: SingleChildScrollView(
        child: ConstrainedBox(
          constraints: BoxConstraints(minHeight: height * 0.6),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 24),
              SizedBox(
                width: width,
                child: Stack(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(bottom: 2),
                      child: Text(
                        "Auto Truck Store",
                        style: TextStyle(
                          fontSize: 36,
                          color: Color(0xff050505),
                          fontWeight: FontWeight.normal
                        ),
                      ),
                    ),
                    Positioned(
                      bottom: 0,
                      left: 0,
                      right: 0,
                      child: Container(height: 1, color: Colors.grey[300]),
                    ),
                    Positioned(
                      bottom: 0,
                      left: 0,
                      child: Container(
                        height: 1,
                        width: width * 0.18,
                        color: AppColors.primaryColor,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 24),
              Text(
                """The WAŚ Company is located in Poland’s fastest growing sub-region, Lower Silesia, and specialises in manufacturing lamps and retro-reflectors used in the automotive industry. We have been on the market since 1979, constantly developing our manufacturing processes and products we offer. We use the latest state-of-the-art technology in the industry so that we can provide innovative solutions for automotive lighting. We combine innovation with environmental awareness, attention to new trends and a thorough analysis of our customers' needs.""",
                style: TextStyle(fontSize: 18, height: 1.8,color: Color(0xff6d747c)),
              ),
              const SizedBox(height: 12),
              Text(
                "Please take a look at what we have to offer - choose one of the main categories below or use an advanced search engine.",
                style: TextStyle(fontSize: 18, height: 1.8,color: Color(0xff6d747c)),
              ),
              const SizedBox(height: 68),
              Center(
                child: Text(
                  "10 Main Categories of Auto Truck Store".toUpperCase(),
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 62,
                    color: Color(0xff2d2d2d),
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              Center(
                child: Text(
                  "Including more than 4618 lamps which are available in many variants",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 36,
                    color: Color(0xff535353),
                  ),
                ),
              ),
              const SizedBox(height: 38),
            ],
          ),
        ),
      ),
    );
  }
}
