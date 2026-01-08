import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key, required this.onGoRegister});

  final VoidCallback onGoRegister;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Home')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset('assets/logo.jpg', width: 140, height: 140),
            const SizedBox(height: 20),
            const Text('Event Management', style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: onGoRegister, // chuyển tab Register
              child: const Text('Register Event'),
            ),
          ],
        ),
      ),
    );
  }
}
