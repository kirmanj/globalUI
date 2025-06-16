import 'package:flutter/material.dart';

class FeaturesSectionWidgets extends StatefulWidget {
  const FeaturesSectionWidgets({super.key});

  @override
  State<FeaturesSectionWidgets> createState() => _FeaturesSectionWidgetsState();
}

class _FeaturesSectionWidgetsState extends State<FeaturesSectionWidgets> {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: Padding(
        padding: EdgeInsets.
          symmetric(
          vertical: 28,
          horizontal: MediaQuery.of(context).size.width * 0.05
        ),
        child: Column(
          children: [
            Text("What makes our offer unique",style: TextStyle(
              fontSize: 28,
              color: Color(0xff050505)
            ),),
            Divider(
              thickness: 1,
              height: 20,
              color: Color(0xffe8e8e8)
            ),
            Text(
              "When choosing a business partner, you are interested in future cooperation. There are many factors which influence partner relations within businesses. Quality should not only be limited to the products that are offered, but experience, work culture and partners’ reviews are equally important. This policy enables us to build long-term relationships.",
              style: TextStyle(
                  fontSize: 18,
                  color: Color(0xff6d747c),
                height: 1.7
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 8,),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _featureWidget('iko1','46 years of experience','As a family business, we have developed our skills over many years. We have a highly-skilled workforce of more than 300 people who work exceptionally well together as a team.'),
                _featureWidget('iko2','Manufacturing in Poland','Our products are fully manufactured in Poland and we are the innovators of all our lighting solutions.'),
                _featureWidget('iko3','Awards','Almost every year, our products receive numerous awards and distinctions for their contribution to innovation in the industry.'),
                _featureWidget('iko4','Testing','Our products are subjected to a wide range of endurance and performance tests as early as at the prototype stage.')
              ],
            )
          ],
        ),
      ),
    );
  }


  _featureWidget(String img,String title,String text){
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: 18
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            SizedBox(
              height: 120,
              width: 160,
              child: Image.asset(
                  "assets/images/$img.png",
               fit: BoxFit.contain,
               // width: ,
              ),
            ),
            const SizedBox(height: 16,),
            Text(title,style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.w600,
              color: Color(0xff050607)
            ),),
            const SizedBox(height: 8,),
            Text(text,style: TextStyle(
              fontSize: 16,
                color: Color(0xff535353)
            ),),
          ],
        ),
      ),
    );
  }
}
