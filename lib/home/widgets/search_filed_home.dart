import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:sunpower_website/utils/AppColors.dart';

class SearchFiledHome extends StatefulWidget {
  const SearchFiledHome({super.key});

  @override
  State<SearchFiledHome> createState() => _SearchFiledHomeState();
}

class _SearchFiledHomeState extends State<SearchFiledHome> {
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double searchFieldWidth = 250;
    if(width <= 550){
      searchFieldWidth = 100;
    }
    return Container(
      width: searchFieldWidth,
      height: 40,
      decoration: BoxDecoration(
        border: Border(
          bottom: BorderSide(
            color: Colors.white24,
            width: 0.8
          )
        )
      ),
      child: Row(
        children: [
          Icon(
            Icons.search,
            color: Colors.white,
          ),
          const SizedBox(width: 12,),
          Expanded(
            child: TextField(
              cursorWidth: 0.8,
              cursorColor: AppColors.primaryColor,
              style: TextStyle(fontSize: 14,color: Colors.white),
              maxLines: 1,
              onSubmitted: (value){
                context.go('/search/$value');
              },
              decoration: InputDecoration(
                isDense: true,
                contentPadding: EdgeInsets.zero,
                border: InputBorder.none,
                enabledBorder: InputBorder.none,
                errorBorder: InputBorder.none,
                focusedBorder: InputBorder.none,

                /*border: UnderlineInputBorder(
                  // borderRadius: BorderRadius.circular(15),
                  borderSide: BorderSide(
                    color: Colors.white24,
                    width: 0.8
                  ),
                ),
                enabledBorder: UnderlineInputBorder(
                    // borderRadius: BorderRadius.circular(15),
                    borderSide: BorderSide(
                        color: Colors.white24,
                        width: 0.8
                    )
                ),
                focusedBorder: UnderlineInputBorder(
                    // borderRadius: BorderRadius.circular(15),
                    borderSide: BorderSide(
                        color: Colors.white,
                        width: 0.8
                    )
                ),*/
                // prefixIcon: Icon(Icons.search,size: 10,)
              ),
            ),
          ),
        ],
      ),
    );
  }
}
