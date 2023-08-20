import 'dart:async';
import 'package:expence_manager/signin/login.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'Screen/homeScreen.dart';
import 'modelclass.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSwatch(backgroundColor: Colors.blueAccent.shade400,primarySwatch: Colors.blue)
      ),
      title: 'Material App',
      home:SpalcScreen(),
    );
  }
}

//===================SpalcScreen====================

class SpalcScreen extends StatefulWidget {
  const SpalcScreen({Key? key}) : super(key: key);

  @override
  State<SpalcScreen> createState() => SpalcScreenState();
}

class SpalcScreenState extends State<SpalcScreen> {
  static const String spalc = "Spalc";
  static const String login = "Login";
  @override
  void initState() {
    // TODO: implement initState
    saved();
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
          body: Center(child: Image(image: AssetImage('assets/spalc1.jpeg'))),
    );
  }

  void saved() async {
    SharedPreferences pref1 = await SharedPreferences.getInstance();
    SharedPreferences pref = await SharedPreferences.getInstance();
    var Spalc = pref.getBool(spalc);
    var LogIn = pref1.getBool(login);
    if(Spalc != null && LogIn != null){
      if(Spalc && LogIn){
        Timer(Duration(milliseconds: 200), () => Navigator.pushReplacement(
            context, MaterialPageRoute(builder: (context) => HomeScreen())),);
      }
      else if(Spalc){
        Timer(Duration(milliseconds: 200), () => Navigator.pushReplacement(
            context, MaterialPageRoute(builder: (context) => LoginPage())),);
      }
      else{
        Timer(Duration(microseconds: 200), () => Navigator.pushReplacement(
            context, MaterialPageRoute(builder: (context) => CrovsolScreen())),);
      }
    }
    else{
      Timer(Duration(milliseconds: 200), () => Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (context) => CrovsolScreen())),);
    }
  }
}


//============CrovsolScreen================


class CrovsolScreen extends StatefulWidget {
  const CrovsolScreen({Key? key}) : super(key: key);

  @override
  State<CrovsolScreen> createState() => _CrovsolScreenState();
}

class _CrovsolScreenState extends State<CrovsolScreen> {
  List<model> listofmodel = [];
  int current =0;
  PageController _pagecontrol = PageController();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    listofmodel.add(model('assets/cashbook1.jpeg'));
    listofmodel.add(model('assets/cashbook2.jpeg'));
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomSheet:Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              for(int i=0;i<listofmodel.length;i++)...[
                Padding(
                  padding: EdgeInsets.all(10),
                  child: Container(
                    width: (current==i)? 12 : 6,
                    height: (current==i) ? 12 : 6,
                    decoration: BoxDecoration(color: (current==i)?Colors.blueAccent : Colors.grey,
                        borderRadius: BorderRadius.circular(10)),
                  ),
                ),
              ],
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              TextButton(onPressed: () async{
                setState(() {

                });
               SharedPreferences pref = await SharedPreferences.getInstance();
               pref.setBool(SpalcScreenState.spalc, true);
                current==listofmodel.length-1 ? Navigator.push(context, MaterialPageRoute(builder: (context) => LoginPage(),)) : 'skip<<' ;

                _pagecontrol.animateToPage(current+1, duration: Duration(seconds: 2), curve: Curves.linear);

              }, child: Text((current==listofmodel.length-1) ? 'Get Strated' : 'Next',style: TextStyle(fontWeight: FontWeight.bold,fontSize: 20),)),
            ],
          ),
        ],
      ),

      body: Center(
        child:  PageView.builder(
          itemCount: listofmodel.length,
          controller: _pagecontrol,
          onPageChanged: (value) {
            current = value ;
            setState(() {

            });
          },
          itemBuilder: (context, index) {
            return OtherScreen.pera(listofmodel[index]);
          },),
      ),
    );
  }
}

// ==================== other Screeen=============


class OtherScreen extends StatefulWidget {
  OtherScreen({Key? key}) : super(key: key);

  model? obj;
  OtherScreen.pera(this.obj);
  @override
  State<OtherScreen> createState() => _OtherScreenState(obj!);
}

class _OtherScreenState extends State<OtherScreen> {
  model? obj;
  _OtherScreenState(this.obj);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Image(image: AssetImage('${obj!.img}'),fit: BoxFit.fill,),
        ],
      ),
    );
  }
}



