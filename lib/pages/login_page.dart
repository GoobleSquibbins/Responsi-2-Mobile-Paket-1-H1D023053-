import 'package:flutter/material.dart';
import '../services/api_services.dart';
import 'items_list_page.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.grey[800],
        title: const Text(
          "Inventaris Komputer Arsyamart",
          style: TextStyle(color: Colors.white),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            TextField(
              controller: emailController,
              decoration: InputDecoration(
                labelText: "Email",
                filled: true,
                fillColor: Colors.grey[200],
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 15),
            TextField(
              controller: passwordController,
              obscureText: true,
              decoration: InputDecoration(
                labelText: "Password",
                filled: true,
                fillColor: Colors.grey[200],
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 20),

            ElevatedButton(
              onPressed: isLoading
                  ? null
                  : () async {
                      setState(() => isLoading = true);

                      final res = await ApiService().login(
                        emailController.text.trim(),
                        passwordController.text.trim(),
                      );

                      setState(() => isLoading = false);

                      if (res.containsKey('token')) {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) =>
                                ItemsListPage(token: res['token']),
                          ),
                        );
                      } else {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(content: Text("Login gagal!")),
                        );
                      }
                    },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.grey[800],
                padding: const EdgeInsets.symmetric(vertical: 15),
              ),
              child: isLoading
                  ? const CircularProgressIndicator(color: Colors.white)
                  : const Text("Login", style: TextStyle(color: Colors.white)),
            ),
          ],
        ),
      ),
    );
  }
}
