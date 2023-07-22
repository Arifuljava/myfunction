import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:myfunction/created_lavel_main.dart';



enum TimeOfDayFormat {
  h_colon_mm_space_a,
  h_colon_mm_colon_ss_space_a,
  H_colon_mm,
  H_colon_mm_colon_ss,
  None,
}

class TimePickerContainer extends StatefulWidget {
  const TimePickerContainer({super.key});

  @override
  TimePickerContainerState createState() => TimePickerContainerState();
}

class TimePickerContainerState extends State<TimePickerContainer> {
  late TimeOfDay _selectedTime;
  late TimeOfDayFormat _selectedFormat;
  late DateTime _selectedDate;
  late DateFormat _selectedFormatDate;

  double tContainerWidth = 250.0;
  double tContainerHeight = 70.0;

  // Minimum height & width for the barcode
  double minTimeContainerWidth = 250.0;
  double minTimeContainerHeight = 50.0;

  @override
  void initState() {
    super.initState();
    _selectedTime = TimeOfDay.now();
    _selectedFormat = TimeOfDayFormat.h_colon_mm_space_a;
    _selectedDate = DateTime.now();
    _selectedFormatDate = DateFormat.yMMMMd();
  }

  Future<void> showTimePickerDialog() async {
    final TimeOfDay? selectedTime = await showTimePicker(
      context: context,
      initialTime: _selectedTime,
    );

    if (selectedTime != null) {
      setState(() {
        _selectedTime = selectedTime;
      });
    }
  }

  Future<void> showFormatSelectionDialog() async {
    final selectedFormat = await showDialog<TimeOfDayFormat>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Select Time Format'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              ListTile(
                title: const Text('h:mm a'),
                leading: Radio<TimeOfDayFormat>(
                  value: TimeOfDayFormat.h_colon_mm_space_a,
                  groupValue: _selectedFormat,
                  onChanged: (TimeOfDayFormat? value) {
                    setState(() {
                      _selectedFormat = value!;
                    });
                    Navigator.of(context).pop(value);
                  },
                ),
              ),
              ListTile(
                title: const Text('h:mm:ss a'),
                leading: Radio<TimeOfDayFormat>(
                  value: TimeOfDayFormat.h_colon_mm_colon_ss_space_a,
                  groupValue: _selectedFormat,
                  onChanged: (TimeOfDayFormat? value) {
                    setState(() {
                      _selectedFormat = value!;
                    });
                    Navigator.of(context).pop(value);
                  },
                ),
              ),
              ListTile(
                title: const Text('HH:mm'),
                leading: Radio<TimeOfDayFormat>(
                  value: TimeOfDayFormat.H_colon_mm,
                  groupValue: _selectedFormat,
                  onChanged: (TimeOfDayFormat? value) {
                    setState(() {
                      _selectedFormat = value!;
                    });
                    Navigator.of(context).pop(value);
                  },
                ),
              ),
              ListTile(
                title: const Text('HH:mm:ss'),
                leading: Radio<TimeOfDayFormat>(
                  value: TimeOfDayFormat.H_colon_mm_colon_ss,
                  groupValue: _selectedFormat,
                  onChanged: (TimeOfDayFormat? value) {
                    setState(() {
                      _selectedFormat = value!;
                    });
                    Navigator.of(context).pop(value);
                  },
                ),
              ),
              ListTile(
                title: const Text('No'),
                leading: Radio<TimeOfDayFormat>(
                  value: TimeOfDayFormat.None,
                  groupValue: _selectedFormat,
                  onChanged: (TimeOfDayFormat? value) {
                    setState(() {
                      _selectedFormat = value!;
                    });
                    Navigator.of(context).pop(value);
                  },
                ),
              ),
            ],
          ),
        );
      },
    );

    if (selectedFormat != null) {
      setState(() {
        _selectedFormat = selectedFormat;
      });
    }
  }

  String getFormattedTime() {
    if (_selectedFormat == TimeOfDayFormat.None) {
      return '';
    }

    final dateTime = DateTime(
      DateTime.now().year,
      DateTime.now().month,
      DateTime.now().day,
      _selectedTime.hour,
      _selectedTime.minute,
    );

    switch (_selectedFormat) {
      case TimeOfDayFormat.h_colon_mm_space_a:
        return DateFormat('h:mm a').format(dateTime);
      case TimeOfDayFormat.h_colon_mm_colon_ss_space_a:
        return DateFormat('h:mm:ss a').format(dateTime);
      case TimeOfDayFormat.H_colon_mm:
        return DateFormat('HH:mm').format(dateTime);
      case TimeOfDayFormat.H_colon_mm_colon_ss:
        return DateFormat('HH:mm:ss').format(dateTime);
      default:
        return 'Invalid TimeOfDayFormat'; // Return a default message for invalid format
    }
  }

  Future<void> showDatePickerDialog() async {
    final DateTime? selectedDate = await showDatePicker(
      context: context,
      initialDate: _selectedDate,
      firstDate: DateTime(1900),
      lastDate: DateTime(2100),
    );

    if (selectedDate != null) {
      setState(() {
        _selectedDate = selectedDate;
      });
    }
  }

  Future<void> showFormatSelectionDateDialog() async {
    DateFormat? selectedFormat;

    await showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Select Date Format'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              buildFormatRadioListTile('No', null),
              buildFormatRadioListTile('yyyy-MM-dd', 'yyyy-MM-dd'),
              buildFormatRadioListTile('dd/MM/yyyy', 'dd/MM/yyyy'),
              buildFormatRadioListTile('MMMM d, yyyy', 'MMMM d, yyyy'),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('Cancel'),
            ),
          ],
        );
      },
    );

    if (selectedFormat != null) {
      setState(() {
        _selectedFormatDate = selectedFormat;
      });
    }
  }

  Widget buildFormatRadioListTile(String label, String? format) {
    final isSelected = _selectedFormatDate.pattern == format;

    return RadioListTile<String>(
      title: Text(
        label,
        style: TextStyle(
          color: isSelected ? Colors.blue : Colors.black,
          fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
        ),
      ),
      value: format ?? '',
      groupValue: _selectedFormatDate.pattern,
      onChanged: (String? value) {
        setState(() {
          _selectedFormatDate = DateFormat(value!);
        });
        Navigator.of(context).pop(); // Close the dialog
      },
      activeColor: Colors.blue,
      controlAffinity: ListTileControlAffinity.leading,
    );
  }

  String getFormattedDate() {
    return _selectedFormatDate.format(_selectedDate);
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          height: 50,
          width: tContainerWidth,
          color: Colors.transparent,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                getFormattedDate(),
                style: TextStyle(
                  fontWeight: isBold
                      ? FontWeight.bold
                      : FontWeight.normal,
                  fontStyle: isItalic
                      ? FontStyle.italic
                      : FontStyle.normal,
                  decoration: isUnderline!
                      ? TextDecoration.underline
                      : null,
                  fontSize: textFontSize,
                ),
                textAlign: textAlignment,
              ),
              const SizedBox(width: 10),
              Text(
                getFormattedTime(),
                style: TextStyle(
                  fontWeight: isBold
                      ? FontWeight.bold
                      : FontWeight.normal,
                  fontStyle: isItalic
                      ? FontStyle.italic
                      : FontStyle.normal,
                  decoration: isUnderline!
                      ? TextDecoration.underline
                      : null,
                  fontSize: textFontSize,
                ),
                textAlign: textAlignment,
              ),
            ],
          ),
        ),
        Positioned(
          right: -32,
          bottom: -35,
          child: GestureDetector(
            onPanUpdate: _handleResizeGesture,
            child: const SizedBox(
              width: 64,
              height: 64,
              child: Icon(
                Icons.touch_app,
                color: Colors.grey,
                size: 35,
              ),
            ),
          ),
        ),
      ],
    );
  }


  void _handleResizeGesture(DragUpdateDetails details) {
    setState(() {
      final newWidth = tContainerWidth + details.delta.dx;
      final newHeight = tContainerHeight + details.delta.dy;
      tContainerWidth = newWidth >= minTimeContainerWidth ? newWidth : minTimeContainerWidth;
      tContainerHeight = newHeight >= minTimeContainerHeight ? newHeight : minTimeContainerHeight;
    });
  }

}