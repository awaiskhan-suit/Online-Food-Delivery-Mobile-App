// lib/cart_screen.dart
import 'package:flutter/material.dart';
import 'cart.dart';
import 'cart_summary_screen.dart';

class CartScreen extends StatefulWidget {
  const CartScreen({super.key});

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  void _removeItems(int index) {
    setState(() {
      Cart.items.removeAt(index);
    });
    ScaffoldMessenger.of(context)
        .showSnackBar(const SnackBar(content: Text("Item removed")));
  }

  

  @override
  Widget build(BuildContext context) {
    final cartItems = Cart.items;
    final total = cartItems.fold<int>(0, (sum, i) => sum + i.price);

    return Scaffold(
      appBar: AppBar(title: const Text("My Cart")),
      body: cartItems.isEmpty
          ? const Center(child: Text("Cart is empty"))
          : Column(
        children: [
          Expanded(
            child: ListView.builder(
              itemCount: cartItems.length,
              itemBuilder: (_, i) {
                final item = cartItems[i];
                return Card(
                  margin: const EdgeInsets.all(8),
                  child: ListTile(
                    title: Text(item.name),
                    subtitle: Text("Quantity: ${item.quantity}"),
                    trailing: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text("Rs ${item.price}"),
                        IconButton(
                          onPressed: () => _removeItems(i),
                          icon: const Icon(Icons.delete, color: Colors.red),
                        )
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
          const SizedBox(height: 10),
          Padding(
            padding: const EdgeInsets.all(12),
            child: ElevatedButton(
              onPressed: (){
                Navigator.push(context, MaterialPageRoute(builder: (context)=>CartSummaryScreen()));
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
          ),
        ],
      ),
      bottomNavigationBar: Container(
        padding: const EdgeInsets.all(12),
        child: Text(
          "Total: Rs $total",
          style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        ),
      ),
    );
  }
}

