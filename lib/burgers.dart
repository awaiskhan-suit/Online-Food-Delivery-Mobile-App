import 'package:flutter/material.dart';
import 'package:online_delivery/burgers.dart';    // keep if you have a separate file
import 'package:online_delivery/product.dart';   // pizza screen
import 'package:online_delivery/success.dart';   // success page
import 'SignIn.dart';
import 'cart.dart';                            // login page

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
      home: const ProductScren(),
    );
  }
}

class ProductScren extends StatefulWidget {
  const ProductScren({super.key});

  @override
  State<ProductScren> createState() => _BurgerScreen();
}

class _BurgerScreen extends State<ProductScren> {
  /// simulate user login
  bool isLoggedIn = false;

  // Prices / quantities
  int cheeseQty = 1;
  final int cheesePrice = 150;
  int cheeseTotal = 150;

  int chickenQty = 1;
  final int chickenPrice = 250;
  int chickenTotal = 250;

  int vegeQty = 1;
  final int vegePrice = 130;
  int vegeTotal = 130;

  int mushroomQty = 1;
  final int mushroomPrice = 180;
  int mushroomTotal = 180;

  // ---- qty helpers ----
  void _incCheese() => setState(() {
    cheeseQty++;
    cheeseTotal = cheeseQty * cheesePrice;
  });

  void _decCheese() => setState(() {
    if (cheeseQty > 1) {
      cheeseQty--;
      cheeseTotal = cheeseQty * cheesePrice;
    }
  });

  void _incChicken() => setState(() {
    chickenQty++;
    chickenTotal = chickenQty * chickenPrice;
  });

  void _decChicken() => setState(() {
    if (chickenQty > 1) {
      chickenQty--;
      chickenTotal = chickenQty * chickenPrice;
    }
  });

  void _incVege() => setState(() {
    vegeQty++;
    vegeTotal = vegeQty * vegePrice;
  });

  void _decVege() => setState(() {
    if (vegeQty > 1) {
      vegeQty--;
      vegeTotal = vegeQty * vegePrice;
    }
  });

  void _incMushroom() => setState(() {
    mushroomQty++;
    mushroomTotal = mushroomQty * mushroomPrice;
  });

  void _decMushroom() => setState(() {
    if (mushroomQty > 1) {
      mushroomQty--;
      mushroomTotal = mushroomQty * mushroomPrice;
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
        title: const Text(
          "Our Products",
          style: TextStyle(color: Colors.red, fontSize: 30),
        ),
      ),
      body: ListView(
        children: [
          const SizedBox(height: 10),
          Row(
            children: [
              const SizedBox(width: 15),
              ElevatedButton(
                onPressed: () {
                  Navigator.push(context, MaterialPageRoute(builder: (_) => const PizzaScreen()));
                },
                style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
                child: const Text('Pizza', style: TextStyle(color: Colors.white)),
              ),
              const SizedBox(width: 10),
              ElevatedButton(
                onPressed: () {},
                style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
                child: const Text('Burger', style: TextStyle(color: Colors.white)),
              ),
            ],
          ),
          const SizedBox(height: 20),

          // Cheese Burger
          _burgerCard(
            image: "assets/images/CheeseBurger.jpeg",
            name: "Cheese Burger",
            price: cheeseTotal,
            qty: cheeseQty,
            onInc: _incCheese,
            onDec: _decCheese,
            onOrder: () => _handleOrder("Cheese Burger", cheeseQty, cheeseTotal),
          ),
          _burgerCard(
            image: "assets/images/chickenburger.jpeg",
            name: "Chicken Burger",
            price: chickenTotal,
            qty: chickenQty,
            onInc: _incChicken,
            onDec: _decChicken,
            onOrder: () => _handleOrder("Chicken Burger", chickenQty, chickenTotal),
          ),
          _burgerCard(
            image: "assets/images/vegeburger.jpeg",
            name: "Vege Burger",
            price: vegeTotal,
            qty: vegeQty,
            onInc: _incVege,
            onDec: _decVege,
            onOrder: () => _handleOrder("Vege Burger", vegeQty, vegeTotal),
          ),
          _burgerCard(
            image: "assets/images/mushroomburger.jpeg",
            name: "Mushroom Burger",
            price: mushroomTotal,
            qty: mushroomQty,
            onInc: _incMushroom,
            onDec: _decMushroom,
            onOrder: () => _handleOrder("Mushroom Burger", mushroomQty, mushroomTotal),
          ),
        ],
      ),
    );
  }

  /// builds each burger card
  Widget _burgerCard({
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
        padding: const EdgeInsets.all(8),
        alignment: Alignment.topCenter,
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
            ),
          ],
        ),
      ),
    );
  }
}

/// placeholder – your pizza screen
class Pizzascreen extends StatelessWidget {
  const Pizzascreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(appBar: AppBar(title: const Text('Pizza')), body: Container());
  }
}
