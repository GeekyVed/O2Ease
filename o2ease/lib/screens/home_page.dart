import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:http/http.dart' as http;
import 'package:o2ease/constants/colors.dart';
import 'package:o2ease/widgets/weather_item.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String lat = '';
  String lng = '';
  String apiid = "382f89dd84b034e0754f256be4f5b0da";
  int aqi = 0;
  double co = 0;
  double no2 = 0;
  double so2 = 0;
  double no = 0;
  double o3 = 0;
  double pm2_5 = 0;
  double pm10 = 0;
  double nh3 = 0;

  void fetchPollutionData() async {
    var pollutionData = await http.get(Uri.parse(
        "http://api.openweathermap.org/data/2.5/air_pollution?lat=19.0760&lon=72.8777&appid=382f89dd84b034e0754f256be4f5b0da"));
    Map<String, dynamic> data = json.decode(pollutionData.body);
    print(data);
    List<dynamic> list = data['list'];
    Map<String, dynamic> firstElement = list.isNotEmpty ? list[0] : {};
    Map<String, dynamic> main = firstElement['main'];
    Map<String, dynamic> components = firstElement['components'];

    setState(() {
      aqi = main['aqi'];
      co = components['co'];
      no = components['no'];
      no2 = components['no2'];
      so2 = components['so2'];
      o3 = components['o3'];
      pm2_5 = components['pm2_5'];
      pm10 = components['pm10'];
      nh3 = components['nh3'];
    });
  }

  getLocationOfUser() async {
    LocationPermission permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied ||
        permission == LocationPermission.deniedForever) {
      await Geolocator.requestPermission();
    } else {
      Timer.periodic(Duration(seconds: 30), (timer) {
        _getlocationHelper();
      });
    }
  }

  _getlocationHelper() async {
    Position currentPosition = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.bestForNavigation);
    setState(() {
      lat = currentPosition.latitude.toString();
      lng = currentPosition.longitude.toString();
    });
  }

  @override
  void initState() {
    getLocationOfUser();
    fetchPollutionData();

    super.initState();
  }

  //Create a shader linear gradient
  final Shader linearGradient = const LinearGradient(
    colors: AppColors.gradient,
  ).createShader(const Rect.fromLTWH(0.0, 0.0, 200.0, 70.0));

  @override
  Widget build(BuildContext context) {
    //Create a size variable for the mdeia query
    Size size = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        centerTitle: false,
        titleSpacing: 0,
        backgroundColor: AppColors.shadeColor,
        elevation: 0.0,
        title: Container(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          width: size.width,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              //Our profile image
              ClipRRect(
                borderRadius: const BorderRadius.all(Radius.circular(10)),
                child: Image.asset(
                  'assets/images/userimg.jpg',
                  width: 40,
                  height: 40,
                ),
              ),
            ],
          ),
        ),
      ),
      body: Container(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Latitude : $lat , Longitude: $lng",
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 30.0,
              ),
            ),
            Text(
              "Date",
              style: const TextStyle(
                color: Colors.grey,
                fontSize: 16.0,
              ),
            ),
            const SizedBox(
              height: 50,
            ),
            Container(
              width: size.width,
              height: 200,
              decoration: BoxDecoration(
                  color: AppColors.primaryColor1,
                  borderRadius: BorderRadius.circular(15),
                  boxShadow: [
                    BoxShadow(
                      color: AppColors.primaryColor1.withOpacity(.5),
                      offset: const Offset(0, 25),
                      blurRadius: 10,
                      spreadRadius: -12,
                    )
                  ]),
              child: Stack(
                clipBehavior: Clip.none,
                children: [
                  Positioned(
                    bottom: 30,
                    left: 20,
                    child: Text(
                      "Lolo",
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                      ),
                    ),
                  ),
                  Positioned(
                    top: 20,
                    right: 20,
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(top: 4.0),
                          child: Text(
                            aqi.toString(),
                            style: TextStyle(
                              fontSize: 80,
                              fontWeight: FontWeight.bold,
                              foreground: Paint()..shader = linearGradient,
                            ),
                          ),
                        ),
                        Text(
                          'o',
                          style: TextStyle(
                            fontSize: 40,
                            fontWeight: FontWeight.bold,
                            foreground: Paint()..shader = linearGradient,
                          ),
                        )
                      ],
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(
              height: 50,
            ),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 40),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  weatherItem(
                    text: 'Wind Speed',
                    value: so2,
                    unit: 'km/h',
                    imageUrl: 'assets/images/image1.jpg',
                  ),
                  weatherItem(
                      text: 'Humidity',
                      value: no2,
                      unit: '',
                      imageUrl: 'assets/images/image2.jpg'),
                  weatherItem(
                    text: 'Wind Speed',
                    value: no,
                    unit: 'C',
                    imageUrl: 'assets/images/image3.jpg',
                  ),
                ],
              ),
            ),
            const SizedBox(
              height: 50,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const Text(
                  'Today',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 24,
                  ),
                ),
                Text(
                  'Next 7 Days',
                  style: TextStyle(
                      fontWeight: FontWeight.w600,
                      fontSize: 18,
                      color: AppColors.primaryColor1),
                ),
              ],
            ),
            const SizedBox(
              height: 20,
            ),
            Expanded(
                child: ListView(
              scrollDirection: Axis.horizontal,
              // children: [Container(
              //         padding: const EdgeInsets.symmetric(vertical: 20),
              //         margin: const EdgeInsets.only(
              //             right: 20, bottom: 10, top: 10),
              //         width: 80,
              //         decoration: BoxDecoration(
              //             color: isparamSafe == true
              //                 ? Colors.green.shade300
              //                 : Colors.red.shade400,
              //             borderRadius:
              //                 const BorderRadius.all(Radius.circular(10)),
              //             boxShadow: [
              //               BoxShadow(
              //                 offset: const Offset(0, 1),
              //                 blurRadius: 5,
              //                 color: isparamSafe == true
              //                 ? Colors.green.shade300
              //                 : Colors.red.shade400,
              //               ),
              //             ]),
              //         child: Column(
              //           mainAxisAlignment: MainAxisAlignment.spaceBetween,
              //           children: [
              //             Text(
              //             parameter,
              //               style: TextStyle(
              //                 fontSize: 17,
              //                 color:
              //                    Colors.white
              //                   ,
              //                 fontWeight: FontWeight.w500,
              //               ),
              //             ),
              //             Image.asset(
              //               imgaddress,
              //               width: 30,
              //             ),

              //           ],
              //         ),
              //       )
              // ],
            ))
          ],
        ),
      ),
    );
  }
}
