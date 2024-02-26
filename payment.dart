import 'package:flutter/material.dart';

class PaymentPage extends StatelessWidget {
  final String bookTitle;
  final String bookPrice;

  PaymentPage({
    required this.bookTitle,
    required this.bookPrice,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Payment'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Payment Page',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 20),
            Text(
              'Book: $bookTitle',
              style: TextStyle(fontSize: 18),
            ),
            Text(
              'Price: $bookPrice',
              style: TextStyle(fontSize: 18),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                // Add payment processing logic here
                Navigator.pop(context); // Navigate back to the previous page after payment
              },
              child: Text('Process Payment'),
            ),
          ],
        ),
      ),
    );
  }
}
