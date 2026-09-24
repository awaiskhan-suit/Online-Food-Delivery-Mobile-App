import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class PurchaseSuccessScreen extends StatelessWidget {
  final String productName;
  final int quantity;
  final int totalPrice;

  const PurchaseSuccessScreen({
    super.key,
    required this.productName,
    required this.quantity,
    required this.totalPrice,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Card(
          elevation: 4,
          margin: const EdgeInsets.all(24),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(24),
          ),
          child: Padding(
            padding: const EdgeInsets.all(24),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Icon(Icons.check_circle, size: 80, color: Colors.green),
                const SizedBox(height: 20),
                const Text(
                  "Purchase Successful",
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 13),
                Text("Thank You for Purchasing the $productName"),
                const SizedBox(height: 8),
                Text("Quantity = $quantity"),
                const SizedBox(height: 8),
                Text("Total price = $totalPrice"),
                const SizedBox(height: 13),
                ElevatedButton(
                  onPressed: () => Navigator.pop(context),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.red,
                    foregroundColor: Colors.white,
                  ),
                  child: const Text("OK"),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
