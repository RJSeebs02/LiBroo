import 'package:flutter/material.dart';
import 'carting.dart';

class CheckoutPage extends StatefulWidget {
  final List<BookItem> selectedItems;

  CheckoutPage({required this.selectedItems});

  @override
  _CheckoutPageState createState() => _CheckoutPageState();
}

class _CheckoutPageState extends State<CheckoutPage> {
  String _selectedPaymentMethod = 'Cash on Delivery';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Checkout',
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: Color.fromARGB(255, 57, 55, 66),
        iconTheme: IconThemeData(color: Colors.white),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Selected Books:',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 20),
            ListView.builder(
              shrinkWrap: true,
              itemCount: widget.selectedItems.length,
              itemBuilder: (context, index) {
                BookItem item = widget.selectedItems[index];
                return Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8.0),
                  child: ListTile(
                    leading: Image.network(
                      item.imagePath,
                      height: 100,
                      width: 100,
                      fit: BoxFit.cover,
                    ),
                    title: Text(item.title),
                    subtitle: Text(item.price),
                  ),
                );
              },
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
                    ]
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
              padding: const EdgeInsets.only(top: 30.0),
              child: SizedBox(
                width: double.infinity,
                height: 50,
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
                                    ModalRoute.withName('/')); 
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
                        Color.fromARGB(255, 57, 55, 66),
                  ),
                  child: Text(
                    'Confirm Payment',
                    style: TextStyle(
                      fontSize: 20,
                      color: Colors.white,
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
