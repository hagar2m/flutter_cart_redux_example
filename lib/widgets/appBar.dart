import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';

import '../models/appState.dart';
import '../models/cartItem.dart';


class HomeAppBar extends AppBar{

  HomeAppBar({ Key key, Widget title, BuildContext context }) : 
  super(key: key, title: title,
    actions: <Widget>[
      StoreConnector<AppState, List<CartItem>>(
        converter: (store) => store.state.cartList,
        builder: (_, cartlist) {
          return IconButton(
            padding: EdgeInsets.all(0.0),
            iconSize: 30.0,
            icon: Stack(
              overflow: Overflow.visible,
              children: <Widget>[
                Icon(Icons.shopping_cart),
                new Positioned(
                  top: -7.0,
                  right: -3.0,
                  child: buildBadge(cartlist.length),
                )
              ],
            ),
            onPressed: () => Navigator.of(context).pushNamed('/cartScreen'),
          );
        },
      )
    ],
  );


  static Widget buildBadge(int num) {
    return CircleAvatar(
      radius: 10.0,
      backgroundColor: Colors.red,
      child: Text(
        '$num',
        style: TextStyle(color: Colors.white),
      ),
    );
  }

}