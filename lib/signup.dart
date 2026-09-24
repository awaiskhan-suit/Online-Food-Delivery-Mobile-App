import 'package:flutter/material.dart';
import 'data/local/Shop.dart';
import 'data/local/db_helper.dart';

void main() {
  runApp(FlutterApp());
}

class FlutterApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Flutter Demo",
      theme: ThemeData(primarySwatch: Colors.red),
      home: SignUpScreen(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class SignUpScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => SignUpScreenState();
}

class SignUpScreenState extends State<SignUpScreen> {
  final S_emails = TextEditingController();
  final S_passwords = TextEditingController();
  final S_names = TextEditingController();

  Future<void> _SavedCustomer() async {
    // 🔹 Basic empty-field validation
    if (S_names.text.trim().isEmpty ||
        S_emails.text.trim().isEmpty ||
        S_passwords.text.trim().isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Please fill all the fields first")),
      );
      return; // stop execution
    }

    final shop = Shop(
      name: S_names.text.trim(),
      email: S_emails.text.trim(),
      password: S_passwords.text.trim(),
    );

    await DatabaseHelper.instance.insertShop(shop);

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text("Your data saved successfully")),
    );

    S_names.clear();
    S_emails.clear();
    S_passwords.clear();

    // Navigate to Customer List Screen
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => CustomerListScreen()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [Color(0xFFE0C3FC), Color(0xFFFFD6E8)],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(24.0),
            child: Container(
              padding: const EdgeInsets.all(24),
              width: 350,
              decoration: BoxDecoration(
                color: Colors.white.withOpacity(0.8),
                borderRadius: BorderRadius.circular(20),
              ),
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    const Text(
                      "SignUp Page",
                      style: TextStyle(
                        fontSize: 30,
                        color: Colors.green,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 40),

                    /// Name
                    TextField(
                      controller: S_names,
                      decoration: InputDecoration(
                        hintText: 'Enter Your Name',
                        prefixIcon: const Icon(Icons.person),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20),
                        ),
                      ),
                    ),
                    const SizedBox(height: 15),

                    /// Email
                    TextField(
                      controller: S_emails,
                      decoration: InputDecoration(
                        hintText: 'Enter Your Email',
                        prefixIcon: const Icon(Icons.email),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20),
                        ),
                      ),
                    ),
                    const SizedBox(height: 15),

                    /// Password
                    TextField(
                      controller: S_passwords,
                      obscureText: true,
                      decoration: InputDecoration(
                        hintText: "Enter Your Password",
                        prefixIcon: const Icon(Icons.lock),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20),
                        ),
                      ),
                    ),
                    const SizedBox(height: 20),

                    /// SignUp Button
                    ElevatedButton(
                      onPressed: _SavedCustomer,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.red,
                        foregroundColor: Colors.white,
                      ),
                      child: const Text("SignUp", style: TextStyle(fontSize: 16)),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class CustomerListScreen extends StatelessWidget {
  Future<List<Shop>> _loadCustomers() async {
    return await DatabaseHelper.instance.getShop();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Customer List")),
      body: FutureBuilder<List<Shop>>(
        future: _loadCustomers(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(child: Text("No customers found"));
          } else {
            final customers = snapshot.data!;
            return ListView.builder(
              itemCount: customers.length,
              itemBuilder: (context, index) {
                final shop = customers[index];
                return Card(
                  margin: const EdgeInsets.all(10),
                  child: ListTile(
                    leading: const Icon(Icons.person, color: Colors.red),
                    title: Text(shop.name),
                    subtitle: Text("Email: ${shop.email}\nPassword: ${shop.password}"),
                  ),
                );
              },
            );
          }
        },
      ),
    );
  }
}
