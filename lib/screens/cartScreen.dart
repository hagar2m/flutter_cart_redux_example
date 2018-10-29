import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:redux/redux.dart';

import '../models/appState.dart';
import '../models/cartItem.dart';
import '../actions/action.dart';

class CartScreen extends StatelessWidget {

  Widget _buildCartItem({ CartItem item, _ViewModel viewmodel, BuildContext context }) {
    return  ListTile(
      leading: Text('${item.name}', style: Theme.of(context).textTheme.title),
      title: Text('${item.price}'),
      trailing: Container(
        child: IconButton(
          icon: Icon(Icons.delete_outline),
          onPressed: () { 
            viewmodel.deleteItemCallback(item: item);
          },
        ),
      )
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: new AppBar(title: Text('My Cart')),
      body: Container(
        child: StoreConnector<AppState, _ViewModel >(
          converter: _ViewModel.fromStore,
          builder: (_, _ViewModel _viewmodel) {
            if(_viewmodel.cartList.length <= 0) {
              return Center(
                child: Text('Your cart is empty'),
              );
            } else {
              return ListView.builder(
                itemCount: _viewmodel.cartList.length,
                itemBuilder: (_, index) {
                  return _buildCartItem(
                    item: _viewmodel.cartList[index],
                    viewmodel: _viewmodel,
                    context: context
                  );
                },
              );
            }
          },
        ),
      ),
    );
  }
}

class _ViewModel {
  final List<CartItem> cartList;
  final Function deleteItemCallback;

  _ViewModel({ this.cartList, this.deleteItemCallback });

  static _ViewModel fromStore(Store<AppState> store) {
    return new _ViewModel(
      cartList: store.state.cartList,
      deleteItemCallback: ({ CartItem item }) {
        debugPrint('_ViewModel redux - item: ${item.toString()}');
        return store.dispatch(RemoveItemAction(item.id));
      });
  }
}
