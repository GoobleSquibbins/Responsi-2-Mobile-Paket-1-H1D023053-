import 'package:flutter/material.dart';
import '../services/api_services.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmController = TextEditingController();

  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.grey[800],
        title: const Text(
          "Register Arsyamart",
          style: TextStyle(color: Colors.white),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              TextField(
                controller: nameController,
                decoration: const InputDecoration(
                  labelText: "Name",
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 15),

              TextField(
                controller: emailController,
                decoration: const InputDecoration(
                  labelText: "Email",
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 15),

              TextField(
                controller: passwordController,
                obscureText: true,
                decoration: const InputDecoration(
                  labelText: "Password",
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 15),

              TextField(
                controller: confirmController,
                obscureText: true,
                decoration: const InputDecoration(
                  labelText: "Konfirmasi Password",
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 20),

              ElevatedButton(
                onPressed: isLoading
                    ? null
                    : () async {
                        if (passwordController.text != confirmController.text) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text("Passwords tidak sama"),
                            ),
                          );
                          return;
                        }

                        setState(() => isLoading = true);

                        final res = await ApiService().register(
                          nameController.text.trim(),
                          emailController.text.trim(),
                          passwordController.text.trim(),
                        );

                        setState(() => isLoading = false);

                        if (res["success"] == true) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text(
                                "Register berhasil! Silakan login.",
                              ),
                            ),
                          );
                          Navigator.pop(context);
                        } else {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text(res["message"] ?? "Gagal register"),
                            ),
                          );
                        }
                      },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.grey[800],
                  padding: const EdgeInsets.symmetric(vertical: 15),
                ),
                child: isLoading
                    ? const CircularProgressIndicator(color: Colors.white)
                    : const Text(
                        "Register",
                        style: TextStyle(color: Colors.white),
                      ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
