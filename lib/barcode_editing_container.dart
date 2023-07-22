/*import 'package:barcode_widget/barcode_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:printer_ex/created_label_widgets/main/java_bridge.dart';

import '../app_style.dart';
import 'data_input_dialog.dart';*/


/*class BarcodeContainer extends StatefulWidget {
  final VoidCallback onTap;
  final VoidCallback onDoubleTap;
  const BarcodeContainer({
    Key? key,
    required this.onTap, required this.onDoubleTap,
  }) : super(key: key);

  @override
  BarcodeContainerState createState() => BarcodeContainerState();
}

class BarcodeContainerState extends State<BarcodeContainer> {
  double barcodeWidth = 100.0;
  double barcodeHeight = 70.0;

  // Minimum height & width for the barcode
  double minBarcodeWidth = 50.0;
  double minBarcodeHeight = 50.0;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        GestureDetector(
          onTap: widget.onTap,
          onDoubleTap: () {
            setState(() {
              widget.onDoubleTap.call();
              showDialog(
                context: context,
                builder: (BuildContext context) => DataInputDialog(),
              );
            });
          },
          child: Container(
            margin: const EdgeInsets.symmetric(vertical: 15),
            color: Colors.white,
            child: BarcodeWidget(
              barcode: Barcode.code128(),
              data: barcodeData,
              drawText: true,
              color: Colors.black,
              width: barcodeWidth,
              height: barcodeHeight,
            ),
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
      final newWidth = barcodeWidth + details.delta.dx;
      final newHeight = barcodeHeight + details.delta.dy;
      barcodeWidth = newWidth >= minBarcodeWidth ? newWidth : minBarcodeWidth;
      barcodeHeight =
          newHeight >= minBarcodeHeight ? newHeight : minBarcodeHeight;
    });
  }
}


class ShowBarcodeContainer extends StatefulWidget {
  final Function() onDelete;
  final Function() onTemplateClicked;
  const ShowBarcodeContainer({super.key, required this.onTemplateClicked, required this.onDelete});

  @override
  State<ShowBarcodeContainer> createState() => _ShowBarcodeContainerState();
}

class _ShowBarcodeContainerState extends State<ShowBarcodeContainer> {

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          padding: REdgeInsets.only(bottom: 30.h),
          margin: REdgeInsets.only(top: 10.h),
          alignment: Alignment.topCenter,
          child: Image.asset('assets/icons/rectangle.png'),
        ),
        Expanded(
          child: SingleChildScrollView(
            child: Container(
              margin: REdgeInsets.only(top: 15.h),
              width: double.infinity,
              decoration: BoxDecoration(
                color: const Color(0xff5DBCFF).withOpacity(0.13),
                borderRadius: BorderRadius.all(Radius.circular(13.w)),
              ),
              child: Column(
                children: [
                  JavaAdapterState().buildOptionRow(
                    [
                      JavaAdapterState().buildIconButton(
                        'assets/icons/template.png',
                        'Template',
                        widget.onTemplateClicked
                      ),

                      Image.asset('assets/images/line_c.png'),

                      JavaAdapterState().buildTextIonButton(
                          'assets/icons/delete_icon.png', 'Delete',
                          widget.onDelete),

                      JavaAdapterState().buildTextIonButton(
                        'assets/icons/empty.png',
                        'Empty',
                        () {},
                      ),
                      JavaAdapterState().buildTextIonButton(
                        'assets/icons/multiple.png',
                        'Multiple',
                        () {},
                      ),
                      JavaAdapterState().buildTextIonButton(
                        'assets/icons/undo (2).png',
                        'Undo',
                        () {},
                      ),
                      JavaAdapterState().buildTextIonButton(
                        'assets/icons/redo.png',
                        'Redo',
                        () {},
                      ),
                    ],
                  ),
                  SizedBox(height: 20.h),
                  Container(
                    height: 170.h,
                    width: double.infinity,
                    color: Colors.white,
                    padding: REdgeInsets.symmetric(horizontal: 15, vertical: 20),
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            SizedBox(height: 30.h),
                            Text(
                              'Content',
                              style: bodySmall,
                            ),
                            SizedBox(width: 30.w),
                            InkWell(
                              onTap: () {
                                setState(() {
                                  showDialog(
                                    context: context,
                                    builder: (BuildContext context) => DataInputDialog(),
                                  );
                                });
                              },
                              child: Container(
                                height: 35.h,
                                width: 230.w,
                                decoration: BoxDecoration(
                                  border: Border.all(color: Colors.grey),
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(8.r)),
                                ),
                                child: Center(
                                  child: Text(
                                    barcodeData,
                                    style: bodySmall,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 30.h),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            SizedBox(height: 30.h),
                            Text(
                              'Encoding\n type',
                              style: bodySmall,
                            ),
                            SizedBox(width: 30.w),
                            SizedBox(
                              height: 35.h,
                              width: 230.w,
                              child: TextField(
                                decoration: InputDecoration(
                                  hintText: 'Code Type',
                                  border: OutlineInputBorder(
                                    borderSide:
                                        BorderSide(color: Colors.grey.shade100),
                                    borderRadius: BorderRadius.circular(8.r),
                                  ),
                                  filled: true,
                                  fillColor: Colors.grey[200],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}*/


import 'package:barcode_widget/barcode_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_picker/flutter_picker.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:myfunction/created_lavel_main.dart';
import 'package:myfunction/variable.dart';







class BarcodeContainer extends StatefulWidget {
  String barcodeData;
  final String? encodingType;
  int? index=0;

  BarcodeContainer({super.key,  required this.barcodeData, this.encodingType, this.index,});

  @override
  State<BarcodeContainer> createState() => _BarcodeContainerState();
}

class _BarcodeContainerState extends State<BarcodeContainer> {
  double barcodeWidth = 100.0;
  double barcodeHeight = 70.0;

  // Minimum height & width for the barcode
  double minBarcodeWidth = 50.0;
  double minBarcodeHeight = 50.0;


  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          decoration:BoxDecoration(
            border: barcodeBorderWidget
                ? Border.all(
              color: selectedBarCodeIndex == widget.index
                  ? Colors.blue
                  : Colors.transparent,
              width: 2.0,
            )
                : null,
          ),
          child: BarcodeWidget(
            barcode: _getBarcode(),
            data: widget.barcodeData,
            drawText: true,
            color: Colors.black,
            width: barcodeWidth,
            height: barcodeHeight,
          ),
        ),
        Positioned(
          right: -32,
          bottom: -36,
          child: GestureDetector(
            onPanUpdate: _handleResizeGesture,
            child: Visibility(
              visible: barcodeIconBorder,
              child: const SizedBox(
                width: 64,
                height: 64,
                child: Icon(
                  Icons.touch_app,
                  color: Colors.blue,
                  size: 40,
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }

  Barcode _getBarcode() {
    switch (widget.encodingType) {
      case 'Code128':
        return Barcode.code128();
      case 'UPC-A':
        return Barcode.upcA();
      case 'UPC-E':
        return Barcode.upcE();
      case 'EAN-8':
        return Barcode.ean8();
      case 'EAN-13':
        return Barcode.ean13();
      case 'Code93':
        return Barcode.code93();
      case 'Code39':
        return Barcode.code39();
      case 'CodeBar':
        return Barcode.codabar();
      default:
        return Barcode.code128(); // Default to Code 128
    }
  }

  void _handleResizeGesture(DragUpdateDetails details) {
    setState(() {
      final newWidth = barcodeWidth + details.delta.dx;
      final newHeight = barcodeHeight + details.delta.dy;
      barcodeWidth = newWidth >= minBarcodeWidth ? newWidth : minBarcodeWidth;
      barcodeHeight = newHeight >= minBarcodeHeight ? newHeight : minBarcodeHeight;
    });
  }
}

class EncodingTypePicker extends StatelessWidget {
  final String selectedType;
  final ValueChanged<String> onTypeChanged;
  final ValueChanged<String> onConfirm;
  final List<String> supportedTypes;

  const EncodingTypePicker({super.key,
    required this.selectedType,
    required this.onTypeChanged,
    required this.onConfirm,
    required this.supportedTypes,
  });

  void _showPicker(BuildContext context) {
    Picker(
      adapter: PickerDataAdapter<String>(pickerData: supportedTypes),
      hideHeader: true,
      selecteds: [supportedTypes.indexOf(selectedType)],
      title: const Text('Select Encoding Type'),
      onConfirm: (Picker picker, List<int> value) {
        final selectedValue = supportedTypes[value.first];
        onConfirm(selectedValue); // Invoke the onConfirm callback with the selected value
      },
    ).showDialog(context);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 50),
      child: InkWell(
        onTap: () => _showPicker(context),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Center(child: Text(selectedType)),
            const Icon(Icons.arrow_drop_down),
          ],
        ),
      ),
    );
  }
}


