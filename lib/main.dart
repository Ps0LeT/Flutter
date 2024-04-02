import 'package:flutter/material.dart';

void main() {
  runApp( MyApp());
}

class MyApp extends StatelessWidget {
   MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primarySwatch: Colors.blue,
      ),
      home:  MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
   MyHomePage({super.key, required this.title});

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;

  void _incrementCounter() {
    setState(() {
      // This call to setState tells the Flutter framework that something has
      // changed in this State, which causes it to rerun the build method below
      // so that the display can reflect the updated values. If we changed
      // _counter without calling setState(), then the build method would not be
      // called again, and so nothing would appear to happen.
      _counter++;
    });
  }

   var tiles = List.filled(9, 0);

  @override
  Widget build(BuildContext context) {
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
    return Scaffold(  
      appBar: AppBar(
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: Text(widget.title),
      ),
      body:Row(
        children: [
          AspectRatio(
            aspectRatio: 1,child: GridView.count(
              crossAxisCount: 3,
             children: [
              for(var i = 0; i <9; i++)
               InkWell(
                onTap: (){
                  setState(() {
                    
                  tiles[i] = 1;
                  runAi();
                  });
                },
                 child: Center(
                  child: Text(tiles[i] == 0 
                  ? ''
                   : tiles[i] == 1
                   ? 'X' 
                   : tiles[i] == 2 
                   ? 'O'
                   : '')),
               )
              ],
               ),
               ),
             Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                
                 Text(isWinning(1, tiles)
                  ? 'you win' 
                  : isWinning(2, tiles)
                  ? 'you lose'
                  :'Your Turn'),
                OutlinedButton(
                  onPressed: () {
                    setState(() {
                      tiles = List.filled(9, 0);
                    });
                  },
                 child:  Text('Retry'))
              ],
             )  
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: 'Increment',
        child:  Icon(Icons.add),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
  
  void runAi() async {
   await Future.delayed( Duration(milliseconds: 200)) 
   ;

   int? Winning;
   int? blocking;
   int? normal;

for (var i = 0; i < 9; i++) {
  var val = tiles[i];

  if (val > 0){
    continue;
  }
  var future = [...tiles]..[i] = 2;
  
  if (isWinning(2, future)) {
    Winning = i ;
     return 
     
     //setState(() {
      
     //tiles = List.filled(9, 0);
     
    //});
  ;}

  future[i] = 1;

  if (isWinning(1, future)) {
    blocking = i;
    //setState(() {
      //tiles = List.filled(9, 0);
    //});
  }
  
  normal = i;

}

var move = Winning ?? blocking ?? normal;

if (move != null){
  setState(() {
     @override
    Widget build(BuildContext context) {
      return MaterialApp(
        theme: ThemeData(primarySwatch: Colors.red),
      );
    }
   
    tiles[move] = 2
      ;
  });
}

  }
  
  bool isWinning(int who, List<int> tiles) {
    return
    (tiles[0] == who && tiles[1] == who && tiles[2] == who) ||
    (tiles[0] == who && tiles[3] == who && tiles[6] == who) ||
    (tiles[0] == who && tiles[4] == who && tiles[8] == who) ||
    (tiles[1] == who && tiles[4] == who && tiles[7] == who) ||
    (tiles[2] == who && tiles[5] == who && tiles[8] == who) ||
    (tiles[2] == who && tiles[4] == who && tiles[6] == who) ||
    (tiles[3] == who && tiles[4] == who && tiles[5] == who) ||
    (tiles[6] == who && tiles[7] == who && tiles[8] == who);

  }
}
