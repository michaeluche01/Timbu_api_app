import 'package:flutter/material.dart';
import 'package:timbu_api_app/providers/constants.dart';
import 'package:timbu_api_app/screens/product_list_screen.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    void nextPage() {
      Navigator.pushReplacement(context,
          MaterialPageRoute(builder: (context) => const ProductListScreen()));
    }

    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.secondary,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              kbusinessname,
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontSize: 40,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 25),
            ElevatedButton(
              onPressed: nextPage,
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.white,
                foregroundColor: Colors.blue,
                minimumSize: const Size(300, 60),
                shape: const BeveledRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(5)),
                ),
              ),
              child: const Text(
                'Get Started',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
