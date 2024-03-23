import 'package:flutter/material.dart';

class PaymentPage extends StatefulWidget {
  final String bookTitle;
  final String bookPrice;
  final String userText;
  final String imagePath;

  PaymentPage({
    required this.bookTitle,
    required this.bookPrice,
    required this.userText,
    required this.imagePath,
  });

  @override
  _PaymentPageState createState() => _PaymentPageState();
}

class _PaymentPageState extends State<PaymentPage> {
  String _selectedPaymentMethod = 'Cash on Delivery';

  @override
  Widget build(BuildContext context) {
    // Hardcoded buyer's address
    String buyerAddress =
        'Lot 32, Block 17, City Heights Subdivision, Ruby St. corner Sapphire St., Brgy. Taculing, Bacolod City, Negros Occidental';

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Checkout',
          style: TextStyle(color: Colors.white), // Title color set to white
        ),
        backgroundColor:
            Color.fromARGB(255, 57, 55, 66), // App bar background color set to grey
        iconTheme: IconThemeData(color: Colors.white), // Change back arrow color to white
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Buyer\'s Address:', // Text indicating buyer's address
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 8),
            Text(
              buyerAddress, // Display hardcoded buyer's address
              style: TextStyle(fontSize: 18),
            ),
            SizedBox(height: 20),
            Text(
              'Book Details',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 20),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Left column for image
                Expanded(
                  flex: 1,
                  child: Image.network(
                    widget.imagePath,
                    height: 150,
                    width: 150,
                  ),
                ),
                SizedBox(width: 20), // Space between columns
                // Right column for other details
                Expanded(
                  flex: 2,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(bottom: 8.0),
                        child: Text(
                          'Book: ${widget.bookTitle}',
                          style: TextStyle(fontSize: 18),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(bottom: 8.0),
                        child: Text(
                          'Price: ${widget.bookPrice}',
                          style: TextStyle(fontSize: 18),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(bottom: 8.0),
                        child: Text(
                          'User Text: ${widget.userText}',
                          style: TextStyle(fontSize: 18),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            SizedBox(height: 20),
            Row(
              children: [
                Text(
                  'Payment Method:',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(width: 8),
                Expanded(
                  child: DropdownButton<String>(
                    value: _selectedPaymentMethod,
                    onChanged: (String? newValue) {
                      setState(() {
                        _selectedPaymentMethod = newValue!;
                      });
                    },
                    items: <String>[
                      'Cash on Delivery',
                      'GCash'
                    ] // Removed 'Maya'
                        .map<DropdownMenuItem<String>>((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text(value),
                      );
                    }).toList(),
                  ),
                ),
              ],
            ),
            SizedBox(height: 20),
            Padding(
              padding: const EdgeInsets.only(
                  top: 30.0), // Add margin above the button
              child: SizedBox(
                width: double.infinity, // Button width occupies full screen width
                height: 50, // Set height of the button
                child: ElevatedButton(
                  onPressed: () {
                    // Show confirmation dialog
                    showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return AlertDialog(
                          title: Text("Confirm Payment"),
                          content: Text(
                              "Are you sure you want to confirm payment?"),
                          actions: [
                            TextButton(
                              onPressed: () {
                                Navigator.popUntil(context,
                                    ModalRoute.withName('/')); // Pop until reaching main.dart
                              },
                              child: Text("Confirm"),
                            ),
                            TextButton(
                              onPressed: () {
                                // Add payment processing logic here
                                Navigator.of(context).pop();
                              },
                              child: Text("Cancel"),
                            ),
                          ],
                        );
                      },
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor:
                        Color.fromARGB(255, 57, 55, 66), // Change button color
                  ),
                  child: Text(
                    'Confirm Payment',
                    style: TextStyle(
                      fontSize: 20,
                      color: Colors.white, // Change text color
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
