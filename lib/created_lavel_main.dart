
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'dart:ui' as ui;
import '../../app_style.dart';
import '../../print_page_size.dart';
import '../barcode_editing_container.dart';
import '../custome_slider.dart';
import '../date_time_editing_container.dart';
import '../emoji_container.dart';
import '../images_take_container.dart';
import '../qrcode_editing_container.dart';
import '../scanner.dart';
import '../table_editing_container.dart';
import '../variable.dart';

// text widget
String labelText = 'Double click here ';
final TextEditingController textEditingController = TextEditingController();
bool isBold = false;
bool isItalic = false;
bool? isUnderline = false;
TextAlign textAlignment = TextAlign.left;
double textFontSize = 15.0;
double textValueSize = 15;
double textFieldX = 0.0;
double textFieldY = 0.0;
double textFieldWidth = 200.0;
double textFieldHeight = 50.0;
String currentText = '';
double minTextFieldWidth = 40.0;

List<String> undoStack = [];
List<String> redoStack = [];
bool showTextEditingWidget = false;
bool showTextEditingContainerFlag = false;
int textButtonCounter = 0;
List<Widget> containerWidgets = [];

double getLabelWidth = 100;
double getLabelHeight = 100;

int sdkPaperSizeWidth = 10;
int sdkPaperSizeHeight = 10;

// barcode widget
String barcodeData = '1234';
String encodingType = 'Code128';
String errorMessage = "";
bool showBarcodeContainerFlag = false;
bool showBarcodeWidget = false;

//position set barcode
double barContainerX = 0;
double barContainerY = 0;

// qrcode widget
String qrcodeData = '5678';
bool showQrcodeWidget = false;
bool showQrcodeContainerFlag = false;

class CreatedContainerMain extends StatefulWidget {
  const CreatedContainerMain({super.key});

  @override
  _CreatedContainerMainState createState() => _CreatedContainerMainState();
}

class _CreatedContainerMainState extends State<CreatedContainerMain> {
  static const platform =
  MethodChannel('com.github.Arifuljava:GrozziieBlutoothSDk:v1.0.1');
  GlobalKey globalKey = GlobalKey();
  Uint8List? imageData;

  //position set text widget
  double textContainerX = 0;
  double textContainerY = 0;

  //position set barcode
  double qrContainerX = 0;
  double qrContainerY = 0;

  // table widget
  final GlobalKey<TableContainerState> tableContainerKey =
  GlobalKey<TableContainerState>();

  bool showTableWidget = false;
  bool showTableContainerFlag = false;

  //position set barcode
  double tableContainerX = 0;
  double tableContainerY = 0;
  double lineWidthValue = 2;

  // Image widget
  final GlobalKey<ImagesTakeContainerState> imageContainerKey =
  GlobalKey<ImagesTakeContainerState>();
  bool showImageWidget = false;
  bool showImageContainerFlag = false;

  //position set barcode
  double imageContainerX = 0;
  double imageContainerY = 0;

  // Image widget
  final GlobalKey<ScannerContainerState> scanContainerKey =
  GlobalKey<ScannerContainerState>();

  bool showScanWidget = false;

  //bool showImageContainer = false;
  //position set barcode
  double scanContainerX = 0;
  double scanContainerY = 0;

  // Date widget
  final GlobalKey<TimePickerContainerState> dateContainerKey =
  GlobalKey<TimePickerContainerState>();
  bool showDateContainerFlag = false;
  bool showDateContainer = false;

  //position set barcode
  double dateContainerX = 0;
  double dateContainerY = 0;

  // Emoji widget
  final GlobalKey<EmojiContainerState> emojiContainerKey =
  GlobalKey<EmojiContainerState>();
  bool showEmojiWidget = false;
  bool showEmojiContainerFlag = false;

  //position set barcode
  double emojiContainerX = 0;
  double emojiContainerY = 0;

  bool selectIndex = false;
  String value = "";
  int nowLabelWidth = 0;

  void _getHeightWidth(
      int paperSizeWidth, int paperSizeHeight, double limitationX) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;
    int screenWidthInt = screenWidth.floor();
    int screenHeightInt = screenHeight.floor();
    sdkPaperSizeWidth = paperSizeWidth;
    sdkPaperSizeHeight = paperSizeHeight;
    nowLabelWidth = screenWidthInt - 10;
    double limitation = limitationX;
    double nowLabelHeight = 100;
    var zoomX = paperSizeWidth / paperSizeHeight;
    nowLabelHeight = nowLabelWidth / zoomX;
    if (nowLabelHeight > limitation * nowLabelWidth) {
      nowLabelHeight = limitation * nowLabelWidth;
      nowLabelWidth = (nowLabelHeight * zoomX).toInt();
    }
    getLabelWidth = (nowLabelWidth).toDouble();
    getLabelHeight = nowLabelHeight;
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = ScreenUtil().screenWidth;

    //_getHeightWidth(widthText, heightText, 1);
    _getHeightWidth(30, 15, 1);

    double containerHeight = getLabelHeight;
    double containerWidth = getLabelWidth;

    return Scaffold(
      backgroundColor: const Color(0xffFFFFFF),
      appBar: _buildAppBar(context),
      body: Column(
        children: [
          _createdLabelContainer(containerHeight, containerWidth, context),
          if (showTextEditingContainerFlag)
            Expanded(child: _showTextEditingContainer(screenWidth))
          else if (showBarcodeContainerFlag)
            Expanded(child: _showBarcodeContainer(screenWidth))
          else if (showQrcodeContainerFlag)
              Expanded(child: _showQrcodeContainer(screenWidth))
            else if (showTableContainerFlag)
                Expanded(child: _showTableContainer(screenWidth))
              else if (showImageContainerFlag)
                  Expanded(child: _showImageContainer(screenWidth))
                else if (showDateContainerFlag)
                    Expanded(child: _showDateContainer(screenWidth))
                  else if (showEmojiContainerFlag)
                      Expanded(child: _showEmojiContainer(screenWidth))
                    else
                      Expanded(child: _buildOptionsContainer(context, screenWidth)),
        ],
      ),
      bottomNavigationBar: buildBottomAppBarButton(screenWidth),
    );
  }

  BottomAppBar buildBottomAppBarButton(double screenWidth) {
    return BottomAppBar(
      child: Container(
        width: screenWidth,
        height: 60.h,
        color: const Color(0xff5DBCFF).withOpacity(0.13),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            ElevatedButton(
              onPressed: () {},
              style: ElevatedButton.styleFrom(
                  alignment: Alignment.center,
                  padding: REdgeInsets.symmetric(vertical: 11, horizontal: 50),
                  primary: const Color(0xff004368),
                  textStyle: TextStyle(
                      fontSize: ScreenUtil().setSp(20),
                      fontWeight: FontWeight.bold)),
              child: const Text('Save'),
            ),
            ElevatedButton(
              onPressed: () {
                printContent();
              },
              style: ElevatedButton.styleFrom(
                  alignment: Alignment.center,
                  padding: REdgeInsets.symmetric(vertical: 11, horizontal: 50),
                  primary: Colors.white,
                  textStyle: TextStyle(
                      fontSize: ScreenUtil().setSp(20),
                      fontWeight: FontWeight.bold)),
              child: const Text(
                'Print',
                style: TextStyle(color: Colors.black45),
              ),
            ),
          ],
        ),
      ),
    );
  }

  PreferredSizeWidget _buildAppBar(BuildContext context) {
    return AppBar(
      elevation: 0,
      backgroundColor: const Color(0xffFFFFFF),
      leading: IconButton(
        onPressed: () {
          Navigator.pop(context);
        },
        icon: const Icon(Icons.arrow_back_ios),
        color: Colors.grey,
      ),
      title: Center(
        child: Text(
          '1/1 \n 45mm*30mm',
          style: Theme.of(context).textTheme.bodyText1!.copyWith(
            fontSize: ScreenUtil().setSp(16),
          ),
          textAlign: TextAlign.center,
        ),
      ),
      actions: [
        IconButton(
          onPressed: () {},
          icon: Image.asset('assets/icons/undo.png'),
          color: Colors.grey,
        ),
        IconButton(
          onPressed: () {},
          icon: Image.asset('assets/icons/info.png'),
          color: Colors.grey,
        ),
      ],
    );
  }

  /*   if (showTextEditingWidget)
                  Positioned(
                    left: textContainerX,
                    top: textContainerY,
                    child: GestureDetector(
                      onPanUpdate: (details) {
                        setState(() {
                          textContainerX += details.delta.dx;
                          textContainerY += details.delta.dy;
                        });
                      },
                      onTapDown: (details) {
                        setState(() {
                          textBorderWidget = true;
                          textIconBorder = true;
                          showTextEditingContainerFlag = true;
                          barcodeBorderWidget = false;
                          barcodeIconBorder = false;
                          qrcodeBorderWidget = false;
                          qrcodeIconBorder = false;
                          emojiIconBorderWidget = false;
                          emojiIconBorder = false;
                        });
                      },
                      // Add the drag gesture handler
                      child: Container(
                        constraints: const BoxConstraints(
                          minHeight: 30,
                        ),
                        decoration: BoxDecoration(
                          border: textBorderWidget
                              ? Border.all(color: Colors.blue, width: 2)
                              : null,
                        ),
                        child: SizedBox(
                          width: textFieldWidth > 0 ? textFieldWidth : 1.0,
                          child: Stack(
                            children: [
                              GestureDetector(
                                onDoubleTap: () =>
                                    _showTextInputDialog(context),
                                child: Text(
                                  labelText,
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
                                  maxLines:
                                      null, // Allow unlimited number of lines
                                ),
                              ),
                              Positioned(
                                right: -32,
                                bottom: -35,
                                // Adjust bottom position
                                child: GestureDetector(
                                  onPanUpdate: _handleResizeGesture,
                                  child: Visibility(
                                    visible: textIconBorder,
                                    child: const SizedBox(
                                      width: 64,
                                      height: 64,
                                      child: Icon(
                                        Icons.touch_app,
                                        color: Colors.blue,
                                        size: 35,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      )
                    ),
                  ),
                if (showBarcodeWidget)
                  Positioned(
                    left: barContainerX,
                    top: barContainerY,
                    child: GestureDetector(
                      onPanUpdate: (details) {
                        setState(() {
                          barContainerX += details.delta.dx;
                          barContainerY += details.delta.dy;
                          print(details);
                        });
                      },
                      child: GestureDetector(
                        onTapDown: (details) {
                          setState(() {
                            barcodeBorderWidget = true;
                            barcodeIconBorder = true;
                            showBarcodeContainerFlag = true;
                            textBorderWidget = false;
                            textIconBorder = false;
                            qrcodeBorderWidget = false;
                            qrcodeIconBorder = false;
                            showTextEditingContainerFlag = false;
                            emojiIconBorderWidget = false;
                            emojiIconBorder = false;
                          });
                        },
                        onDoubleTap: () {
                          setState(() {
                            _showBarcodeInputDialog(context);
                          });
                        },
                        child: BarcodeContainer(
                          barcodeData: barcodeData,
                          encodingType: encodingType,
                        ),
                      ),
                    ),
                  ),*/
  /* if (showTableWidget)
                  Positioned(
                    left: tableContainerX,
                    top: tableContainerY,
                    child: GestureDetector(
                      onPanUpdate: (details) {
                        setState(() {
                          tableContainerX += details.delta.dx;
                          tableContainerY += details.delta.dy;
                        });
                      },
                      child: InkWell(
                        onTap: () {
                          setState(() {
                            showTableContainerFlag = true;
                            showTableWidget = true;
                          });
                        },
                        child: TableContainer(
                          key: tableContainerKey,
                        ),
                      ), // Include the TableContainer widget here
                    ),
                  ),
                if (showImageWidget)
                  Positioned(
                    left: imageContainerX,
                    top: imageContainerY,
                    child: GestureDetector(
                      onPanUpdate: (details) {
                        setState(() {
                          imageContainerX += details.delta.dx;
                          imageContainerY += details.delta.dy;
                        });
                      },
                      child: InkWell(
                        onTap: () {
                          setState(() {
                            showImageContainerFlag = true;
                            showImageWidget = true;
                          });
                        },
                        child: ImagesTakeContainer(
                          key: imageContainerKey,
                        ),
                      ), // Include the TableContainer widget here
                    ),
                  ),
                if (showScanWidget)
                  Positioned(
                    left: scanContainerX,
                    top: scanContainerY,
                    child: GestureDetector(
                      onPanUpdate: (details) {
                        setState(() {
                          scanContainerX += details.delta.dx;
                          scanContainerY += details.delta.dy;
                        });
                      },
                      child: InkWell(
                          onTapDown: (details) {
                            print('Click me');
                            qrcodeBorderWidget = true;
                            qrcodeIconBorder = true;
                            barcodeBorderWidget = true;
                            barcodeIconBorder = true;
                            textBorderWidget = false;
                            textIconBorder = false;
                          },
                          child:
                              ScannerContainer()), // Include the TableContainer widget here
                    ),
                  ),
                if (showDateContainer)
                  Positioned(
                    left: dateContainerX,
                    top: dateContainerY,
                    child: GestureDetector(
                      onPanUpdate: (details) {
                        setState(() {
                          dateContainerX += details.delta.dx;
                          dateContainerY += details.delta.dy;
                        });
                      },
                      child: InkWell(
                        onTap: () {
                          setState(() {
                            showDateContainerFlag = true;
                            showDateContainer = true;
                          });
                        },
                        child: TimePickerContainer(
                          key: dateContainerKey,
                        ),
                      ), // Include the TableContainer widget here
                    ),
                  ),
                if (showEmojiWidget)
                  Positioned(
                    left: emojiContainerX,
                    top: emojiContainerY,
                    child: GestureDetector(
                      onPanUpdate: (details) {
                        setState(() {
                          emojiContainerX += details.delta.dx;
                          emojiContainerY += details.delta.dy;
                        });
                      },
                      onTapDown: (details) {
                        setState(() {
                          emojiIconBorderWidget = true;
                          emojiIconBorder = true;
                          showEmojiContainerFlag = true;
                          qrcodeBorderWidget = false;
                          qrcodeIconBorder = false;
                          barcodeBorderWidget = false;
                          barcodeIconBorder = false;
                        });
                      },
                      child: EmojiContainer(
                        key: emojiContainerKey,
                      ), // Include the TableContainer widget here
                    ),
                  ),*/

  Widget _createdLabelContainer(
      double containerHeight, double containerWidth, BuildContext context) {
    return GestureDetector(
      onTap: () {
        setState(() {
          textBorderWidget = false;
          textIconBorder = false;
          barcodeBorderWidget = false;
          barcodeIconBorder = false;
          qrcodeBorderWidget = false;
          qrcodeIconBorder = false;
        });
      },
      child: RepaintBoundary(
        key: globalKey,
        child: Container(
          height: containerHeight,
          width: containerWidth,
          decoration: BoxDecoration(
            color: Colors.white,
            border: Border.all(color: Colors.black),
            borderRadius:
            BorderRadius.all(Radius.circular(ScreenUtil().setWidth(13))),
          ),
          child: Stack(
            children: [

              if (showTextEditingWidget)
                for (var j = 0; j < textCodes.length; j++)
                  Positioned(
                    left: textContainerX + textCodeOffsets[j].dx,
                    top: textContainerY + textCodeOffsets[j].dy,
                    child: GestureDetector(
                        onPanUpdate: (details) {
                          setState(() {
                            textCodeOffsets[j] = Offset(
                              textCodeOffsets[j].dx + details.delta.dx,
                              textCodeOffsets[j].dy + details.delta.dy,
                            );
                          });
                        },
                        onTapDown: (details) {
                          setState(() {
                            textBorderWidget = true;
                            textIconBorder = true;
                            showTextEditingContainerFlag = true;
                            barcodeBorderWidget = false;
                            barcodeIconBorder = false;
                            qrcodeBorderWidget = false;
                            qrcodeIconBorder = false;
                            emojiIconBorderWidget = false;
                            emojiIconBorder = false;
                            selectedTextCodeIndex = j;
                          });
                        },
                        // Add the drag gesture handler
                        child: Container(
                          constraints: const BoxConstraints(
                            minHeight: 30,
                          ),
                          decoration:  BoxDecoration(
                            border: textBorderWidget
                                ? Border.all(
                              color: selectedTextCodeIndex == j
                                  ? Colors.blue
                                  : Colors.transparent,
                              width: 2.0,
                            )
                                : null,
                          ),
                          child: SizedBox(
                            width: textFieldWidth > 0 ? textFieldWidth : 1.0,
                            child: Stack(
                              children: [
                                GestureDetector(
                                  onDoubleTap: () =>
                                      _showTextInputDialog(context),
                                  child: Text(
                                    labelText,
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
                                    maxLines:
                                    null, // Allow unlimited number of lines
                                  ),
                                ),
                                Positioned(
                                  right: -32,
                                  bottom: -35,
                                  // Adjust bottom position
                                  child: GestureDetector(
                                    onPanUpdate: _handleResizeGesture,
                                    child: Visibility(
                                      visible: selectedTextCodeIndex == j
                                          ? textIconBorder
                                          : false,
                                      child: const SizedBox(
                                        width: 64,
                                        height: 64,
                                        child: Icon(
                                          Icons.touch_app,
                                          color: Colors.blue,
                                          size: 35,
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        )
                    ),
                  ),

              if (showBarcodeWidget)
                for (var i = 0; i < barCodes.length; i++)
                  Positioned(
                    left: barContainerX + barCodeOffsets[i].dx,
                    top: barContainerY + barCodeOffsets[i].dy,
                    child: GestureDetector(
                      onPanUpdate: (details) {
                        setState(() {
                          barCodeOffsets[i] = Offset(
                            barCodeOffsets[i].dx + details.delta.dx,
                            barCodeOffsets[i].dy + details.delta.dy,
                          );
                        });
                      },
                      child: GestureDetector(
                        onTapDown: (details) {
                          setState(() {
                            barcodeBorderWidget = true;
                            barcodeIconBorder = true;
                            showBarcodeContainerFlag = true;
                            textBorderWidget = false;
                            textIconBorder = false;
                            qrcodeBorderWidget = false;
                            qrcodeIconBorder = false;
                            showTextEditingContainerFlag = false;
                            emojiIconBorderWidget = false;
                            emojiIconBorder = false;
                            selectedBarCodeIndex = i;
                            print('select');
                            print(selectedBarCodeIndex);
                          });
                        },
                        onDoubleTap: () {
                          setState(() {
                            _showBarcodeInputDialog(selectedBarCodeIndex,context);
                          });
                        },
                        child: BarcodeContainer(
                          barcodeData: barCodes[selectedBarCodeIndex],
                          encodingType: encodingType,
                          index: i,
                        ),
                      ),
                    ),
                  ),

              if (showQrcodeWidget)
                for (var i = 0; i < qrCodes.length; i++)
                  Positioned(
                    left: qrContainerX + qrCodeOffsets[i].dx,
                    top: qrContainerY + qrCodeOffsets[i].dy,
                    child: GestureDetector(
                      onPanUpdate: (details) {
                        setState(() {
                          qrCodeOffsets[i] = Offset(
                            qrCodeOffsets[i].dx + details.delta.dx,
                            qrCodeOffsets[i].dy + details.delta.dy,
                          );
                        });
                      },
                      onTapDown: (details) {
                        setState(() {
                          qrcodeBorderWidget = true;
                          qrcodeIconBorder = true;
                          showQrcodeContainerFlag = true;
                          textBorderWidget = false;
                          textIconBorder = false;
                          barcodeBorderWidget = false;
                          barcodeIconBorder = false;
                          showBarcodeContainerFlag = false;
                          showTextEditingContainerFlag = false;
                          emojiIconBorderWidget = false;
                          emojiIconBorder = false;
                          selectedQRCodeIndex = i;
                        });
                      },
                      onDoubleTap: () {
                        setState(() {
                          _showQrcodeInputDialog(
                              selectedQRCodeIndex, context);
                        });
                      },
                      child: Stack(
                        children: [
                          Container(
                            decoration: BoxDecoration(
                              border: qrcodeIconBorder
                                  ? Border.all(
                                color: selectedQRCodeIndex == i
                                    ? Colors.blue
                                    : Colors.transparent,
                                width: 2.0,
                              )
                                  : null,
                            ),
                            child: QrImageView(
                              data: qrCodes[i],
                              backgroundColor: Colors.transparent,
                              version: QrVersions.auto,
                              size: qrcodeSize,
                            ),
                          ),
                          Positioned(
                            right: -32,
                            bottom: -36,
                            child: GestureDetector(
                              onPanUpdate: (details) {
                                /*if (selectedQRCodeIndex == i) {
                                  _handleResizeGestureQrForIndex(i,details);
                                }*/
                                _handleResizeGestureQr(details);
                              },
                              child: Visibility(
                                visible: selectedQRCodeIndex == i
                                    ? qrcodeIconBorder
                                    : false,
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
                      ),
                    ),
                  ),

              if (showTableWidget)
                for (var i = 0; i < tableCodes.length; i++)
                  Positioned(
                    left: tableContainerX + tableOffsets[i].dx,
                    top: tableContainerY + tableOffsets[i].dy,
                    child: GestureDetector(
                      onPanUpdate: (details) {
                        setState(() {
                          tableOffsets[i] = Offset(
                            tableOffsets[i].dx + details.delta.dx,
                            tableOffsets[i].dy + details.delta.dy,
                          );
                        });
                      },
                      child: InkWell(
                        onTapDown: (details){
                          setState(() {
                            showTableContainerFlag = true;
                            showTableWidget = true;
                            selectedTableCodeIndex = i;
                            print('table Index');
                            print(selectedTableCodeIndex);
                          });
                        },
                        child: TableContainer(
                          //key:ValueKey<String>(tableCodes[i]),
                        ),
                      ), // Include the TableContainer widget here
                    ),
                  ),

              if (showImageWidget)
                for (var i = 0; i < imageCodes.length; i++)
                  Positioned(
                    left: imageContainerX + imageOffsets[i].dx,
                    top: imageContainerY + imageOffsets[i].dy,
                    child: GestureDetector(
                      onPanUpdate: (details) {
                        setState(() {
                          imageOffsets[i] = Offset(
                            imageOffsets[i].dx + details.delta.dx,
                            imageOffsets[i].dy + details.delta.dy,
                          );
                        });
                      },
                      child: InkWell(
                        onTapDown: (details) {
                          setState(() {
                            showImageContainerFlag = true;
                            showImageWidget = true;
                            selectedImageCodeIndex = i;
                          });
                        },
                        child: ImagesTakeContainer(
                          key: imageContainerKey,
                        ),
                      ), // Include the TableContainer widget here
                    ),
                  ),


            ],
          ),
        ),
      ),
    );
  }


  // /*if (showQrcodeWidget)
  //               for (var i = 0; i < qrCodes.length; i++)
  //                 Positioned(
  //                   left: qrContainerX + qrCodeOffsets[i].dx,
  //                   top: qrContainerY + qrCodeOffsets[i].dy,
  //                   child: GestureDetector(
  //                     onPanUpdate: (details) {
  //                       setState(() {
  //                         qrCodeOffsets[i] = Offset(
  //                           qrCodeOffsets[i].dx + details.delta.dx,
  //                           qrCodeOffsets[i].dy + details.delta.dy,
  //                         );
  //                       });
  //                     },
  //                     onTapDown: (details) {
  //                       setState(() {
  //                         qrcodeBorderWidget = true;
  //                         qrcodeIconBorder = true;
  //                         showQrcodeContainerFlag = true;
  //                         textBorderWidget = false;
  //                         textIconBorder = false;
  //                         barcodeBorderWidget = false;
  //                         barcodeIconBorder = false;
  //                         showBarcodeContainerFlag = false;
  //                         showTextEditingContainerFlag = false;
  //                         emojiIconBorderWidget = false;
  //                         emojiIconBorder = false;
  //                         selectedQRCodeIndex = i;
  //                       });
  //                     },
  //                     onDoubleTap: () {
  //                       setState(() {
  //                         _showQrcodeInputDialog(
  //                             selectedQRCodeIndex, context);
  //                       });
  //                     },
  //                     child: Stack(
  //                       children: [
  //                         Container(
  //                           decoration: BoxDecoration(
  //                             border: qrcodeIconBorder
  //                                 ? Border.all(
  //                               color: selectedQRCodeIndex == i
  //                                   ? Colors.blue
  //                                   : Colors.transparent,
  //                               width: 2.0,
  //                             )
  //                                 : null,
  //                           ),
  //                           child: QrImageView(
  //                             data: qrcodeData,
  //                             backgroundColor: Colors.transparent,
  //                             version: QrVersions.auto,
  //                             size: qrcodeSizes[i],
  //                           ),
  //                         ),
  //                         Positioned(
  //                           right: -32,
  //                           bottom: -36,
  //                           child: GestureDetector(
  //                             // *//*onPanUpdate: (details) {
  //                             //   if (selectedQRCodeIndex == i) {
  //                             //     _handleResizeGestureQrForIndex(i,details);
  //                             //   }
  //                             // },*//*
  //                             onPanUpdate: _handleResizeGesture,
  //                             child: Visibility(
  //                               visible: selectedQRCodeIndex == i
  //                                   ? qrcodeIconBorder
  //                                   : false,
  //                               child: const SizedBox(
  //                                 width: 64,
  //                                 height: 64,
  //                                 child: Icon(
  //                                   Icons.touch_app,
  //                                   color: Colors.blue,
  //                                   size: 40,
  //                                 ),
  //                               ),
  //                             ),
  //                           ),
  //                         ),
  //                       ],
  //                     ),
  //                   ),
  //                 ),*/
  /*if (showQrcodeWidget)
                for (var i = 0; i < qrCodes.length; i++)
                  Positioned(
                    left: qrContainerX + qrCodeOffsets[i].dx,
                    top: qrContainerY + qrCodeOffsets[i].dy,
                    child: GestureDetector(
                      onPanUpdate: (details) {
                        setState(() {
                          qrCodeOffsets[i] = Offset(
                            qrCodeOffsets[i].dx + details.delta.dx,
                            qrCodeOffsets[i].dy + details.delta.dy,
                          );
                        });
                      },
                      onTapDown: (details) {
                        setState(() {
                          qrcodeBorderWidget = true;
                          qrcodeIconBorder = true;
                          showQrcodeContainerFlag = true;
                          textBorderWidget = false;
                          textIconBorder = false;
                          barcodeBorderWidget = false;
                          barcodeIconBorder = false;
                          showBarcodeContainerFlag = false;
                          showTextEditingContainerFlag = false;
                          emojiIconBorderWidget = false;
                          emojiIconBorder = false;
                          selectedQRCodeIndex = i;
                        });
                      },
                      onDoubleTap: () {
                        setState(() {
                          _showQrcodeInputDialog(
                              selectedQRCodeIndex, context);
                        });
                      },
                      child: QrcodeContainer(qrcodeData: qrcodeData)
                    ),
                  ),*/

  Widget _buildOptionsContainer(BuildContext context, double screenWidth) {
    return Stack(children: [
      Container(
        padding: REdgeInsets.only(bottom: 30.h),
        margin: REdgeInsets.only(top: 10.h),
        alignment: Alignment.topCenter,
        child: Image.asset('assets/icons/rectangle.png'),
      ),
      Container(
        margin: REdgeInsets.only(top: 10.h),
        width: screenWidth,
        decoration: BoxDecoration(
          color: const Color(0xff5DBCFF).withOpacity(0.13),
          borderRadius: BorderRadius.all(Radius.circular(13.w)),
        ),
        child: Column(
          children: [
            _buildOptionRow(
              [
                _buildIconButton('assets/icons/template.png', 'Template', () {
                  setState(() {
                    showTextEditingContainerFlag = false;
                  });
                }),
                Image.asset('assets/images/line_c.png'),
                _buildIconButton('assets/icons/empty.png', 'Empty', () {}),
                _buildIconButton(
                    'assets/icons/multiple.png', 'Multiple', () {}),
                _buildIconButton('assets/icons/undo (2).png', 'Undo', () {}),
                _buildIconButton('assets/icons/redo.png', 'Redo', () {}),
              ],
            ),
            SizedBox(height: 10.h),
            Expanded(
              child: SingleChildScrollView(
                // Wrap _buildOptions with SingleChildScrollView
                child: _buildOptions(context, screenWidth),
              ),
            ),
          ],
        ),
      ),
    ]);
  }

  Widget _buildOptions(context, screenWidth) {
    return Container(
      height: 230.h,
      width: screenWidth,
      color: Colors.white,
      padding: REdgeInsets.symmetric(horizontal: 10, vertical: 10),
      child: Column(
        children: [
          _buildOptionRow(
            [
              _buildIconButton('assets/icons/text.png', 'Text', () {
                setState(() {
                  showTextEditingWidget = true;
                  showTextEditingContainerFlag = true;
                  generateTextCode();
                });
              }),
              _buildIconButton('assets/icons/barcode.png', 'Barcode', () {
                setState(() {
                  showBarcodeContainerFlag = true;
                  showBarcodeWidget = true;
                  generateBarCode();
                });
              }),
              _buildIconButton('assets/icons/qrcode.png', 'QR Code', () {
                setState(() {
                  showQrcodeWidget = true;
                  showQrcodeContainerFlag = true;
                  generateQRCode();

                  /*   if(qrCodes.length>0){
                    showQrcodeContainerFlag = true;
                    generateQRCode();
                  }
                  else
                    {
                      showQrcodeContainerFlag=false;
                    }*/
                });
              }),
              _buildIconButton('assets/icons/table.png', 'Table', () {
                setState(() {
                  showTableContainerFlag = true;
                  showTableWidget = true;
                  generateTableCode();
                });
              }),
            ],
          ),
          SizedBox(height: 15.h),
          _buildOptionRow(
            [
              _buildIconButton('assets/icons/images.png', 'Image', () {
                showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return SimpleDialog(
                      title: const Text('Select Image'),
                      children: <Widget>[
                        SimpleDialogOption(
                          onPressed: () {
                            print("Select");
                            setState(() {
                              print("Select++++1");
                              imageContainerKey.currentState?.selectImage();
                            });
                            Navigator.pop(context);

                          },
                          child: const Text('Select Image from Gallery'),
                        ),
                        SimpleDialogOption(
                          onPressed: () {
                            Navigator.pop(context);
                            imageContainerKey.currentState?.takePicture();
                          },
                          child: const Text('Take Picture'),
                        ),
                      ],
                    );
                  },
                );
                setState(() {
                  showImageContainerFlag = true;
                  showImageWidget = true;
                  generateImageCode();
                });
              }),
              _buildIconButton('assets/icons/scan.png', 'Scan', () {
                setState(() {
                  showScanWidget = true;
                  scanBarcode(context);
                });
              }),
              _buildIconButton(
                  'assets/icons/serial_number.png', 'Serial Number', () {}),
              _buildIconButton(
                  'assets/icons/insert_excel.png', 'Insert Excel', () {}),
            ],
          ),
          SizedBox(height: 15.h),
          _buildOptionRow(
            [
              _buildIconButton('assets/icons/time.png', 'Time', () {
                setState(() {
                  showDateContainerFlag = true;
                  showDateContainer = true;
                });
              }),
              _buildIconButton('assets/icons/shape.png', 'Shape', () {}),
              _buildIconButton('assets/icons/line.png', 'Line', () {}),
              _buildIconButton('assets/icons/emoji_icon.png', 'Emoji', () {
                setState(() {
                  showEmojiWidget = true;
                  showEmojiContainerFlag = true;
                });
              }),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildOptionRow(List<Widget> children) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: children,
    );
  }

  Widget _buildIconButton(
      String imagePath, String label, VoidCallback onPressed) {
    return InkWell(
      onTap: onPressed,
      child: SizedBox(
        width: 60.w,
        child: Column(
          children: [
            IconButton(
              onPressed: onPressed,
              icon: Image.asset(
                imagePath,
                width: 24.w,
                height: 24.h,
              ),
              color: Colors.grey,
            ),
            SizedBox(height: 5.h),
            Text(
              label,
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: ScreenUtil().setSp(12),
                color: Colors.black45,
                fontFamily: 'Poppins-Regular',
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ],
        ),
      ),
    );
  }

  // show text editing container
  Widget _showTextEditingContainer(double screenWidth) {
    return Stack(children: [
      Container(
        padding: REdgeInsets.only(bottom: 30.h),
        margin: REdgeInsets.only(top: 10.h),
        alignment: Alignment.topCenter,
        child: Image.asset('assets/icons/rectangle.png'),
      ),
      Container(
        margin: REdgeInsets.only(top: 15.h),
        height: double.infinity,
        width: screenWidth,
        decoration: BoxDecoration(
          color: const Color(0xff5DBCFF).withOpacity(0.13),
          borderRadius: BorderRadius.all(Radius.circular(13.w)),
        ),
        child: Column(
          children: [
            _buildOptionRow(
              [
                _buildIconButton('assets/icons/template.png', 'Template', () {
                  setState(() {
                    showTextEditingContainerFlag = false;
                    showBarcodeContainerFlag = false;
                    showQrcodeContainerFlag = false;
                    showTableContainerFlag = false;
                    showDateContainerFlag = false;
                  });
                }),
                Image.asset('assets/images/line_c.png'),
                _buildTextIonButton(
                    'assets/icons/delete_icon.png', 'Delete', () {
                  setState(() {
                    showTextEditingContainerFlag = false;
                    deleteTextCode();
                  });
                }),
                _buildTextIonButton(
                    'assets/icons/multiple.png', 'Multiple', () {}),
                _buildTextIonButton(
                    'assets/icons/mirroring_icon.png', 'Mirroring', () {}),
                _buildTextIonButton(
                    'assets/icons/lock_icon.png', 'Lock', () {}),
                _buildTextIonButton(
                    'assets/icons/rotated_icon.png', 'Rotate', () {}),
              ],
            ),
            SizedBox(height: 10.h),
            Expanded(
                child: SingleChildScrollView(
                    child: _textEditingOptions(context, screenWidth))),
          ],
        ),
      ),
    ]);
  }

  Widget _buildTextIonButton(
      String imagePath, String label, VoidCallback onPressed) {
    return SizedBox(
      child: Column(
        children: [
          IconButton(
            onPressed: onPressed,
            icon: Image.asset(
              imagePath,
              width: 24.w,
              height: 24.h,
            ),
            color: Colors.grey,
          ),
          SizedBox(height: 5.h),
          Text(
            label,
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: ScreenUtil().setSp(12),
              color: Colors.black45,
              fontFamily: 'Poppins-Regular',
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ],
      ),
    );
  }

  Widget _textEditingOptions(context, screenWidth) {
    return Container(
      height: 180.h,
      width: screenWidth,
      color: Colors.white,
      padding: REdgeInsets.symmetric(horizontal: 10, vertical: 5),
      child: Column(
        children: [
          _textEditingOptionRow(
            [
              IconButton(
                onPressed: _toggleBold,
                icon: Icon(
                  isBold ? Icons.format_bold : Icons.format_bold,
                  color: isBold ? Colors.black : Colors.grey,
                ),
              ),
              IconButton(
                onPressed: _toggleUnderline,
                icon: Icon(
                  isUnderline!
                      ? Icons.format_underline
                      : Icons.format_underline,
                  color: isUnderline! ? Colors.black : Colors.grey,
                ),
              ),
              IconButton(
                  onPressed: _toggleItalic,
                  icon: Icon(
                    isItalic ? Icons.format_italic : Icons.format_italic,
                    color: isItalic ? Colors.black : Colors.grey,
                  )),
              SizedBox(width: 60.w),
              IconButton(
                onPressed: () => _changeAlignment(TextAlign.left),
                icon: Icon(
                  Icons.format_align_left,
                  color: textAlignment == TextAlign.left
                      ? Colors.black
                      : Colors.grey,
                ),
              ),
              IconButton(
                onPressed: () => _changeAlignment(TextAlign.center),
                icon: Icon(
                  Icons.format_align_center,
                  color: textAlignment == TextAlign.center
                      ? Colors.black
                      : Colors.grey,
                ),
              ),
              IconButton(
                onPressed: () => _changeAlignment(TextAlign.right),
                icon: Icon(
                  Icons.format_align_right,
                  color: textAlignment == TextAlign.right
                      ? Colors.black
                      : Colors.grey,
                ),
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text('Text font size',
                  style: bodySmall.copyWith(fontFamily: pMedium)),
              SizedBox(width: 10.w),
              Slider(
                min: 15,
                max: 30,
                value: textValueSize,
                onChanged: (value) {
                  _changeFontSize(value);
                  setState(() {
                    textValueSize = value;
                  });
                },
              ),
              Container(
                height: 20,
                width: 32,
                decoration: BoxDecoration(
                    color: Colors.white,
                    border: Border.all(color: Colors.grey)),
                child: Center(
                  child: Text(
                    textValueSize.toString(),
                    style: const TextStyle(color: Colors.black),
                  ),
                ),
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text('Character arrangement',
                  style: bodySmall.copyWith(fontFamily: pMedium)),
              SizedBox(width: 18.w),
              IconButton(
                  onPressed: () {},
                  icon: Image.asset(
                    'assets/icons/horizontal_icon.png',
                    height: 25,
                    width: 25,
                  )),
              IconButton(
                  onPressed: () {},
                  icon: Image.asset('assets/icons/vertical_icon.png')),
              IconButton(
                  onPressed: () {},
                  icon: Image.asset('assets/icons/curved_icon.png')),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text('Wrap by word', style: bodySmall),
              SizedBox(width: 150.w),
              GestureDetector(
                onTap: warpByWordSwitch,
                child: Container(
                  width: 60,
                  height: 30,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15),
                    color: _wrapByWord ? Colors.green : Colors.grey,
                  ),
                  child: Row(
                    mainAxisAlignment: _wrapByWord
                        ? MainAxisAlignment.end
                        : MainAxisAlignment.start,
                    children: [
                      Container(
                        width: 24,
                        height: 24,
                        margin: REdgeInsets.symmetric(horizontal: 2),
                        decoration: BoxDecoration(
                          shape: BoxShape.rectangle,
                          borderRadius: BorderRadius.circular(12),
                          color: Colors.white,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: 10.h),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text('Reverse Type', style: bodySmall),
              SizedBox(width: 150.w),
              GestureDetector(
                onTap: reverseTypeSwitch,
                child: Container(
                  width: 60,
                  height: 30,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15),
                    color: _reverseType ? Colors.green : Colors.grey,
                  ),
                  child: Row(
                    mainAxisAlignment: _reverseType
                        ? MainAxisAlignment.end
                        : MainAxisAlignment.start,
                    children: [
                      Container(
                        width: 24,
                        height: 24,
                        margin: EdgeInsets.symmetric(horizontal: 2),
                        decoration: BoxDecoration(
                          shape: BoxShape.rectangle,
                          borderRadius: BorderRadius.circular(12),
                          color: Colors.white,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _textEditingOptionRow(List<Widget> children) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: children,
    );
  }

  bool _wrapByWord = false;
  bool _reverseType = false;

  void warpByWordSwitch() {
    setState(() {
      _wrapByWord = !_wrapByWord;
    });
  }

  void reverseTypeSwitch() {
    setState(() {
      _reverseType = !_reverseType;
    });
  }

  // text functionality
  void _toggleBold() {
    setState(() {
      final previousText = textEditingController.text;
      isBold = !isBold;
      undoStack.add(previousText);
      _applyChanges();
    });
  }

  void _toggleUnderline() {
    setState(() {
      final previousText = textEditingController.text;
      isUnderline = !isUnderline!;
      undoStack.add(previousText);
      _applyChanges();
    });
  }

  void _toggleItalic() {
    setState(() {
      final previousText = textEditingController.text;
      isItalic = !isItalic;
      undoStack.add(previousText);
      _applyChanges();
    });
  }

  void _changeAlignment(TextAlign alignment) {
    setState(() {
      final previousText = textEditingController.text;
      textAlignment = alignment;
      undoStack.add(previousText);
      _applyChanges();
    });
  }

  void _changeFontSize(double fontSize) {
    setState(() {
      final previousText = textEditingController.text;
      textFontSize = fontSize;
      undoStack.add(previousText);
      _applyChanges();
    });
  }

  void _applyChanges() {
    textEditingController.value = TextEditingValue(
      text: currentText,
      selection: TextSelection.collapsed(offset: currentText.length),
    );
    _updateTextFieldSize();
  }

  void _updateTextFieldSize() {
    final textSpan = TextSpan(
      text: currentText,
      style: TextStyle(
        fontWeight: isBold ? FontWeight.bold : FontWeight.normal,
        fontStyle: isItalic ? FontStyle.italic : FontStyle.normal,
        decoration: isUnderline! ? TextDecoration.underline : null,
        fontSize: textFontSize,
      ),
    );

    final textPainter = TextPainter(
      text: textSpan,
      textDirection: TextDirection.ltr,
    );

    textPainter.layout(maxWidth: textFieldWidth);

    final textWidth = textPainter.size.width;
    final textHeight = textPainter.size.height;

    // Calculate the number of lines required based on the available width
    final availableWidth = textFieldWidth - 16.0; // Adjust for padding
    final lines = (textWidth / availableWidth).ceil();

    // Ensure a minimum height for the TextField
    final minHeight = textFontSize + 12.0; // Minimum height based on font size

    setState(() {
      textFieldHeight =
          (textHeight * lines + 16.0).clamp(minHeight, double.infinity);
    });
  }

  void _handleResizeGesture(DragUpdateDetails details) {
    setState(() {
      final newWidth = textFieldWidth + details.delta.dx;
      const minWidth = 50.0; // Set the minimum width for the TextField
      if (newWidth >= minWidth) {
        textFieldWidth = newWidth;
      } else {
        textFieldWidth =
            minWidth; // Set the TextField width to the minimum value
      }
    });
  }

  // show text editing input data dialog
  void _showTextInputDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return Dialog(
          alignment: Alignment.bottomCenter,
          insetPadding: REdgeInsets.symmetric(vertical: 5, horizontal: 5),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          child: Container(
            margin: REdgeInsets.all(5),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(10.r)),
              border: Border.all(color: Colors.black12),
            ),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    textAlign: TextAlign.center,
                    focusNode: inputFocusNode,
                    controller: textEditingController,
                    decoration: const InputDecoration(
                      border: InputBorder.none,
                    ),
                    onChanged: (value) {
                      setState(() {
                        labelText = value; // Update labelText
                        _updateTextFieldSize();
                      });
                    },
                  ),
                ),
                TextButton(
                  onPressed: () {
                    final inputBarcodeText = textEditingController.text;
                    if (inputBarcodeText.isNotEmpty) {
                      setState(() {
                        labelText =
                            textEditingController.text; // Update barcode data
                      });
                      Navigator.pop(context);
                    }
                  },
                  child: const Text('Confirm'),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  //show barcode container
  final List<String> supportedEncodingTypes = [
    'Code128',
    'UPC-A',
    'UPC-E',
    'EAN-8',
    'EAN-13',
    'Code93',
    'Code39',
    'CodeBar',
  ];

  //show barcode container
  bool _checkDataLength(String encodingType) {
    switch (encodingType) {
      case 'UPC-A':
        return barcodeData.length == 12;
      case 'UPC-E':
        return barcodeData.length == 6;
      case 'EAN-8':
        return barcodeData.length == 7;
      case 'EAN-13':
        return barcodeData.length == 13;
      default:
        return true; // No length restriction for other encoding types
    }
  }

  //show barcode container
  Widget _showBarcodeContainer(double screenWidth) {
    return Stack(children: [
      Container(
        padding: REdgeInsets.only(bottom: 30.h),
        margin: REdgeInsets.only(top: 10.h),
        alignment: Alignment.topCenter,
        child: Image.asset('assets/icons/rectangle.png'),
      ),
      Container(
        margin: REdgeInsets.only(top: 15.h),
        width: screenWidth,
        decoration: BoxDecoration(
          color: const Color(0xff5DBCFF).withOpacity(0.13),
          borderRadius: BorderRadius.all(Radius.circular(13.w)),
        ),
        child: Column(
          children: [
            _buildOptionRow(
              [
                _buildIconButton('assets/icons/template.png', 'Template', () {
                  setState(() {
                    showBarcodeWidget = true;
                    showBarcodeContainerFlag = false;
                    showTextEditingContainerFlag = false;
                    showQrcodeContainerFlag = false;
                    showTableContainerFlag = false;
                    showDateContainerFlag = false;
                  });
                }),
                Image.asset('assets/images/line_c.png'),
                _buildTextIonButton('assets/icons/delete_icon.png', 'Delete',
                        () {
                      setState(() {
                        if (selectedBarCodeIndex == null) {
                        } else {
                          deleteBarCode();
                          showBarcodeContainerFlag = false;
                        }
                      });
                    }),
                _buildTextIonButton('assets/icons/empty.png', 'Empty', () {}),
                _buildTextIonButton(
                    'assets/icons/multiple.png', 'Multiple', () {}),
                _buildTextIonButton('assets/icons/undo (2).png', 'Undo', () {}),
                _buildTextIonButton('assets/icons/redo.png', 'Redo', () {}),
              ],
            ),
            SizedBox(height: 20.h),
            Expanded(
              child: SingleChildScrollView(
                child: Container(
                  height: 170.h,
                  width: screenWidth,
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
                              _showBarcodeInputDialog(selectedBarCodeIndex,context);
                            },
                            child: Container(
                              height: 35.h,
                              width: 230.w,
                              decoration: BoxDecoration(
                                  border: Border.all(color: Colors.grey),
                                  borderRadius:
                                  BorderRadius.all(Radius.circular(8.r))),
                              child: Center(
                                child: Text(
                                  barcodeData,
                                  style: bodySmall,
                                ),
                              ),
                            ),
                          )
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
                          Container(
                            height: 35.h,
                            width: 230.w,
                            decoration: BoxDecoration(
                                border: Border.all(color: Colors.grey),
                                borderRadius:
                                BorderRadius.all(Radius.circular(8.r))),
                            child: EncodingTypePicker(
                              selectedType: encodingType,
                              supportedTypes: supportedEncodingTypes,
                              onTypeChanged: (value) {
                                setState(() {
                                  encodingType = value;
                                  errorMessage =
                                  ""; // Reset error message when the encoding type changes
                                });
                              },
                              onConfirm: (value) {
                                setState(() {
                                  encodingType = value;
                                  if (!_checkDataLength(value)) {
                                    errorMessage =
                                    'Invalid data length for $value';
                                  } else {
                                    errorMessage = "";
                                  }
                                });
                              },
                            ),
                          ),
                        ],
                      )
                    ],
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    ]);
  }

  // show barcode input data dialog
  final TextEditingController _inputBarcodeData = TextEditingController();
  final FocusNode inputFocusNode = FocusNode();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      // Show the keyboard programmatically
      inputFocusNode.requestFocus();
    });
  }

  @override
  void dispose() {
    _inputBarcodeData.dispose();
    _inputQrcodeData.dispose();
    inputFocusNode.dispose();
    super.dispose();
  }

  void _showBarcodeInputDialog(int selectIndex, BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return Dialog(
          alignment: Alignment.bottomCenter,
          insetPadding: REdgeInsets.symmetric(vertical: 5, horizontal: 5),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          child: Container(
            margin: REdgeInsets.all(5),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(10.r)),
              border: Border.all(color: Colors.black12),
            ),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    textAlign: TextAlign.center,
                    focusNode: inputFocusNode,
                    controller: _inputBarcodeData,
                    decoration: const InputDecoration(
                      border: InputBorder.none,
                    ),
                    onChanged: (value) {
                      setState(() {
                        if (barCodes.isNotEmpty) {
                          barCodes[selectIndex] = _inputBarcodeData.text;
                        }
                      });
                    },
                  ),
                ),
                TextButton(
                  onPressed: () {
                    final inputBarcodeText = _inputBarcodeData.text;
                    if (barCodes.isNotEmpty) {
                      setState(() {
                        barCodes[selectIndex] = inputBarcodeText; // Update barcode data
                      });
                      Navigator.pop(context);
                    }
                  },
                  child: const Text('Confirm'),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  //show qrcode container
  Widget _showQrcodeContainer(double screenWidth) {
    return Stack(children: [
      Container(
        padding: REdgeInsets.only(bottom: 30.h),
        margin: REdgeInsets.only(top: 10.h),
        alignment: Alignment.topCenter,
        child: Image.asset('assets/icons/rectangle.png'),
      ),
      Container(
        margin: REdgeInsets.only(top: 15.h),
        width: screenWidth,
        decoration: BoxDecoration(
          color: const Color(0xff5DBCFF).withOpacity(0.13),
          borderRadius: BorderRadius.all(Radius.circular(13.w)),
        ),
        child: Column(
          children: [
            _buildOptionRow(
              [
                _buildIconButton('assets/icons/template.png', 'Template', () {
                  setState(() {
                    showQrcodeWidget = true;
                    showQrcodeContainerFlag = false;
                    showBarcodeContainerFlag = false;
                    showTextEditingContainerFlag = false;
                    showQrcodeContainerFlag = false;
                    showTableContainerFlag = false;
                    showDateContainerFlag = false;
                  });
                }),
                Image.asset('assets/images/line_c.png'),
                _buildTextIonButton('assets/icons/delete_icon.png', 'Delete',
                        () {
                      setState(() {
                        if (selectedQRCodeIndex == null) {
                        } else {
                          deleteQRCode();
                          showQrcodeContainerFlag = false;
                        }
                      });
                    }),
                _buildTextIonButton('assets/icons/empty.png', 'Empty', () {}),
                _buildTextIonButton(
                    'assets/icons/multiple.png', 'Multiple', () {}),
                _buildTextIonButton('assets/icons/undo (2).png', 'Undo', () {}),
                _buildTextIonButton('assets/icons/redo.png', 'Redo', () {}),
              ],
            ),
            SizedBox(height: 20.h),
            Expanded(
              child: SingleChildScrollView(
                child: Container(
                  height: 170.h,
                  width: screenWidth,
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
                              _showQrcodeInputDialog(
                                  selectedQRCodeIndex, context);
                            },
                            child: Container(
                              height: 35.h,
                              width: 230.w,
                              decoration: BoxDecoration(
                                  border: Border.all(color: Colors.grey),
                                  borderRadius:
                                  BorderRadius.all(Radius.circular(8.r))),
                              child: Center(
                                child: Text(
                                  //qrcodeData,//ture
                                  qrCodes.length > 0
                                      ? qrCodes[selectedQRCodeIndex]
                                      : qrcodeData,
                                  //qrCodes[selectedQRCodeIndex!],
                                  style: bodySmall,
                                ),
                              ),
                            ),
                          )
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
                          Container(
                            height: 35.h,
                            width: 230.w,
                            decoration: BoxDecoration(
                                border: Border.all(color: Colors.grey),
                                borderRadius:
                                BorderRadius.all(Radius.circular(8.r))),
                            child: Center(
                              child: Text('QR_CODE', style: bodySmall),
                            ),
                          )
                        ],
                      )
                    ],
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    ]);
  }

  // show qrcode input data dialog
  final TextEditingController _inputQrcodeData = TextEditingController();

  void _handleResizeGestureQr( DragUpdateDetails details) {
    setState(() {
      final newQrcodeSize = qrcodeSize + details.delta.dx;
      qrcodeSize =
      newQrcodeSize >= minQrcodeSize ? newQrcodeSize : minQrcodeSize;
      selectedQRCodeIndex = 0;
    });
  }

  void _handleResizeGestureQrForIndex(int index, details) {
    print('index');
    print(index.toString());
    if (selectedQRCodeIndex == index) {
      setState(() {
        qrcodeSizes[index] += details.delta.dx;
        qrcodeSizes[index] = qrcodeSizes[index] >= minQrcodeSize ? qrcodeSizes[index] : minQrcodeSize;
      });
    }
  }

  void _showQrcodeInputDialog(int selectedQRCodeIndex, BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return Dialog(
          alignment: Alignment.bottomCenter,
          insetPadding: REdgeInsets.symmetric(vertical: 5, horizontal: 5),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          child: Container(
            margin: REdgeInsets.all(5),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(10.r)),
              border: Border.all(color: Colors.black12),
            ),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    textAlign: TextAlign.center,
                    focusNode: inputFocusNode,
                    controller: _inputQrcodeData,
                    decoration: const InputDecoration(
                      border: InputBorder.none,
                    ),
                    onChanged: (value) {
                      setState(() {
                        if (qrCodes.length > 0) {
                          qrCodes[selectedQRCodeIndex] = _inputQrcodeData.text;
                        }
                      });
                    },
                  ),
                ),
                TextButton(
                  onPressed: () {
                    final inputQrcodeText = _inputQrcodeData.text;
                    if (inputQrcodeText.isNotEmpty) {
                      setState(() {
                        if (qrCodes.length > 0) {
                          qrCodes[selectedQRCodeIndex] = inputQrcodeText;
                        }
                      });
                      Navigator.pop(context);
                    } else {
                      if (qrCodes.length > 0) {
                        qrCodes[selectedQRCodeIndex] = inputQrcodeText;
                      }
                    }
                  },
                  child: const Text('Confirm'),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  // show table container
  Widget _showTableContainer(double screenWidth) {
    return Stack(children: [
      Container(
        padding: REdgeInsets.only(bottom: 30.h),
        margin: REdgeInsets.only(top: 10.h),
        alignment: Alignment.topCenter,
        child: Image.asset('assets/icons/rectangle.png'),
      ),
      Container(
        margin: REdgeInsets.only(top: 15.h),
        width: screenWidth,
        decoration: BoxDecoration(
          color: const Color(0xff5DBCFF).withOpacity(0.13),
          borderRadius: BorderRadius.all(Radius.circular(13.w)),
        ),
        child: Column(
          children: [
            _buildOptionRow(
              [
                _buildIconButton('assets/icons/template.png', 'Template', () {
                  setState(() {
                    showTableContainerFlag = false; // Hide the barcode widget
                    showTableWidget = true;
                  });
                }),
                Image.asset('assets/images/line_c.png'),
                _buildTextIonButton('assets/icons/delete_icon.png', 'Delete',
                        () {
                      setState(() {
                        showTableContainerFlag = false;
                        deleteTableCode();
                      });
                    }),
                _buildTextIonButton('assets/icons/empty.png', 'Empty', () {}),
                _buildTextIonButton(
                    'assets/icons/multiple.png', 'Multiple', () {}),
                _buildTextIonButton('assets/icons/undo (2).png', 'Undo', () {}),
                _buildTextIonButton('assets/icons/redo.png', 'Redo', () {}),
              ],
            ),
            SizedBox(height: 20.h),
            Expanded(
              child: SingleChildScrollView(
                child: Container(
                  height: 210.h,
                  width: screenWidth,
                  color: Colors.white,
                  padding: REdgeInsets.symmetric(horizontal: 15, vertical: 20),
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              InkWell(
                                  onTap: () {
                                    _addColumn();
                                  },
                                  child: Image.asset(
                                      'assets/icons/inset_colum_icon.png')),
                              SizedBox(
                                height: 5.h,
                              ),
                              const Text('Insert colum')
                            ],
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              InkWell(
                                  onTap: () {
                                    _addRow();
                                  },
                                  child: Image.asset(
                                      'assets/icons/insert_row_icon.png')),
                              SizedBox(
                                height: 5.h,
                              ),
                              const Text('Insert Row')
                            ],
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              InkWell(
                                  onTap: () {
                                    _removeColumn();
                                  },
                                  child: Image.asset(
                                      'assets/icons/delete_colum_icon.png')),
                              SizedBox(
                                height: 5.h,
                              ),
                              const Text('Delete colum')
                            ],
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              InkWell(
                                  onTap: () {
                                    _removeRow();
                                  },
                                  child: Image.asset(
                                      'assets/icons/delete_row_icon.png')),
                              SizedBox(
                                height: 10.h,
                              ),
                              const Text('Delete Row')
                            ],
                          )
                        ],
                      ),
                      SizedBox(height: 20.h),
                      Row(
                        children: [
                          Text(
                            'Line width',
                            style: bodySmall,
                          ),
                          SizedBox(width: 15.w),
                          CustomSlider(
                            initialValue: lineWidthValue,
                            minValue: 2.0,
                            maxValue: 30.0,
                            onChanged: (value) {
                              lineWidthValue = value;
                            },
                          )
                        ],
                      ),
                      Row(
                        children: [
                          Text(
                            'Row height',
                            style: bodySmall,
                          ),
                          SizedBox(width: 9.w),
                          CustomSlider(
                            initialValue: lineWidthValue,
                            minValue: 2.0,
                            maxValue: 30.0,
                            onChanged: (value) {
                              lineWidthValue = value;
                            },
                          )
                        ],
                      ),
                      Row(
                        children: [
                          Text(
                            'Colum width',
                            style: bodySmall,
                          ),
                          SizedBox(width: 1.w),
                          CustomSlider(
                            initialValue: lineWidthValue,
                            minValue: 2.0,
                            maxValue: 30.0,
                            onChanged: (value) {
                              lineWidthValue = value;
                            },
                          )
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    ]);
  }

  // show Image container
  Widget _showImageContainer(double screenWidth) {
    return Stack(children: [
      Container(
        padding: REdgeInsets.only(bottom: 30.h),
        margin: REdgeInsets.only(top: 10.h),
        alignment: Alignment.topCenter,
        child: Image.asset('assets/icons/rectangle.png'),
      ),
      Container(
        margin: REdgeInsets.only(top: 15.h),
        width: screenWidth,
        decoration: BoxDecoration(
          color: const Color(0xff5DBCFF).withOpacity(0.13),
          borderRadius: BorderRadius.all(Radius.circular(13.w)),
        ),
        child: Column(
          children: [
            _buildOptionRow(
              [
                _buildIconButton('assets/icons/template.png', 'Template', () {
                  setState(() {
                    showImageContainerFlag = false; // Hide the barcode widget
                    showImageWidget = true;
                  });
                }),
                Image.asset('assets/images/line_c.png'),
                _buildTextIonButton('assets/icons/delete_icon.png', 'Delete',
                        () {
                      setState(() {
                        showImageContainerFlag = false; // Hide additional container
                        showImageWidget = false;
                      });
                    }),
                _buildTextIonButton(
                    'assets/icons/multiple.png', 'Multiple', () {}),
                _buildTextIonButton('assets/icons/undo (2).png', 'Undo', () {}),
                _buildTextIonButton('assets/icons/redo.png', 'Redo', () {}),
              ],
            ),
            SizedBox(height: 20.h),
            Expanded(
              child: SingleChildScrollView(
                child: Container(
                  height: 210.h,
                  width: screenWidth,
                  color: Colors.white,
                  padding: REdgeInsets.symmetric(horizontal: 15, vertical: 20),
                  child: Column(
                    children: [
                      Row(
                        children: [
                          Text(
                            'Threshold ',
                            style: bodySmall,
                          ),
                          SizedBox(width: 10.w),
                          CustomSlider(
                            initialValue: lineWidthValue,
                            minValue: 2.0,
                            maxValue: 30.0,
                            onChanged: (value) {
                              lineWidthValue = value;
                            },
                          )
                        ],
                      ),
                      SizedBox(height: 20.h),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Proportional stretch',
                            style: bodySmall,
                          ),
                          GestureDetector(
                            onTap: warpByWordSwitch,
                            child: Container(
                              width: 50.w,
                              height: 25.h,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(15),
                                color: _wrapByWord ? Colors.green : Colors.grey,
                              ),
                              child: Row(
                                mainAxisAlignment: _wrapByWord
                                    ? MainAxisAlignment.end
                                    : MainAxisAlignment.start,
                                children: [
                                  Container(
                                    width: 20.w,
                                    height: 20.h,
                                    margin:
                                    REdgeInsets.symmetric(horizontal: 2),
                                    decoration: BoxDecoration(
                                      shape: BoxShape.rectangle,
                                      borderRadius: BorderRadius.circular(12),
                                      color: Colors.white,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    ]);
  }

  // show scan popup dialog
  Future<void> scanBarcode(BuildContext context) async {
    String scanResult;
    try {
      scanResult = await FlutterBarcodeScanner.scanBarcode(
        '#FF0000',
        'Cancel',
        true,
        ScanMode.DEFAULT,
      );
    } catch (e) {
      scanResult = 'Failed to get the barcode or QR code: $e';
    }

    setState(() {
      barcodeScanRes = scanResult;
      showTextResult = false;
      showBarcode = false;
      showQRCode = false;
    });

    if (barcodeScanRes != '-1') {
      bool isButtonClick = true;
      showModalBottomSheet(
        context: context,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(top: Radius.circular(20.0)),
        ),
        builder: (BuildContext context) {
          return StatefulBuilder(
            builder: (BuildContext context, StateSetter setState) {
              return Container(
                margin: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                child: Column(
                  children: [
                    Text(
                      'Scanning Result',
                      style: bodyMedium,
                    ),
                    SizedBox(height: 10.h),
                    Align(
                      alignment: Alignment.topLeft,
                      child: Container(
                        margin: REdgeInsets.symmetric(horizontal: 30),
                        child: Text(
                          'Choose insertion type',
                          style: bodySmall,
                        ),
                      ),
                    ),
                    SizedBox(height: 10.h),
                    Container(
                      height: 150.h,
                      width: 260.w,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(11.r)),
                      ),
                      child: Center(
                          child: ScannerContainerState().buildResultWidget()),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        TextButton(
                          onPressed: () {
                            setState(() {
                              showTextResult = true;
                              showBarcode = false;
                              showQRCode = false;
                            });
                          },
                          child: Text(
                            'Text',
                            style: (showTextResult == true ||
                                isButtonClick == true)
                                ? TextStyle(color: Colors.blue)
                                : bodySmall,
                          ),
                        ),
                        SizedBox(width: 10.w),
                        TextButton(
                          onPressed: () {
                            setState(() {
                              isButtonClick = false;
                              showBarcode = true;
                              showQRCode = false;
                              showTextResult = false;
                            });
                          },
                          child: Text(
                            'Bar Code',
                            style: showBarcode
                                ? TextStyle(color: Colors.blue)
                                : bodySmall,
                          ),
                        ),
                        SizedBox(width: 10.w),
                        TextButton(
                          onPressed: () {
                            setState(() {
                              isButtonClick = false;
                              showQRCode = true;
                              showBarcode = false;
                              showTextResult = false;
                            });
                          },
                          child: Text(
                            'QR Code',
                            style: showQRCode
                                ? TextStyle(color: Colors.blue)
                                : bodySmall,
                          ),
                        ),
                      ],
                    ),
                    ReusableButton(
                      text: 'Confirm',
                      onPressed: () {
                        Navigator.of(context).pop();
                        setState(() {
                          showTextResult = false;
                          resultWidget =
                              ScannerContainerState().buildResultWidget();
                        });
                      },
                      width: 170.w,
                      height: 45.h,
                    ),
                  ],
                ),
              );
            },
          );
        },
      ).then((_) {
        setState(() {
          // Update the main Container widget after closing the modal
          resultWidget = ScannerContainerState().buildResultWidget();
        });
      });
    }
  }

  // show DatePicker container
  bool showStyleContainer = false;
  Widget _showDateContainer(double screenWidth) {
    return Stack(children: [
      Container(
        padding: REdgeInsets.only(bottom: 30.h),
        margin: REdgeInsets.only(top: 10.h),
        alignment: Alignment.topCenter,
        child: Image.asset('assets/icons/rectangle.png'),
      ),
      Container(
        margin: REdgeInsets.only(top: 15.h),
        width: screenWidth,
        decoration: BoxDecoration(
          color: const Color(0xff5DBCFF).withOpacity(0.13),
          borderRadius: BorderRadius.all(Radius.circular(13.w)),
        ),
        child: Column(
          children: [
            _buildOptionRow(
              [
                _buildIconButton('assets/icons/template.png', 'Template', () {
                  setState(() {
                    showDateContainerFlag = false; // Hide the barcode widget
                    showDateContainer = true;
                  });
                }),
                Image.asset('assets/images/line_c.png'),
                _buildTextIonButton('assets/icons/delete_icon.png', 'Delete',
                        () {
                      setState(() {
                        showDateContainerFlag = false; // Hide additional container
                        showDateContainer = false;
                      });
                    }),
                _buildTextIonButton('assets/icons/empty.png', 'Empty', () {}),
                _buildTextIonButton(
                    'assets/icons/multiple.png', 'Multiple', () {}),
                _buildTextIonButton('assets/icons/undo (2).png', 'Undo', () {}),
                _buildTextIonButton('assets/icons/redo.png', 'Redo', () {}),
              ],
            ),
            SizedBox(height: 20.h),
            if (showStyleContainer)
              Expanded(
                  child: SingleChildScrollView(
                      child: _textEditingOptions(context, screenWidth)))
            else
              Expanded(
                child: SingleChildScrollView(
                  child: Container(
                    height: 210.h,
                    width: screenWidth,
                    color: Colors.white,
                    padding:
                    REdgeInsets.symmetric(horizontal: 15, vertical: 20),
                    child: Column(
                      children: [
                        Row(
                          children: [
                            Text(
                              'Date :',
                              style: bodySmall,
                            ),
                            SizedBox(width: 10.w),
                            ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                    backgroundColor: Colors.transparent),
                                onPressed: () {
                                  dateContainerKey.currentState
                                      ?.showDatePickerDialog();
                                },
                                child: const Text('Select Date')),
                            SizedBox(width: 10.w),
                            Text('Date Format :', style: bodySmall),
                            SizedBox(
                              width: 90.w,
                              child: ElevatedButton(
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: Colors.transparent,
                                  ),
                                  onPressed: () {
                                    dateContainerKey.currentState
                                        ?.showFormatSelectionDateDialog();
                                  },
                                  child: const Text('Select Format',
                                      style: TextStyle(
                                          overflow: TextOverflow.ellipsis))),
                            ),
                          ],
                        ),
                        SizedBox(height: 20.h),
                        Row(
                          children: [
                            Text(
                              'Time :',
                              style: bodySmall,
                            ),
                            SizedBox(width: 10.w),
                            ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                    backgroundColor: Colors.transparent),
                                onPressed: () {
                                  dateContainerKey.currentState
                                      ?.showTimePickerDialog();
                                },
                                child: const Text('Select Time')),
                            SizedBox(width: 8.w),
                            Text(
                              'Time Format :',
                              style: bodySmall,
                            ),
                            SizedBox(
                              width: 85.w,
                              child: ElevatedButton(
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: Colors.transparent,
                                  ),
                                  onPressed: () {
                                    dateContainerKey.currentState
                                        ?.showFormatSelectionDialog();
                                  },
                                  child: const Text('Select Format',
                                      style: TextStyle(
                                          overflow: TextOverflow.ellipsis))),
                            )
                          ],
                        ),
                        SizedBox(height: 20.h),
                        Row(
                          children: [
                            Text(
                              'Automatic time selection :',
                              style: bodySmall,
                            ),
                            SizedBox(width: 10.w),
                            ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                    backgroundColor: Colors.transparent),
                                onPressed: () {},
                                child: const Text('Select Region'))
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            Container(
              padding: REdgeInsets.symmetric(horizontal: 15),
              height: 50,
              width: screenWidth,
              color: Colors.grey.shade300,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  TextButton(
                      onPressed: () {
                        setState(() {
                          showStyleContainer = !showStyleContainer;
                        });
                      },
                      child: Text(
                        'Style',
                        style: showStyleContainer
                            ? bodySmall.copyWith(color: Colors.redAccent)
                            : bodySmall,
                      ))
                ],
              ),
            )
          ],
        ),
      ),
    ]);
  }

  // show Emoji container
  Widget _showEmojiContainer(double screenWidth) {
    return Stack(children: [
      Container(
        padding: REdgeInsets.only(bottom: 30.h),
        //margin: REdgeInsets.only(top: 10.h),
        alignment: Alignment.topCenter,
        child: Image.asset('assets/icons/rectangle.png'),
      ),
      Container(
        width: screenWidth,
        decoration: BoxDecoration(
          color: const Color(0xff5DBCFF).withOpacity(0.13),
          borderRadius: BorderRadius.all(Radius.circular(13.w)),
        ),
        child: Column(
          children: [
            _buildOptionRow(
              [
                _buildIconButton('assets/icons/template.png', 'Template', () {
                  setState(() {
                    showEmojiWidget = true;
                    showEmojiContainerFlag = false;
                  });
                }),
                Image.asset('assets/images/line_c.png'),
                _buildTextIonButton('assets/icons/delete_icon.png', 'Delete',
                        () {
                      setState(() {
                        showEmojiWidget = false;
                        showEmojiContainerFlag = false;
                      });
                    }),
                _buildTextIonButton(
                    'assets/icons/multiple.png', 'Multiple', () {}),
                _buildTextIonButton('assets/icons/undo (2).png', 'Undo', () {}),
                _buildTextIonButton('assets/icons/redo.png', 'Redo', () {}),
              ],
            ),
            SizedBox(height: 20.h),
            Expanded(
              child: SingleChildScrollView(
                child: Container(
                  height: 210.h,
                  width: screenWidth,
                  color: Colors.white,
                  padding: REdgeInsets.symmetric(horizontal: 15),
                  child: Column(
                    children: [
                      Container(
                        height: 40,
                        width: double.infinity,
                        child: ListView.builder(
                          scrollDirection: Axis.horizontal,
                          itemCount: categories.length,
                          itemBuilder: (BuildContext context, int index) {
                            return ListViewItem(
                              email: categories[index],
                              selected: selectedCategory == categories[index],
                              onPressed: () {
                                setState(() {
                                  selectedCategory = categories[index];
                                  print(selectedCategory);
                                  print("Clicked animal");
                                });
                              },
                            );
                          },
                        ),
                      ),
                      SizedBox(height: 10.h),
                      if (selectedCategory.isNotEmpty)
                        Container(
                          height: 200,
                          width: double.infinity,
                          color: Colors.white,
                          child: FirestoreListView2(
                            data2: selectedCategory,
                            emails: emails,
                            imageUrls: imageUrls,
                          ),
                        ),
                    ],
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    ]);
  }

  // Print function
  printContent() async {
    final image = await convertWidgetToImage();

    if (image != null) {
      final imageData = await convertImageToData(image);
      if (imageData != null) {
        setState(() {
          this.imageData = imageData;
        });
        await sendBitmapToJava(imageData);
      }
    }
  }

  Future<ui.Image?> convertWidgetToImage() async {
    try {
      double imageZoomeIn = sdkPaperSizeWidth * 8 / getLabelWidth;
      RenderRepaintBoundary boundary =
      globalKey.currentContext!.findRenderObject() as RenderRepaintBoundary;

      ui.Image image = await boundary.toImage(pixelRatio: imageZoomeIn);
      return image;
    } catch (e) {
      print('Error capturing container convert to bitmap: $e');
      return null;
    }
  }

  Future<Uint8List?> convertImageToData(ui.Image image) async {
    try {
      ByteData? byteData =
      await image.toByteData(format: ui.ImageByteFormat.png);
      return byteData?.buffer.asUint8List();
    } catch (e) {
      print('Error converting image to data: $e');
      return null;
    }
  }

  Future<void> sendBitmapToJava(Uint8List bitmapData) async {
    try {
      final byteBuffer = bitmapData.buffer;
      final byteList = byteBuffer.asUint8List();
      await platform.invokeMethod('receiveBitmap', {'bitmapData': byteList});
      print('Bitmap data sent to Java');
    } catch (e) {
      print('Error sending bitmap data to Java: $e');
    }
  }

// Multiple Text Container function
  void generateTextCode() {
    setState(() {
      textCodes.add('Double click here ${textCodes.length + 1}');
      textCodeOffsets.add(Offset(0, (textCodes.length * 5).toDouble()));
    });
  }

  void deleteTextCode() {
    if (selectedTextCodeIndex != null) {
      setState(() {
        textCodes.removeAt(selectedTextCodeIndex);
        textCodeOffsets.removeAt(selectedTextCodeIndex);
        selectedTextCodeIndex = 0;
      });
    }
  }


  // Multiple BarCode Container function
  void generateBarCode() {
    setState(() {
      barCodes.add('1234 ${barCodes.length + 1}');
      barCodeOffsets.add(Offset(0, (barCodes.length * 5).toDouble()));
    });
  }

  void deleteBarCode() {
    print('barcode');
    print(selectedBarCodeIndex);
    if (selectedBarCodeIndex != null) {
      setState(() {
        barCodes.removeAt(selectedBarCodeIndex);
        barCodeOffsets.removeAt(selectedBarCodeIndex);
        selectedBarCodeIndex = 0;
      });
    }
  }

  // Multiple Qr container function
  void generateQRCode() {
    setState(() {
      qrCodes.add('5678 ${qrCodes.length + 1}');
      qrCodeOffsets.add(Offset(0, (qrCodes.length * 5).toDouble()));
    });
  }

  void deleteQRCode() {
    if (selectedQRCodeIndex != null) {
      setState(() {
        qrCodes.removeAt(selectedQRCodeIndex);
        qrCodeOffsets.removeAt(selectedQRCodeIndex);
        selectedQRCodeIndex = 0;
      });
    }
  }


  // Multiple Table container function
  void generateImageCode() {
    setState(() {
      imageCodes.add('Image ${imageCodes.length + 1}');
      imageOffsets.add(Offset(0, (imageCodes.length * 5).toDouble()));
    });
  }

  void deleteImageCode() {
    if (selectedImageCodeIndex != null) {
      setState(() {
        tableCodes.removeAt(selectedImageCodeIndex);
        tableOffsets.removeAt(selectedImageCodeIndex);
        selectedImageCodeIndex = 0;
      });
    }
  }


  // Multiple Table container function
  void generateTableCode() {
    setState(() {
      tableCodes.add('Table ${tableCodes.length + 1}');
      tableOffsets.add(Offset(0, (tableCodes.length * 5).toDouble()));
    });
  }

  void deleteTableCode() {
    if (selectedTableCodeIndex != null) {
      setState(() {
        tableCodes.removeAt(selectedTableCodeIndex);
        tableOffsets.removeAt(selectedTableCodeIndex);
        selectedTableCodeIndex = 0;
      });
    }
  }

  /* void addRow(int index) {
    print('Table Row');
    print(tableCodes.length);
    setState(() {
      controllers.insert(index, List.generate(
          controllers[0].length, (index) => TextEditingController()));
      editMode.insert(index, List.generate(controllers[0].length, (index) => false));
    });
  }

  void removeRow(int index) {
    if (controllers.length > 2) {
      setState(() {
        controllers.removeAt(index);
        editMode.removeAt(index);
      });
    }
  }

  void addColumn(int index) {
    setState(() {
      for (var row in controllers) {
        row.insert(index, TextEditingController());
      }
      for (var row in editMode) {
        row.insert(index, false);
      }
    });
  }

  void removeColumn(int index) {
    if (controllers[0].length > 2) {
      setState(() {
        for (var row in controllers) {
          row.removeAt(index);
        }
        for (var row in editMode) {
          row.removeAt(index);
        }
      });
    }
  }*/


  void _addRow() {
    if (selectedTableCodeIndex != null) {
      setState(() {
        print('add Row');
        tableDataList[selectedTableCodeIndex].controllers.add(
          List.generate(
            tableDataList[selectedTableCodeIndex].controllers[0].length,
                (index) => TextEditingController(),
          ),
        );
        tableDataList[selectedTableCodeIndex].editMode.add(
          List.generate(
            tableDataList[selectedTableCodeIndex].controllers[0].length,
                (index) => false,
          ),
        );
      });
    }
  }

  void _removeRow() {
    if (selectedTableCodeIndex != null) {
      setState(() {
        tableDataList[selectedTableCodeIndex].controllers.removeLast();
        tableDataList[selectedTableCodeIndex].editMode.removeLast();
      });
    }
  }

  void _addColumn() {
    if (selectedTableCodeIndex != null) {
      setState(() {
        for (var row in tableDataList[selectedTableCodeIndex].controllers) {
          row.add(TextEditingController());
        }
        for (var row in tableDataList[selectedTableCodeIndex].editMode) {
          row.add(false);
        }
      });
    }
  }

  void _removeColumn() {
    if (selectedTableCodeIndex != null) {
      setState(() {
        for (var row in tableDataList[selectedTableCodeIndex].controllers) {
          row.removeLast();
        }
        for (var row in tableDataList[selectedTableCodeIndex].editMode) {
          row.removeLast();
        }
      });
    }
  }


}

//Multiple Text  function variable
List<String> textCodes = [];
List<Offset> textCodeOffsets = [];
int selectedTextCodeIndex = 0;

//Multiple Text  function variable
List<String> barCodes = [];
List<Offset> barCodeOffsets = [];
int selectedBarCodeIndex = 0;

//Multiple qr  function variable
List<String> qrCodes = [];
List<double> qrcodeSizes = List.generate(qrCodes.length, (_) => qrcodeSize);
List<Offset> qrCodeOffsets = [];
int selectedQRCodeIndex = 0;
double qrcodeSize = 100.0;
double minQrcodeSize = 50.0;

//Multiple Table  function variable
List<String> tableCodes = ['Table 1', 'Table 2'];
List<Offset> tableOffsets = [Offset.zero, Offset(0, 100)];
int selectedTableCodeIndex = 0;

//Multiple Image  function variable
List<String> imageCodes = [];
List<Offset> imageOffsets = [];
int selectedImageCodeIndex = 0;




