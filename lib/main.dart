import 'dart:async';
import 'package:flutter/material.dart';
import 'cart_bloc.dart';
import 'cart_item.dart';
import 'dart:math';
import 'cart_page.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<CartModel>(
      create: (_) => CartModel(),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Flutter Demo',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: HomePage(),
      ),
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late Timer timer;
  int timerCount = 30 + Random().nextInt(60 - 30);
  int freeSeatsAvailable = 5 + Random().nextInt(15 - 5);

  final items = List<DateTime>.generate(
      60, (index) => DateTime.now().add(Duration(days: index)));

  var list = [0, 0, 0, 0, 0, for (var i = 0; i < 55; i++) Random().nextInt(60)]
    ..shuffle();

  @override
  void initState() {
    super.initState();
    startTimer();
  }

  startTimer() {
    timer = Timer.periodic(Duration(seconds: 1), (timer) {
      setState(() {
        if (timerCount < 60) {
          timerCount++;
        } else
          timer.cancel();
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    var bloc = Provider.of<CartModel>(context);
    int totalCount = 0;
    if (bloc.cartItem.length > 0) {
      totalCount = bloc.cartItem.length;
    }
    return Scaffold(
      appBar: AppBar(
        title: Text('Flutter Test'),
        actions: [
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: Container(
              height: 150.0,
              width: 30.0,
              child: GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => CartPage(),
                    ),
                  );
                },
                child: Stack(children: [
                  new IconButton(
                    icon: new Icon(
                      Icons.shopping_cart,
                      color: Colors.white,
                    ),
                    onPressed: null,
                  ),
                  new Positioned(
                    child: new Stack(
                      children: <Widget>[
                        new Icon(Icons.brightness_1,
                            size: 20.0, color: Colors.red[700]),
                        new Positioned(
                            top: 3.0,
                            right: 7,
                            child: new Center(
                              child: new Text(
                                '$totalCount',
                                style: new TextStyle(
                                    color: Colors.white,
                                    fontSize: 12.0,
                                    fontWeight: FontWeight.w500),
                              ),
                            )),
                      ],
                    ),
                  ),
                ]),
              ),
            ),
          ),
        ],
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: Text(
              'Time Left : $timerCount seconds',
              style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 10.0, bottom: 10.0),
            child: Text(
              'Claim Your Free Trial',
              style: TextStyle(
                fontSize: 24.0,
                color: Colors.orange,
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.all(10.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Class Schedule',
                  style: TextStyle(fontSize: 20.0),
                ),
                Text('Free Seats: $freeSeatsAvailable')
              ],
            ),
          ),
          Expanded(
            child: ListView.separated(
                shrinkWrap: true,
                itemBuilder: (context, index) {
                  var firstDay = items[index]
                      .subtract(Duration(days: items[index].weekday - 1));

                  String classDate =
                      '${items[index].day}-${items[index].month}-${items[index].year}';

                  String classSeats = '${list[index]}';
                  CartItem item = CartItem(classDate, classSeats, firstDay);
                  return Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Text(
                          '${items[index].day}-${items[index].month}-${items[index].year}'),
                      Divider(),
                      Text('1:00 pm - 2:00 pm'),
                      Divider(),
                      Text('${list[index]} seats'),
                      Divider(),
                      MaterialButton(
                        onPressed: list[index] == 0
                            ? () {}
                            : () {
                                bloc.addToCart(item);
                                list[index]--;
                                setState(() {});
                              },
                        color: list[index] == 0 ? Colors.black12 : Colors.red,
                        child:
                            list[index] == 0 ? Text('Full') : Text('Book Now'),
                      ),
                    ],
                  );
                },
                separatorBuilder: (context, index) {
                  return Divider();
                },
                itemCount: 60),
          ),
        ],
      ),
    );
  }
}
