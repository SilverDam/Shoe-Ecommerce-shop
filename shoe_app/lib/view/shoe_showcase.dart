

import 'package:flutter/material.dart';
import 'dart:math' as math;
import 'package:shoe_app/model/shoe_details_model.dart';
import 'package:shoe_app/model/shoe_showcase_model.dart';
import 'package:shoe_app/widgets/button.dart';
import 'package:simple_shadow/simple_shadow.dart';

class ShoeShowCase extends StatefulWidget {
  final int index;

  const ShoeShowCase(this.index, {Key? key}) : super(key: key);

  @override
  State<ShoeShowCase> createState() => _ShoeShowCaseState();
}

class _ShoeShowCaseState extends State<ShoeShowCase>
    with TickerProviderStateMixin {
  late AnimationController _controller;
  late AnimationController _iconcontroller;
  late Animation _rotation;
  late Animation _rotationTween;
  late Animation _colorAnimation;
  late Animation _scaleAnimation;
  late Animation _curve;
  late Animation _colorcurve;
  late Animation _opacityAnimation;
  bool isComplete = false;
  double scaleSize = 30;
  double opacityChange = 0.9;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    _controller = AnimationController(
        duration: const Duration(milliseconds: 10000), vsync: this);

    _iconcontroller = AnimationController(
        duration: const Duration(milliseconds: 1000), vsync: this);

    _colorcurve =
        CurvedAnimation(parent: _iconcontroller, curve: Curves.easeInQuart);


        _opacityAnimation = TweenSequence(<TweenSequenceItem<double>>[
      TweenSequenceItem<double>(
          tween: Tween<double>(begin: 0, end: 1), weight: 50),
      TweenSequenceItem<double>(
          tween: Tween<double>(begin: 1, end: 0), weight: 50),
    ]).animate(_colorcurve as dynamic);

    _scaleAnimation = Tween<double>(begin: 0, end:  200).animate(_colorcurve as dynamic);

    _colorAnimation = ColorTween(begin: Colors.grey, end: Colors.red)
        .animate(_colorcurve as dynamic);

    _curve = CurvedAnimation(parent: _controller, curve: Curves.bounceInOut);
    _rotation = Tween<double>(begin: 0, end: 1).animate(_controller as dynamic);

    _rotationTween = TweenSequence(<TweenSequenceItem<double>>[
      TweenSequenceItem<double>(
          tween: Tween<double>(begin: 0, end: 1), weight: 50),
      TweenSequenceItem<double>(
          tween: Tween<double>(begin: 1, end: 0), weight: 50)
    ]).animate(_curve as dynamic);

    _iconcontroller.addListener(() {});
    _iconcontroller.addStatusListener((status) {});

    _controller.repeat();

    _iconcontroller.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        setState(() {
          isComplete = true;
        });
      } else if (status == AnimationStatus.dismissed) {
        isComplete = false;
      }
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    _iconcontroller.dispose();
    super.dispose();
  }

  //change colorPicker Animatio1

  void changeColorBox() {
    setState(() {
      opacityChange = 0.9;
      scaleSize = 30;
    });
  }

// get page index

  int pageIndex = 0;

  void getPageIndex(int index) {
    setState(() {
      pageIndex = index;
    });
  }

// select shoe size

  Color color = Colors.transparent;

  //change Selected Size Color
  int selectedIndex = 0;

  void selectSize(index) {
    setState(() {
      selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        foregroundColor: Colors.black,
        elevation: 0,
      ),
      body: Stack(
        children: [
          showPageView(),
          Positioned(
              left: 10,
              bottom: MediaQuery.of(context).size.height * 0.5,
              child: Column(
                children: colorGenerator(),
              )),
          Positioned(
              bottom: MediaQuery.of(context).size.height * 0.2,
              left: MediaQuery.of(context).size.width * 0.13,
              child: shoeSize()),
          Positioned(
              bottom: MediaQuery.of(context).size.height * 0.13,
              left: MediaQuery.of(context).size.width * 0.13,
              child: favorite()),
          Positioned(
            top: 10,
            left: 20,
              child: Container(

                width: MediaQuery.of(context).size.width * 0.5,
                child: Text(
            shoeModel[widget.index].name!,
            style: const TextStyle(fontWeight: FontWeight.w900, fontSize: 20),
          ),
              )),


              Positioned (
                
                  bottom: MediaQuery.of(context).size.height * 0.6,
                 left: MediaQuery.of(context).size.width * 0.30,
                
                
                child: iconAnimate()
              
              )
        ],
      ),
    );
  }
  //Page View Builder

  Widget showPageView() {
    return GestureDetector(



      onTap:    () {
                    isComplete == true
                        ? _iconcontroller.reverse()
                        : _iconcontroller.forward();
                  },
      child: PageView.builder(
          onPageChanged: (val) {
            getPageIndex(val);
            changeColorBox();
          },
          scrollDirection: Axis.vertical,
          itemCount: shoeModel[widget.index].name == "Nike Air Force 1"
              ? nikeAirForce.length
              : shoeModel[widget.index].name == "Nike Air Max 90"
                  ? nikeAirMax90.length
                  : shoeModel[widget.index].name == "Nike Air Max 97"
                      ? nikeAirMax97.length
                      : shoeModel[widget.index].name ==
                              "Nike Air Vapormax 2021 FK"
                          ? nikeAirMaxVapor2021Fk.length
                          : shoeModel[widget.index].name ==
                                  "Nike Air Vapormax Plus1"
                              ? nikeAirMaxVaporPlus.length
                              : shoeModel[widget.index].name == "Zoom Freak 3"
                                  ? zoomFreak.length
                                  : 1,
          itemBuilder: ((context, index) => shoeColors(index))),
    );
  }

// Page view items

  Widget shoeColors(index) {
    return AnimatedBuilder(
      animation: _rotationTween,
      builder: (BuildContext context, _) {
        return 
           Transform.rotate(
              angle: _rotationTween.value,
              child: SimpleShadow(
                  opacity: 0.4, // Default: 0.5
                  color: Colors.black, // Default: Black
                  offset: const Offset(5, 10), // Default: Offset(2, 2)
                  sigma: 10,
                  child: Image(
                      height: 400,
                      width: 400,
                      image: shoeModel[widget.index].name == "Nike Air Force 1"
                          ? AssetImage(nikeAirForce[index].img)
                          : shoeModel[widget.index].name == "Nike Air Max 90"
                              ? AssetImage(nikeAirMax90[index].img)
                              : shoeModel[widget.index].name == "Nike Air Max 97"
                                  ? AssetImage(nikeAirMax97[index].img)
                                  : shoeModel[widget.index].name ==
                                          "Nike Air Vapormax 2021 FK"
                                      ? AssetImage(
                                          nikeAirMaxVapor2021Fk[index].img)
                                      : shoeModel[widget.index].name ==
                                              "Nike Air Vapormax Plus1"
                                          ? AssetImage(
                                              nikeAirMaxVaporPlus[index].img)
                                          : shoeModel[widget.index].name ==
                                                  "Zoom Freak 3"
                                              ? AssetImage(zoomFreak[index].img)
                                              : const AssetImage(
                                                  'asset/images/nikelogo.png',
                                                ),
                      fit: BoxFit.cover,
                    ),
                  ),
        );
      },
    );
  }

  // generate color list
  List<Widget> colorGenerator() {
    return List.generate(
        shoeModel[widget.index].name == "Nike Air Force 1"
            ? nikeAirForce.length
            : shoeModel[widget.index].name == "Nike Air Max 90"
                ? nikeAirMax90.length
                : shoeModel[widget.index].name == "Nike Air Max 97"
                    ? nikeAirMax97.length
                    : shoeModel[widget.index].name ==
                            "Nike Air Vapormax 2021 FK"
                        ? nikeAirMaxVapor2021Fk.length
                        : shoeModel[widget.index].name ==
                                "Nike Air Vapormax Plus1"
                            ? nikeAirMaxVaporPlus.length
                            : shoeModel[widget.index].name == "Zoom Freak 3"
                                ? zoomFreak.length
                                : 0,
        (index) => Padding(
              padding: const EdgeInsets.all(8.0),
              child: AnimatedOpacity(
                duration: const Duration(milliseconds: 300),
                opacity: pageIndex == index ? opacityChange : 0.8,
                child: AnimatedContainer(
                  curve: Curves.easeIn,
                  duration: const Duration(milliseconds: 500),
                  height: pageIndex == index ? scaleSize : 10,
                  width: pageIndex == index ? scaleSize : 10,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(5),
                      color: shoeModel[widget.index].name == "Nike Air Force 1"
                          ? nikeAirForce[index].color
                          : shoeModel[widget.index].name == "Nike Air Max 90"
                              ? nikeAirMax90[index].color
                              : shoeModel[widget.index].name ==
                                      "Nike Air Max 97"
                                  ? nikeAirMax97[index].color
                                  : shoeModel[widget.index].name ==
                                          "Nike Air Vapormax 2021 FK"
                                      ? nikeAirMaxVapor2021Fk[index].color
                                      : shoeModel[widget.index].name ==
                                              "Nike Air Vapormax Plus1"
                                          ? nikeAirMaxVaporPlus[index].color
                                          : shoeModel[widget.index].name ==
                                                  "Zoom Freak 3"
                                              ? zoomFreak[index].color
                                              : Colors.transparent),
                ),
              ),
            ));
  }

  //show size grid

  Widget shoeSize() {
    List<double> shoeSizes = [
      6,
      6.5,
      7,
      7.5,
      8,
      8.5,
      9,
      9.5,
      10,
      10.5,
      11,
      11.5,
      12,
      12.5,
      13,
      14,
      15,
      16
    ];

    return Container(
      height: MediaQuery.of(context).size.height * 0.2,
      width: MediaQuery.of(context).size.height * 0.35,
      child: GridView.count(
        //scrollDirection: ScrollPhysics,

        crossAxisSpacing: 18,
        mainAxisSpacing: 18,
        crossAxisCount: 6,

        children: List.generate(
            shoeSizes.length,
            (index) => GestureDetector(
                  onTap: () {
                    selectSize(index);
                    print(selectedIndex);
                  },
                  child: AnimatedContainer(
                    curve: Curves.easeIn,
                    duration: const Duration(milliseconds: 300),
                    child: Center(
                      child: Text(
                        '${shoeSizes[index]}',
                        style: selectedIndex == index
                            ? const TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold)
                            : const TextStyle(color: Colors.black),
                      ),
                    ),
                    decoration: BoxDecoration(
                        color: selectedIndex == index ? Colors.black : color,
                        borderRadius: BorderRadius.circular(5),
                        border: Border.all(color: Colors.black, width: 1)),
                  ),
                )),
      ),
    );
  }

  //Button and favorite Icon

  Widget favorite() {
    return Container(
      width: MediaQuery.of(context).size.height * 0.35,
      child: Row(
        children: [
          Expanded(
              child: button(
                  context,
                  'Order Now',
                  Colors.black,
                  const Text(
                    'Order Now',
                    style: TextStyle(
                        color: Colors.white, fontWeight: FontWeight.bold),
                  ))),
           
        
        ],
      ),
    );
  }




  Widget iconAnimate () {

     return   AnimatedBuilder(
            animation: _iconcontroller,
            builder: (context, _) {
              return Opacity(

                opacity: _opacityAnimation.value,
                child: IconButton(
                    onPressed: null,
                    icon: Icon(
                      Icons.favorite,
                      color: Colors.red,
                      size: _scaleAnimation.value,
                    )),
              );
            },
          );
  }
}
