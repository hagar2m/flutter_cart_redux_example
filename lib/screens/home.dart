import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:redux/redux.dart';

import '../models/appState.dart';
import '../models/cartItem.dart';
import '../actions/action.dart';
import '../widgets/appBar.dart';

/*
this is the home screen of this project
*/

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => new _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  // products is a static list
  List<Map> products = [
    {'id': 1, 'name': 'Headphone', 'price': '9\$'},
    {'id': 2, 'name': 'Smart watch', 'price': '30\$'},
    {'id': 3, 'name': 'Earphone', 'price': '5\$'},
    {'id': 4, 'name': 'HD Projector', 'price': '95\$'},
    {'id': 5, 'name': '3D Glasses', 'price': '10\$'},
    {'id': 6, 'name': 'Wirless mouse', 'price': '4\$'},
  ];

  // is a function to check if product item is added to cart before or not
  bool _isSelected(Map productItem, List cartList) {
    List filterList = cartList.where((item) => item.id == productItem['id']).toList();
    print('filterList: ${filterList.length}');
    return filterList.length > 0 ? true : false;
  }

  // is a widget to render row of products list
  Widget _buildProductRow({ Map item, _ViewModel viewmodel}) {
    
    bool isSelected = _isSelected(item, viewmodel.cartList);

    return ListTile(
      leading: Text('${item['name']}', style: Theme.of(context).textTheme.title),
      title: Text('${item['price']}'),
      trailing: Container(
        child: IconButton(
          color: Colors.green,
          icon: isSelected ?  Icon(Icons.shopping_cart) : Icon(Icons.add_shopping_cart),
          onPressed: isSelected ? null : () => viewmodel.onPressedCallback(item: item),
        ),
      )
    );
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: HomeAppBar(context: context),

      body: new Container(
        child: StoreConnector<AppState, _ViewModel>(
          converter: _ViewModel.fromStore,
          builder: (_, _ViewModel _viewmodel) {
            return ListView.builder(
              itemCount: products.length,
              itemBuilder: (_, index) {
                return _buildProductRow(
                  item: products[index],
                  viewmodel: _viewmodel
                );
              },
            );
          },
        ),
      ),
    );
  }
}


class _ViewModel {
  final List<CartItem> cartList;
  final Function onPressedCallback;

  _ViewModel({ this.cartList, this.onPressedCallback });
  
  // when state updates, it will recreate this _ViewModel
  static _ViewModel fromStore(Store<AppState> store) {
    return new _ViewModel(
      cartList: store.state.cartList,
      onPressedCallback: ({ Map item }) {
        return store.dispatch(AddItemAction( CartItem.fromMap(item)));
      });
  }
}
