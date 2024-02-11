import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:o2ease/constants/colors.dart';
import 'package:o2ease/screens/home_page.dart';

class Outdoor extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // Text(
      //         "Exercises",
      //         style: TextStyle(
      //             fontSize: 24,
      //             fontWeight: FontWeight.bold,
      //             color: AppColors.primaryColor2),
      //         textAlign: TextAlign.center,
      //       ),
      body: Padding(
        padding: EdgeInsets.only(left: 20, top: 50, right: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            SizedBox(height: 30),
            Container(
              margin: EdgeInsets.symmetric(vertical: 30),
              padding: EdgeInsets.symmetric(horizontal: 20, vertical: 16),
              height: 60,
              width: double.infinity,
              decoration: BoxDecoration(
                color: Color(0xFFF5F5F7),
                borderRadius: BorderRadius.circular(40),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Text(
                  "Category",
                ),
                Text(
                  "See All",
                  // style: kSubtitleTextSyule.copyWith(color: kBlueColor),
                ),
              ],
            ),
            SizedBox(height: 30),
            Expanded(
              child: GridView.builder(
                padding: EdgeInsets.all(0),
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  mainAxisSpacing: 20,
                  crossAxisSpacing: 20,
                  childAspectRatio: 0.75,
                ),
                itemCount: 4,
                itemBuilder: (context, index) {
                  return GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => HomePage(),
                        ),
                      );
                    },
                    child: Container(
                      padding: EdgeInsets.all(20),
                      height: index.isEven ? 200 : 240,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(16),
                        image: DecorationImage(
                          image: AssetImage("assets/images/2.png"),
                          fit: BoxFit.fill,
                        ),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text(
                            "ABC",
                            // style: kTitleTextStyle,
                          ),
                          Text(
                            'Courses',
                            style: TextStyle(
                                // color: kTextColor.withOpacity(.5),
                                ),
                          )
                        ],
                      ),
                    ),
                  );
                },
                // staggeredTileBuilder: (index) => StaggeredTile.fit(1),
              ),
            ),
          ],
        ),
      ),
    );
  }
}