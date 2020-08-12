import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);
  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> with TickerProviderStateMixin {
  AnimationController animationController0,animationController1;
  Animation<double>animation1,animation2;
  @override
  void initState(){
    super.initState();
    //(1)
    animationController0 = AnimationController(vsync:this, duration:Duration(milliseconds : 500));
    animationController1 = AnimationController(vsync:this, duration:Duration(milliseconds : 500));
    animation1 = Tween(begin:1.0, end:0.0).animate(animationController0);
    animation2 = Tween(begin:1.0, end:0.0).animate(animationController1);

  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child:Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            AnimatedBuilder(
                animation:animationController0,
                builder : (context, child)
                {
                  return Container(
                    height : 32 * animation1.value,
                    width : 128 * animation1.value,
                    color : Colors.red,
                  );
                }
            ),
            AnimatedBuilder(
                animation:animationController1,
                builder : (context, child)
                {
                  return Container(
                    height :32 * animation2.value ,
                    width : 128 * animation2.value ,
                    color : Colors.orange,
                  );
                }
            ),
            RaisedButton(
              child:Text('start'),
              onPressed: (){
                animationController0.forward();
                animationController1.forward();
                animationController0.addStatusListener(
                        (AnimationStatus status){
                      if(status == AnimationStatus.completed)
                        animationController0.reverse();
                      if(status == AnimationStatus.dismissed)
                        animationController0.forward();
                    });
                animationController1.addStatusListener(
                        (AnimationStatus status){
                      if(status == AnimationStatus.completed)
                        animationController1.reverse();
                      if(status == AnimationStatus.dismissed)
                        animationController1.forward();


                    });
              },
            ),
            RaisedButton(
              child:Text('stop'),
              onPressed: (){
                animationController1.addStatusListener(
                        (AnimationStatus status){
                      if(status == AnimationStatus.completed)//0.0까지 갔을 때
                        animationController0.stop();
                      if(status == AnimationStatus.dismissed)//1.0으로 갔을때
                        animationController1.stop();
                    });
                animationController0.addStatusListener(
                        (AnimationStatus status){
                      if(status == AnimationStatus.completed)//0.0까지 갔을 때
                        animationController0.stop();
                      if(status == AnimationStatus.dismissed)//1.0으로 갔을때
                        animationController1.stop();
                    });
                animationController1.addStatusListener(
                        (AnimationStatus status){
                      if(status == AnimationStatus.completed)
                        animationController0.stop();
                    });
                animationController0.addStatusListener(
                        (AnimationStatus status){
                      if(status == AnimationStatus.completed)
                        animationController1.stop();
                    });
              },
            )
          ],
        ),
      ),
    );
  }
}
