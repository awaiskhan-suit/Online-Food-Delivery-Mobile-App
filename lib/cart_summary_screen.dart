// lib/cart_summary_screen.dart
import 'package:flutter/material.dart';
import 'cart.dart';

class CartSummaryScreen extends StatelessWidget {
  const CartSummaryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final cartItems = Cart.items;
    final total = cartItems.fold<int>(0, (sum, i) => sum + i.price);

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text("Cart Summary"),
        backgroundColor: Colors.red,
      ),
      body: Center(
        child: cartItems.isEmpty
            ? const Text(
          "Cart is empty",
          style: TextStyle(fontSize: 20),
        )
            : Card(
          margin: const EdgeInsets.all(20),
          elevation: 5,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Text(
                  "Your Cart",
                  style: TextStyle(
                      fontSize: 24, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 20),
                ...cartItems.map((item) => Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(item.name,
                          style: const TextStyle(fontSize: 18)),
                      Text("Qty: ${item.quantity}"),
                      Text("Rs ${item.price}"),
                    ],
                  ),
                )),
                const Divider(thickness: 1.5),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      "Total",
                      style: TextStyle(
                          fontSize: 20, fontWeight: FontWeight.bold),
                    ),
                    Text(
                      "Rs $total",
                      style: const TextStyle(
                          fontSize: 20, fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
                const SizedBox(height: 20),
                ElevatedButton(
                  onPressed: () {
                    // Clear cart after order
                    Cart.clear();
                    ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                            content: Text("Order completed!")));
                    Navigator.pop(context); // go back to previous screen
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.red,
                    foregroundColor: Colors.white,
                    minimumSize: const Size.fromHeight(50),
                  ),
                  child: const Text(
                    "Complete Order",
                    style: TextStyle(fontSize: 18),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
