import 'package:flutter/material.dart';
import 'dart:math' as math;
import 'package:google_fonts/google_fonts.dart';
import 'package:shoe_app/model/shoe_details_model.dart';
import 'package:shoe_app/model/shoe_showcase_model.dart';
import 'package:shoe_app/view/shoe_showcase.dart';
//import 'package:shoe_app/view/shoe_showcasetest.dart';
import 'package:simple_shadow/simple_shadow.dart';
import 'package:shoe_app/utils/shoe_brands.dart';
import 'package:page_transition/page_transition.dart';
void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
          scaffoldBackgroundColor: const Color(0xffECEDF1),
          backgroundColor: Colors.white,
          iconTheme: const IconThemeData(color: Colors.black, size: 30),
          primaryIconTheme: const IconThemeData(color: Colors.white, size: 30),
          textTheme: TextTheme(
            headline1: GoogleFonts.lato(
                fontSize: 97, fontWeight: FontWeight.w300, letterSpacing: -1.5),
            headline2: GoogleFonts.lato(
                fontSize: 61, fontWeight: FontWeight.w300, letterSpacing: -0.5),
            headline3: GoogleFonts.lato(
                fontSize: 48, fontWeight: FontWeight.w400),
            headline4: GoogleFonts.lato(
                fontSize: 34, fontWeight: FontWeight.w400, letterSpacing: 0.25),
            headline5: GoogleFonts.lato(
                fontSize: 24, fontWeight: FontWeight.w400),
            headline6: GoogleFonts.lato(
                fontSize: 20, fontWeight: FontWeight.w500, letterSpacing: 0.15),
            subtitle1: GoogleFonts.lato(
                fontSize: 16, fontWeight: FontWeight.w400, letterSpacing: 0.15),
            subtitle2: GoogleFonts.lato(
                fontSize: 14, fontWeight: FontWeight.w500, letterSpacing: 0.1),
            bodyText1: GoogleFonts.lato(
                fontSize: 16, fontWeight: FontWeight.w400, letterSpacing: 0.5),
            bodyText2: GoogleFonts.lato(
                fontSize: 14, fontWeight: FontWeight.w400, letterSpacing: 0.25),
            button: GoogleFonts.lato(
                fontSize: 14, fontWeight: FontWeight.w500, letterSpacing: 1.25),
            caption: GoogleFonts.lato(
                fontSize: 12, fontWeight: FontWeight.w400, letterSpacing: 0.4),
            overline: GoogleFonts.lato(
                fontSize: 10, fontWeight: FontWeight.w400, letterSpacing: 1.5),
          )),
      home: const HomeScreen(),
    );
  }
}

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  Color tabSelectColor = Colors.white;
  int tabIndex = 0;



//Function to select top tab

  void _selectTopColor(index) {
    setState(() {
      tabIndex = index;
    });
     print(nikeAirMax97[0]);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(
      //   elevation: 0,
      //   backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      //   leading: Icon(
      //     Icons.menu,
      //     color: Theme.of(context).iconTheme.color,
      //     size: Theme.of(context).iconTheme.size,
      //   ),
      //   actions: [
      //     Container(
      //       margin: const EdgeInsets.only(
      //         right: 10,
      //       ),
      //       height: 100,
      //       width: 50,
      //       decoration: BoxDecoration(
      //         borderRadius: BorderRadius.circular(15),
      //         color: Colors.black,
      //       ),
      //     )
      //   ],
      // ),
      body:Container(

        padding: const EdgeInsets.only(left: 20, top: 0,  right:  20, bottom: 60),
        child: CustomScrollView(
          
          //  scrollDirection: Axis.vertical,
            clipBehavior: Clip.none,
         
            slivers: [
  
                sliverAppBar(),


               shoeBrandList(),
               
              const   SliverToBoxAdapter(
                   child: SizedBox( height: 30,),
                 ),
             
              shoeGrid()
            ],
          ),
      ),
      
    );
  }

  // Shoe brand listview

  Widget shoeBrandList() {
    return SliverToBoxAdapter(
      child: Container(
        height: 50,
        child: ListView.builder(
            itemCount: shoeBrands.length,
            scrollDirection: Axis.horizontal,
            itemBuilder: ((context, index) {
              return GestureDetector(
                onTap: () {
                  _selectTopColor(index);
                 
                },
                child: AnimatedContainer(
                  curve: Curves.easeIn,
                  duration: const Duration(milliseconds: 500),
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  margin: const EdgeInsets.symmetric(horizontal: 10),
                  height: 50,
                  width: 100,
                  child: Center(
                      child: Text(
                    shoeBrands[index],
                    style: TextStyle(
                        color: tabIndex == index ? Colors.white : Colors.black,
                        fontWeight: tabIndex == index
                            ? FontWeight.w900
                            : FontWeight.normal),
                  )),
                  decoration: BoxDecoration(
                      color: tabIndex == index ? Colors.black : Colors.white,
                      borderRadius: BorderRadius.circular(15)),
                ),
              );
            })),
      ),
    );
  }

//GridView Widget

  Widget shoeGrid() {
    return 
         SliverGrid(

           
           
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                childAspectRatio: 1 / 1.5,
                crossAxisSpacing: 20,
                mainAxisSpacing: 20),
           delegate:  SliverChildBuilderDelegate(

             
             
             (context, index) {
               return GestureDetector(


                  onTap: () => Navigator.push(context, PageTransition(
                        
                      alignment: Alignment.bottomCenter,
                      curve: Curves.bounceIn,
                      duration: const Duration(milliseconds: 600),
                      type: PageTransitionType.fade,
                      child: ShoeShowCase(index),
                      
                        
                        )),

                 child: Stack(
                   
                   
                   clipBehavior: Clip.none,
                   
                    children: [
                 
                   
                   Container(
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(20)),
                    ),
                             
                  Positioned(
                    top: -50,
                    right: -15,
                    child: shoetweenAnimationBuilder(
                      isText: false,
                      tween: Tween<double>(begin: 0, end: 1),
                      duration:  Duration(milliseconds: 800 + (index * 500)),
                      child: Transform.rotate(
                          angle: -math.pi / 12.0,
                          child: SimpleShadow(
                            opacity: 0.4, // Default: 0.5
                            color: Colors.black, // Default: Black
                            offset: const Offset(5, 10), // Default: Offset(2, 2)
                            sigma: 10,
                           
                              child: Image(
                                height: 200,
                                width: 200,
                                image: AssetImage(shoeModel[index].img!),
                                fit: BoxFit.cover,
                              ),
                            ),
                          )),
                    
                  ),
                  Positioned(
                    bottom: 40,
                    left: 20,
                    child: shoetweenAnimationBuilder(
                      isText: true,
                      tween: Tween<double>(begin: 0, end: 1),
                      duration: Duration(milliseconds: 1000 + (index * 500)),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            width: 120,
                            child: Text(
                              shoeModel[index].name!,
                              style: const TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 12),
                            ),
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          Text(shoeModel[index].price!,
                              style: const TextStyle(
                                  fontWeight: FontWeight.w900,
                                  fontSize: 18,
                                  color: Colors.black)),
                        ],
                      ),
                    ),
                  )
                             ]),
               );

           },
           
           childCount: shoeModel.length
           
           
           )
            
            );
  }

  //animate top bar individual items on screen refresh

  Widget tweenAnimationBuilder(Tween tween, Duration duration, Widget child) {
    return TweenAnimationBuilder<dynamic>(
        child: child,
        tween: tween,
        duration: duration,
        builder: (BuildContext context, dynamic val, child) {
          return Opacity(opacity: val, child: child!);
        });
  }

  //animate top bar individual items on screen refresh

  Widget shoetweenAnimationBuilder(
      {required Tween tween,
      required Duration duration,
      required Widget child,
      required bool isText,
      
      }) {
    return TweenAnimationBuilder<dynamic>(
        child: child,
        tween: tween,
        duration: duration,
        builder: (BuildContext context, dynamic val, child) {
          return Opacity(
              opacity: val,
              child: Padding(
                  padding: isText == true ? EdgeInsets.only(left: val * 5): EdgeInsets.only(top: val * 25), child: child!)
                  
                  );
        });
  }


  // sliver App bar


  Widget sliverAppBar () {


     return   SliverAppBar(

      
        pinned: false,
        snap: true,
       floating: true,
       expandedHeight: 80.0,
       elevation:  0,

       backgroundColor:  Theme.of(context).scaffoldBackgroundColor,
       foregroundColor: Colors.black,
          
           leading:const Icon(
          Icons.menu,
          color: Colors.black,
          size: 30
        ), 
 
 actions: [

  // const Icon(Icons.search),
  Stack(
    
    alignment: Alignment.center,
    
    children:const  [
    
    Icon(Icons.notifications_none_outlined)]
    
    )
 ],
     );
  }
}


