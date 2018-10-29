import '../models/appState.dart';
import 'cartReducer.dart';

AppState appReducer(AppState state, action) {
  return AppState(
    cartList: cartListReducer(state.cartList, action)
  );

}