import 'package:flutter/material.dart';
import 'package:online_delivery/burgers.dart'; // Burger screen
import 'package:online_delivery/success.dart'; // Success screen
import 'SignIn.dart';
import 'burgers.dart';
import 'cart.dart';
import 'data/local/cart.dart'; // Login screen

void main() {
  runApp(const FlutterApp());
}

class FlutterApp extends StatelessWidget {
  const FlutterApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Flutter Demo",
      theme: ThemeData(primarySwatch: Colors.blue),
      home: const Pizzascreen(),
    );
  }
}

class PizzaScreen extends StatefulWidget {
  const PizzaScreen({super.key});

  @override
  State<PizzaScreen> createState() => _PizzaScreenState();
}

class _PizzaScreenState extends State<PizzaScreen> {
  /// Simulate login. Change to false to test.
  bool isLoggedIn = false;

  // --- Cheese Pizza ---
  int cheesepizzaQty = 1;
  final int pricePerCheese = 300;
  int cheeseTotal = 300;

  // --- Chicken Pizza ---
  int chickenQty = 1;
  final int pricePerChicken = 400;
  int chickenTotal = 400;

  // --- Pepperoni Pizza ---
  int pepperoniQty = 1;
  final int pricePerPepperoni = 250;
  int pepperoniTotal = 250;

  // --- Hawaiian Pizza ---
  int hawaiianQty = 1;
  final int pricePerHawaiian = 350;
  int hawaiianTotal = 350;

  // ===== quantity helpers =====
  void _incCheese() => setState(() {
    cheesepizzaQty++;
    cheeseTotal = cheesepizzaQty * pricePerCheese;
  });
  void _decCheese() => setState(() {
    if (cheesepizzaQty > 1) {
      cheesepizzaQty--;
      cheeseTotal = cheesepizzaQty * pricePerCheese;
    }
  });

  void _incChicken() => setState(() {
    chickenQty++;
    chickenTotal = chickenQty * pricePerChicken;
  });
  void _decChicken() => setState(() {
    if (chickenQty > 1) {
      chickenQty--;
      chickenTotal = chickenQty * pricePerChicken;
    }
  });

  void _incPepperoni() => setState(() {
    pepperoniQty++;
    pepperoniTotal = pepperoniQty * pricePerPepperoni;
  });
  void _decPepperoni() => setState(() {
    if (pepperoniQty > 1) {
      pepperoniQty--;
      pepperoniTotal = pepperoniQty * pricePerPepperoni;
    }
  });

  void _incHawaiian() => setState(() {
    hawaiianQty++;
    hawaiianTotal = hawaiianQty * pricePerHawaiian;
  });
  void _decHawaiian() => setState(() {
    if (hawaiianQty > 1) {
      hawaiianQty--;
      hawaiianTotal = hawaiianQty * pricePerHawaiian;
    }
  });

  Future<void> _handleOrder(String product, int qty, int total) async {
    // if not logged in, open login then just come back
    if (!isLoggedIn) {
      final result = await Navigator.push<bool>(
        context,
        MaterialPageRoute(builder: (_) => const LoginScreen()),
      );

      if (result == true) {
        // Mark logged in so next tap will go to success
        setState(() => isLoggedIn = true);
      }
      // Always return here (do NOT push success immediately)
      return;
    }

    // Already logged in → actually place the order
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => PurchaseSuccessScreen(
          productName: product,
          quantity: qty,
          totalPrice: total,
        ),
      ),
    );
  }

  Future<void> _handleAddToCart(String name, int qty, int price) async {
    // if user is not logged in, open login
    if (!isLoggedIn) {
      final result = await Navigator.push<bool>(
        context,
        MaterialPageRoute(builder: (_) => const LoginScreen()),
      );

      if (result == true) {
        // Mark as logged in
        setState(() => isLoggedIn = true);
      }
      // return early, don't add anything this tap
      return;
    }

    // Already logged in → actually add to cart
    Cart.addItem(name, qty, price);
    ScaffoldMessenger.of(context)
        .showSnackBar(SnackBar(content: Text('$name added to cart')));
  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Our Products", style: TextStyle(color: Colors.red, fontSize: 30)),
      ),
      body: ListView(
        children: [
          const SizedBox(height: 10),
          Row(
            children: [
              const SizedBox(width: 15),
              ElevatedButton(
                onPressed: () {},
                style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
                child: const Text('Pizza', style: TextStyle(color: Colors.white)),
              ),
              const SizedBox(width: 10),
              ElevatedButton(
                onPressed: () {
                  Navigator.push(context, MaterialPageRoute(builder: (_) => ProductScren()));
                },
                style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
                child: const Text('Burger', style: TextStyle(color: Colors.white)),
              ),
            ],
          ),
          const SizedBox(height: 20),

          // -------- Cheese Pizza --------
          _pizzaCard(
            image: "assets/images/cheesepizza.jpeg",
            name: "Cheese Pizza",
            price: cheeseTotal,
            qty: cheesepizzaQty,
            onInc: _incCheese,
            onDec: _decCheese,
            onOrder: () => _handleOrder("Cheese Pizza", cheesepizzaQty, cheeseTotal),
          ),
          // -------- Chicken Pizza --------
          _pizzaCard(
            image: "assets/images/chickenpizza.jpg",
            name: "Chicken Pizza",
            price: chickenTotal,
            qty: chickenQty,
            onInc: _incChicken,
            onDec: _decChicken,
            onOrder: () => _handleOrder("Chicken Pizza", chickenQty, chickenTotal),
          ),
          // -------- Hawaiian Pizza --------
          _pizzaCard(
            image: "assets/images/hawaiianpizza.png",
            name: "Hawaiian Pizza",
            price: hawaiianTotal,
            qty: hawaiianQty,
            onInc: _incHawaiian,
            onDec: _decHawaiian,
            onOrder: () => _handleOrder("Hawaiian Pizza", hawaiianQty, hawaiianTotal),
          ),
          // -------- Pepperoni Pizza --------
          _pizzaCard(
            image: "assets/images/PepperoniPizza.jpeg",
            name: "Pepperoni Pizza",
            price: pepperoniTotal,
            qty: pepperoniQty,
            onInc: _incPepperoni,
            onDec: _decPepperoni,
            onOrder: () => _handleOrder("Pepperoni Pizza", pepperoniQty, pepperoniTotal),
          ),
        ],
      ),
    );
  }

  Widget _pizzaCard({
    required String image,
    required String name,
    required int price,
    required int qty,
    required VoidCallback onInc,
    required VoidCallback onDec,
    required VoidCallback onOrder,
  }) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 12),
      child: Container(
        width: 400,
        height: 300,
        alignment: Alignment.topCenter,
        padding: const EdgeInsets.all(8),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(image, height: 120),
            const SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(name, style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                Text("Rs: $price"),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(children: [
                  IconButton(onPressed: onInc, icon: const Icon(Icons.add_circle)),
                  IconButton(onPressed: onDec, icon: const Icon(Icons.remove_circle)),
                ]),
                Text("Quantity = $qty"),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                ElevatedButton(
                  onPressed: onOrder,
                  style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
                  child: const Text("Order", style: TextStyle(color: Colors.white)),
                ),
                ElevatedButton(
                  onPressed: () => _handleAddToCart(name, qty, price),

                  style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
                  child: const Text("Add To Cart", style: TextStyle(color: Colors.white)),
                ),

              ],
            )
          ],
        ),
      ),
    );
  }
}
