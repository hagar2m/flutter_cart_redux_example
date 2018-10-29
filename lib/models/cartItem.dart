class CartItem {
  int id;
  String name;
  String price;
  CartItem({this.id, this.name, this.price});

  static CartItem fromMap(Map item) {
    return CartItem(
      id: item['id'],
      name: item['name'],
      price: item['price'],
    );
  }
}
