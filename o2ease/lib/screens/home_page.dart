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
  int aqi = 2;
  double co = 467.3;
  double no2 = 37.99;
  double so2 = 8.23;
  double no = 12.07;
  double o3 = 65.09;
  double pm2_5 = 16.93;
  double pm10 = 23.96;
  double nh3 = 1.62;

  Future<void> fetchPollutionData() async {
    var pollutionData = await http.get(Uri.parse(
        "http://api.openweathermap.org/data/2.5/air_pollution?lat=$lat&lon=$lng&appid=382f89dd84b034e0754f256be4f5b0da"));
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
        _getLocationHelper();
      });
    }
  }

  _getLocationHelper() async {
    Position currentPosition = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.bestForNavigation);
    setState(() {
      lat = currentPosition.latitude.toString();
      lng = currentPosition.longitude.toString();
      // fetchPollutionData(); // Call fetchPollutionData after getting location
    });
  }

  @override
  void initState() {
    getLocationOfUser();

    super.initState();
  }

  //Create a shader linear gradient
  final Shader linearGradient = const LinearGradient(
    colors: AppColors.gradient,
  ).createShader(const Rect.fromLTWH(0.0, 0.0, 200.0, 70.0));

  @override
  Widget build(BuildContext context) {
    //Create a size variable for the media query
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
            ShaderMask(
              shaderCallback: (Rect bounds) {
                return const LinearGradient(
                  colors: AppColors.gradient, // Gradient colors
                  begin: Alignment.centerLeft, // Gradient start point
                  end: Alignment.centerRight, // Gradient end point
                ).createShader(bounds);
              },
              child: Text(
                "Latitude : $lat  Longitude: $lng",
                textAlign: TextAlign.center,
                style: const TextStyle(
                  fontSize: 30,
                  fontWeight: FontWeight.bold,
                ),
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
                ],
              ),
              child: Stack(
                clipBehavior: Clip.none,
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(
                      10,
                    ), // Adjust the radius as needed
                    child: ColorFiltered(
                      colorFilter: ColorFilter.mode(
                        Colors.black.withOpacity(
                          aqi >= 0 && aqi <= 50 ? 0.5 : 1.0,
                        ), // Adjust opacity here
                        BlendMode.srcOver,
                      ),
                      child: Image.asset(
                        aqi >= 0 && aqi <= 50
                            ? 'assets/images/goodaqi.jpg'
                            : 'assets/images/badaqi.jpg',
                      ),
                    ),
                  ),
                  Positioned(
                    bottom: 30,
                    left: 20,
                    child: Text(
                      "Air Quality Index",
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
              padding: const EdgeInsets.symmetric(horizontal: 15),
              height:
                  150, // Set a fixed height to limit the height of the ListView
              child: ListView(
                scrollDirection: Axis.horizontal,
                children: [
                  weatherItem(
                    text: 'Carbon Monoxide',
                    value: co,
                    threshold: 2000,
                    unit: 'ug/m^3',
                    imageUrl: 'assets/images/CO.png',
                  ),
                  weatherItem(
                    text: 'Nitrogen Dioxide',
                    value: no2,
                    threshold: 80,
                    unit: 'ug/m^3',
                    imageUrl: 'assets/images/no2.png',
                  ),
                  weatherItem(
                    text: 'Sulphur Dioxide',
                    value: so2,
                    threshold: 80,
                    unit: 'ug/m^3',
                    imageUrl: 'assets/images/so2.png',
                  ),
                  weatherItem(
                    text: 'Ammonia',
                    value: nh3,
                    threshold: 400,
                    unit: 'ug/m^3',
                    imageUrl: 'assets/images/nh3.png',
                  ),
                  weatherItem(
                    text: 'PM2_5',
                    value: pm2_5,
                    threshold: 60,
                    unit: 'ug/m^3',
                    imageUrl: 'assets/images/pm2_5.png',
                  ),
                  weatherItem(
                    text: 'PM10',
                    value: pm10,
                    threshold: 100,
                    unit: 'ug/m^3',
                    imageUrl: 'assets/images/pm10.jpg',
                  ),
                  weatherItem(
                    text: 'Ozone',
                    value: o3,
                    threshold: 100,
                    unit: 'ug/m^3',
                    imageUrl: 'assets/images/o3.png',
                  ),
                ],
              ),
            ),
            const SizedBox(
              height: 50,
            ),
          ],
        ),
      ),
    );
  }
}
