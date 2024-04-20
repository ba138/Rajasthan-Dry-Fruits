// ignore_for_file: library_private_types_in_public_api

import 'package:flutter/material.dart';
import '../../../res/components/colors.dart';

class PriceRangeSlider extends StatefulWidget {
  const PriceRangeSlider({super.key});

  @override
  _PriceRangeSliderState createState() => _PriceRangeSliderState();
}

class _PriceRangeSliderState extends State<PriceRangeSlider> {
  RangeValues _values = const RangeValues(5, 1000);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 75, // Adjust the height as needed
      width: double.infinity,
      color: Colors.transparent, // Set the desired background color
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Price Range: \$${_values.start.toInt()} - \$${_values.end.toInt()}',
            style: const TextStyle(
              fontFamily: 'CenturyGothic',
              fontSize: 18,
              fontWeight: FontWeight.w400,
              color: AppColor.blackColor,
            ),
          ),
          RangeSlider(
            activeColor: AppColor.primaryColor,
            inactiveColor: Colors.grey.shade300,
            values: _values,
            min: 5,
            max: 1000,
            divisions: 100,
            labels: RangeLabels(
              _values.start.round().toString(),
              _values.end.round().toString(),
            ),
            onChanged: (values) {
              setState(() {
                _values = values;
              });
            },
          ),
        ],
      ),
    );
  }
}
