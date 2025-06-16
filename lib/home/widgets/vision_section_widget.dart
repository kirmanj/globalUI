import 'package:flutter/material.dart';
import 'package:sunpower_website/utils/site_constants.dart';

class VisionSectionWidget extends StatefulWidget {
  const VisionSectionWidget({super.key});

  @override
  State<VisionSectionWidget> createState() => _VisionSectionWidgetState();
}

class _VisionSectionWidgetState extends State<VisionSectionWidget> {
  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
        builder: (context,constrains){
          bool isSmall = constrains.maxWidth < SITE_MIN_WIDTH;
          bool isMid = !isSmall && constrains.maxWidth < SITE_MAX_WIDTH;
          return AspectRatio(
              aspectRatio: isSmall ? 2 : isMid? 3 : 4,
              child: Stack(
                children: [
                  Positioned.fill(
                      child: Image.asset(
                        'assets/images/podmape.jpg',
                        fit: BoxFit.none,
                      )
                  ),
                  PositionedDirectional(
                    start: isSmall ? 0 : MediaQuery.of(context).size.width * 0.25,
                      end: 0,
                      bottom: 0,
                      top: 0,
                      child: Container(
                        color: Color.fromARGB(204, 58, 58, 58),
                        child: Stack(
                          alignment: Alignment.center,
                          children: [
                            SizedBox(
                              width: MediaQuery.of(context).size.width * 0.8,
                              child: Image.asset(
                                'assets/images/mapa.png',
                                fit: BoxFit.contain,
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.symmetric(
                                horizontal: MediaQuery.of(context).size.width * 0.1,
                                vertical: 20
                              ),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.symmetric(
                                      horizontal: 20
                                    ),
                                    child: Text(
                                      "Our lamps on all 6 continents",
                                      style: TextStyle(
                                        fontSize: 28,
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold
                                      ),
                                    ),
                                  ),
                                  const SizedBox(height: 8,),
                                  Text(
                                    "Our products are officially available on 6 continents but we are continuing to expand our customer base. We want our products to be available in every corner of the world. We inspire to become a global brand.",
                                    style: TextStyle(
                                        fontSize: 16,
                                        color: Colors.white,
                                      height: 1.5
                                    ),
                                  )
                                ],
                              ),
                            )
                          ],
                        )
                      ),
                  )
                ],
              )
          );
          if(constrains.maxWidth < SITE_MIN_WIDTH){
            return AspectRatio(
              aspectRatio: 16 / 9,
              child: Stack(
                children: [
                  Positioned.fill(child: Image.asset(
                      'assets/images/podmape.jpg',
                    fit: BoxFit.fitHeight,
                  ))
                ],
              )
            );
          }
          else {
            return AspectRatio(
                aspectRatio: 16 / 9,
                child: Container(
                  color: Colors.blue,
                )
            );
          }
        }
    );
  }
}
