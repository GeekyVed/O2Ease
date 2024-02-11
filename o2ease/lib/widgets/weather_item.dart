import 'package:flutter/material.dart';

class weatherItem extends StatelessWidget {
  const weatherItem(
      {Key? key,
      required this.value,
      required this.text,
      required this.unit,
      required this.imageUrl,
      required this.threshold})
      : super(key: key);

  final double value;
  final String text;
  final String unit;
  final String imageUrl;
  final double threshold;

  @override
  Widget build(BuildContext context) {
    final bool aboveThreshold = value > threshold;

    return Column(
      children: [
        Text(
          text,
          style: const TextStyle(
            color: Colors.black54,
          ),
        ),
        const SizedBox(
          height: 8,
        ),
        Container(
          padding: const EdgeInsets.all(10.0),
          height: 60,
          width: 60,
          decoration: const BoxDecoration(
            color: Color(0xffE0E8FB),
            borderRadius: BorderRadius.all(Radius.circular(15)),
          ),
          child: aboveThreshold == false
              ? Image.asset(imageUrl)
              : Image.asset("assets/images/danger.jpg"),
        ),
        const SizedBox(
          height: 8,
        ),
        Text(
          value.toString() + unit,
          style: const TextStyle(
            fontWeight: FontWeight.bold,
          ),
        )
      ],
    );
  }
}
