import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'cart_bloc.dart';
import 'package:provider/provider.dart';

class CartPage extends StatefulWidget {
  const CartPage({Key? key}) : super(key: key);

  @override
  _CartPageState createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {
  @override
  Widget build(BuildContext context) {
    var bloc = Provider.of<CartModel>(context);
    var cartCount = bloc.cartItem.length;
    return Scaffold(
      appBar: AppBar(
        title: Text('Cart'),
      ),
      body: ListView.builder(
        itemBuilder: (context, index) {
          return Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Text('${bloc.cartItem[index].date}'),
              Divider(),
              Text('1:00 pm - 2:00 pm'),
              MaterialButton(
                onPressed: () {
                  bloc.removeCart(bloc.cartItem[index]);
                },
                child: Text('Cancel Class'),
                color: Colors.red,
              ),
            ],
          );
        },
        itemCount: cartCount,
      ),
    );
  }
}
