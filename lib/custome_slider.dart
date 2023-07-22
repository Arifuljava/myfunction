import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CustomSlider extends StatefulWidget {
  final double initialValue;
  final double minValue;
  final double maxValue;
  final Function(double) onChanged;

  const CustomSlider({
    Key? key,
    required this.initialValue,
    required this.minValue,
    required this.maxValue,
    required this.onChanged,
  }) : super(key: key);

  @override
  _CustomSliderState createState() => _CustomSliderState();
}

class _CustomSliderState extends State<CustomSlider> {
  double _value = 0.0;

  @override
  void initState() {
    super.initState();
    _value = widget.initialValue;
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        SizedBox(
          width: 215.w,
          child: Slider(
            min: widget.minValue,
            max: widget.maxValue,
            value: _value,
            onChanged: (value) {
              setState(() {
                _value = value;
              });
              widget.onChanged(value);
            },
          ),
        ),
        Container(
          height: 20.0,
          width: 32.0,
          decoration: BoxDecoration(
            color: Colors.white,
            border: Border.all(color: Colors.grey),
          ),
          child: Center(
            child: Text(
              _value.toString(),
              style: const TextStyle(color: Colors.black),
            ),
          ),
        ),
      ],
    );
  }
}