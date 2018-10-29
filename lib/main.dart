import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:redux/redux.dart';

import 'models/appState.dart';
import 'reducers/appReducer.dart';
import 'screens/home.dart';
import 'screens/cartScreen.dart';

void main() => runApp(
  new MyApp()
);

class MyApp extends StatelessWidget {
  final store = Store<AppState>(
    appReducer,
    initialState: AppState(),
  );

  @override
  Widget build(BuildContext context) {
    return new StoreProvider(
      store: store,
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Cart Redux Example',
        theme: ThemeData(
          primaryColor: Colors.yellow,
          brightness: Brightness.dark,
        ),
        routes: <String, WidgetBuilder> {
          '/': (_) => HomeScreen(),
          '/cartScreen': (_) => CartScreen(),
        },
      ),
    );
  }
}
