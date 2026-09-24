// lib/cart.dart
class CartItem {
  final String name;
  int quantity;
  int price;

  CartItem({required this.name, required this.quantity, required this.price});
}

class Cart {
  static final List<CartItem> items = [];

  static void addItem(String name, int quantity, int price) {
    final index = items.indexWhere((i) => i.name == name);
    if (index >= 0) {
      items[index].quantity += quantity;
      items[index].price += price;
    } else {
      items.add(CartItem(name: name, quantity: quantity, price: price));
    }
  }

  static void clear() => items.clear();
}
