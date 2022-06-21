import 'dart:math';
import 'dart:ui';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:fun_with_tribology/constants.dart';
import 'package:get/get.dart';
import 'package:image/image.dart' as image;
import 'dart:async';

// ignore_for_file: prefer_const_constructors

class PuzzleGame extends StatefulWidget {
  const PuzzleGame({Key? key}) : super(key: key);

  static String id = 'puzzle_game';

  @override
  State<PuzzleGame> createState() => _PuzzleGameState();
}

class _PuzzleGameState extends State<PuzzleGame> {
  //this is the default value for the slider
  double valueSlider = 2;

  GlobalKey<_SlidePuzzleWidgetState> globalKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    double _border = 5;
    return Scaffold(
      body: SafeArea(
        child: KScreenDecoration(
          decorationChild: Container(
            child: Column(
              children: [
                //here I will setup two rows 1 for puzzle and the other for slider

                Container(
                  margin: EdgeInsets.symmetric(vertical: 20.0),
                  child: Text(
                    'Puzzle Grid ${valueSlider.toInt()} X ${valueSlider.toInt()}',
                    style: TextStyle(
                      fontSize: 30.0,
                      color: Colors.white,
                    ),
                  ),
                ),
                Container(
                  decoration: BoxDecoration(
                    border: Border.all(width: _border, color: Colors.white),
                    color: Colors.red,
                  ),
                  child: LayoutBuilder(
                    builder: (context, constraints) {
                      return Container(
                        width: constraints.biggest.width,
                        // height: constraints.biggest.width,

                        //here will be the puzzle widget
                        child: SlidePuzzleWidget(
                          key: globalKey,
                          size: constraints.biggest,
                          imageBackGround: Image(
                            image: AssetImage('images/shoaib.png'),
                          ),
                          sizePuzzle: valueSlider.toInt(),
                        ),
                      );
                    },
                  ),
                ),
                Container(
                  child: Slider(
                    min: 2,
                    max: 11,
                    divisions: 10,
                    label: '${valueSlider.toInt().toString()}',
                    onChanged: (double value) {
                      setState(() {
                        valueSlider = value.toPrecision(0);
                        print(valueSlider);
                      });
                    },
                    value: valueSlider,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

//Stateful widget to create the puzzle
class SlidePuzzleWidget extends StatefulWidget {
  const SlidePuzzleWidget({
    Key? key,
    required this.size,
    this.innerPadding = 5,
    required this.imageBackGround,
    required this.sizePuzzle,
  }) : super(key: key);
  final Size size;

  //set inner padding
  final double innerPadding;

  //set image use for background
  final Image imageBackGround;
  final int sizePuzzle;

  @override
  State<SlidePuzzleWidget> createState() => _SlidePuzzleWidgetState();
}

class _SlidePuzzleWidgetState extends State<SlidePuzzleWidget> {
  final GlobalKey _globalKey = GlobalKey();
  late Size size;

  //list array slide object
  List? slideObjects;

  //image load with render
  image.Image? fullImage;

  //successFlag
  bool success = false;

  //flag already start slide

  //flag already start slide
  bool startSlide = false;

  //check current swap process for reverse checking
  late List<int> process;

  @override
  Widget build(BuildContext context) {
    size = Size(widget.size.width - widget.innerPadding * 2,
        widget.size.width - widget.innerPadding);
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        // need two column children one for the image and the other for the buttons
        Container(
          padding: EdgeInsets.all(widget.innerPadding),
          width: widget.size.width,
          height: widget.size.width,
          decoration: BoxDecoration(color: Colors.white),
          alignment: Alignment.center,
          child: Stack(
            children: [
              // we use stack stack our background & puzzle box
              // 1st show image use

              if (widget.imageBackGround != null && slideObjects == null) ...[
                RepaintBoundary(
                  key: _globalKey,
                  child: Container(
                    padding: EdgeInsets.all(10),
                    color: Colors.green,
                    height: double.maxFinite,
                    child: widget.imageBackGround,
                  ),
                )
              ],
              // 2nd show puzzle with empty
              if (slideObjects != null)
                ...slideObjects!.where((slideObject) => slideObject.empty).map(
                  (slideObject) {
                    return Positioned(
                      left: slideObject.posCurrent.dx,
                      top: slideObject.posCurrent.dy,
                      child: SizedBox(
                        width: slideObject.size.width,
                        height: slideObject.size.height,
                        child: Container(
                          alignment: Alignment.center,
                          margin: EdgeInsets.all(2),
                          color: Colors.transparent,
                          child: Stack(
                            children: [
                              if (slideObject.image != null) ...[
                                Opacity(
                                  opacity: success ? 1 : 0.0,
                                  child: slideObject.image,
                                )
                              ]
                            ],
                          ),
                        ),
                      ),
                    );
                  },
                ).toList(),
              // this for box with not empty flag
              if (slideObjects != null)
                ...slideObjects!.where((slideObject) => !slideObject.empty).map(
                  (slideObject) {
                    // change to animated position
                    // disabled checking success on swap process
                    return AnimatedPositioned(
                      duration: Duration(milliseconds: 200),
                      curve: Curves.ease,
                      left: slideObject.posCurrent.dx,
                      top: slideObject.posCurrent.dy,
                      child: GestureDetector(
                        onTap: () {
                          changePos(slideObject.indexCurrent);
                        }, //changePos(slideObject.indexCurrent),
                        child: SizedBox(
                          width: slideObject.size.width,
                          height: slideObject.size.height,
                          child: Container(
                            alignment: Alignment.center,
                            margin: EdgeInsets.all(2),
                            color: Colors.blue,
                            child: Stack(
                              children: [
                                if (slideObject.image != null) ...[
                                  slideObject.image
                                ],
                                Center(
                                  child: Text(
                                    "${slideObject.indexDefault}",
                                    style: TextStyle(fontSize: 30.0),
                                  ),
                                ),

                                //
                              ],
                            ),
                            // nice one
                          ),
                        ),
                      ),
                    );
                  },
                ).toList()

              // now not show at all because we dont generate slideObjects yet.. lets generate
            ],
          ),
        ),

        Container(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: ElevatedButton(
                  onPressed: () {
                    generatePuzzle();
                  },
                  child: Text('Generate'),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: ElevatedButton(
                  onPressed: () {
                   startSlide?null:()=>  reversePuzzle();
                  },
                  child: Text('Reverse'),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: ElevatedButton(
                  onPressed: () {
                    clearPuzzle();
                  },
                  child: Text('Clear'),
                ),
              ),
            ],
          ),
        )
      ],
    );
  }

  //setup method use
//get render image
//same as puzzle method as before

  _getImageFromWidget() async {
    RenderRepaintBoundary? boundary =
        _globalKey.currentContext!.findRenderObject() as RenderRepaintBoundary?;

    size = boundary!.size;
    var img = await boundary.toImage();
    var byteData = await img.toByteData(format: ImageByteFormat.png);
    var pngBytes = byteData!.buffer.asUint8List();

    return image.decodeImage(pngBytes);
  }

  //method to generate the puzzle
  generatePuzzle() async {
    if (widget.imageBackGround != null && this.fullImage == null)
      this.fullImage = await _getImageFromWidget();
    print(this.fullImage!.width);

    //calculate box size for each puzzle
    Size sizeBox =
        Size(size.width / widget.sizePuzzle!, size.width / widget.sizePuzzle!);

    //here i will generate box puzzle

    slideObjects =
        List.generate(widget.sizePuzzle! * widget.sizePuzzle!, (index) {
      Offset offsetTemp = Offset(index % widget.sizePuzzle! * sizeBox.width,
          index ~/ widget.sizePuzzle! * sizeBox.height);

      image.Image? tempCrop;
      if (widget.imageBackGround != null && this.fullImage != null)
        tempCrop = image.copyCrop(
          fullImage!,
          offsetTemp.dx.round(),
          offsetTemp.dy.round(),
          sizeBox.width.round(),
          sizeBox.height.round(),
        );

      Uint8List bytesTempCrop = Uint8List.fromList(image.encodePng(tempCrop!));

      return SlideObject(
        posCurrent: offsetTemp,
        posDefault: offsetTemp,
        indexCurrent: index,
        indexDefault: index + 1,
        size: sizeBox,
        image: tempCrop! == null
            ? null
            : Image.memory(
                bytesTempCrop,
                fit: BoxFit.contain,
              ),
        empty: false,
      );
    });

    slideObjects?.last.empty = true;


    startSlide = false;
    setState((){});

    //swap block place
    //swap true we swap horizontal line, false we swap vertical

    bool swap = true;
    // setState((){});
    // return;

    process = [];

    //size puzzle shuffle
    for (var i = 0; i < widget.sizePuzzle * 20; i++) {
      for (var j = 0; j < widget.sizePuzzle/2; j++) {
        SlideObject slideObjectEmpty = getEmptyObject();

        int emptyIndex = slideObjectEmpty.indexCurrent;

        process.add(emptyIndex);

        int randKey;

        if (swap) {
          //horizontal swap

          int row = emptyIndex ~/ widget.sizePuzzle;
          randKey =
              row * widget.sizePuzzle + new Random().nextInt(widget.sizePuzzle);
        } else {
          int col = emptyIndex % widget.sizePuzzle;
          randKey =
              widget.sizePuzzle * new Random().nextInt(widget.sizePuzzle) + col;
        }

        changePos(randKey);

        swap = !swap;
      }
    }

   // startSlide = false;
    setState((){});
    //generating random image

    //get empty slide object form list
  }

  SlideObject getEmptyObject() {
    return slideObjects?.firstWhere((element) => element.empty);
  }

  changePos(int indexCurrent) {
    SlideObject slideObjectEmpty = getEmptyObject();

    // get index of empty slide object

    int emptyIndex = slideObjectEmpty.indexCurrent;

    // min and max index based on vertical or horizontal

    int minIndex = min(indexCurrent, emptyIndex);
    int maxIndex = max(indexCurrent, emptyIndex);

    //temp list moves involve

    List<SlideObject>? rangeMoves = [];

    //check if current index from vertical/horizontal side

    if (indexCurrent % widget.sizePuzzle == emptyIndex % widget.sizePuzzle) {
      //same vertical line

      rangeMoves = slideObjects!
          .where((element) =>
              element.indexCurrent % widget.sizePuzzle ==
              indexCurrent % widget.sizePuzzle)
          .cast<SlideObject>()
          .toList();
    } else if (indexCurrent ~/ widget.sizePuzzle ==
        emptyIndex ~/ widget.sizePuzzle) {
      rangeMoves = slideObjects!.cast<SlideObject>();
    } else {
      rangeMoves = [];
    }

    rangeMoves = rangeMoves
        .where((puzzle) =>
            puzzle.indexCurrent >= minIndex &&
            puzzle.indexCurrent <= maxIndex &&
            puzzle.indexCurrent != emptyIndex)
        .toList();

    //check empty Index under or above current touch

    if (emptyIndex < indexCurrent)
      rangeMoves.sort((a, b) => a.indexCurrent < b.indexCurrent ? 1 : 0);
    else
      rangeMoves.sort((a, b) => a.indexCurrent < b.indexCurrent ? 0 : 1);

    //check if rangeMoves is exist then proceed swap position

    if (rangeMoves.length > 0) {
      int tempIndex = rangeMoves[0].indexCurrent;

      Offset tempPos = rangeMoves[0].posCurrent;
      for (var i = 0; i < rangeMoves.length - 1; i++) {
        rangeMoves[i].indexCurrent = rangeMoves[i + 1].indexCurrent;
        rangeMoves[i].posCurrent = rangeMoves[i + 1].posCurrent;
      }

      rangeMoves.last.indexCurrent = slideObjectEmpty.indexCurrent;
      rangeMoves.last.posCurrent = slideObjectEmpty.posCurrent;

      slideObjectEmpty.indexCurrent = tempIndex;
      slideObjectEmpty.posCurrent = tempPos;
    }

    //
    if (slideObjects!
            .where((slideObject) =>
                slideObject.indexCurrent == slideObject.indexDefault - 1)
            .length ==
        slideObjects!.length&&!startSlide) {
      print('success');
      success = true;
    } else {
      success = false;
    }

    setState(() {});
  }

  void clearPuzzle() {
    startSlide = true;
    slideObjects = null;
    setState(() {});
  }

  Future<void> reversePuzzle() async {
    startSlide = true;
    setState(() {});

    await Stream.fromIterable(process.reversed)
        .asyncMap(
          (event) async => await Future.delayed(
            Duration(microseconds: 50),
          ).then(
            (value) => changePos(event),
          ),
        )
        .toList();


    process = [];
    setState((){});
  }
}

// here will be the class use
class SlideObject {
  // setup offset for default/ current position
  Offset posDefault;
  Offset posCurrent;

  //setup index for default/current position

  int indexDefault;
  int indexCurrent;

  //status box

  bool empty = false;

  //size each box
  Size size;

  //Image field for the crop later

  Image? image;

  SlideObject({
    required this.empty,
    required this.image,
    required this.indexDefault,
    required this.posCurrent,
    required this.posDefault,
    required this.size,
    required this.indexCurrent,
  });
}
