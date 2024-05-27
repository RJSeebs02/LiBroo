import 'package:flutter/material.dart';
import 'carting.dart';

class CheckoutPage extends StatefulWidget {
  final List<BookItem> selectedItems;

  CheckoutPage({required this.selectedItems});

  @override
  _CheckoutPageState createState() => _CheckoutPageState();
}

class _CheckoutPageState extends State<CheckoutPage> {
  String _selectedPaymentMethod = 'Cash';

  @override
  Widget build(BuildContext context) {
    // Calculate total price
    double totalPrice = widget.selectedItems.fold(
      0, 
      (previousValue, item) => previousValue + (item.book_buyprice * item.product_quantity),
    );

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
        padding: const EdgeInsets.all(0),
        child: SingleChildScrollView(
          child:Column(
            children: [
              Container(
                color: Color.fromARGB(255, 57, 55, 66),
                width: double.infinity,
                child: Row(
                  children: [
                    Padding(
                      padding: const EdgeInsets.fromLTRB(10, 20, 0, 10),
                      child: Text(
                        'Total Price: ₱${totalPrice.toStringAsFixed(2)}',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 20),
              Padding(
                padding: const EdgeInsets.fromLTRB(8, 0, 8, 0),
                child: Container(
                  height: 250.0 * widget.selectedItems.length,
                  child: ListView.builder(
                    itemCount: widget.selectedItems.length,
                    itemBuilder: (context, index) {
                      BookItem item = widget.selectedItems[index];
                      return Padding(
                        padding: const EdgeInsets.symmetric(vertical: 8.0),
                        child: Container(
                          height: 250.0,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(0),
                          ),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Expanded(
                                flex: 1,
                                child: Image.network(
                                  item.book_image,
                                  height: 250,
                                  width: 250,
                                  fit: BoxFit.contain,
                                ),
                              ),
                              Expanded(
                                flex: 2,
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        item.book_title,
                                        style: TextStyle(
                                          color: Color.fromARGB(255, 57, 55, 66),
                                          fontWeight: FontWeight.bold,
                                          fontSize: 24,
                                        ),
                                      ),
                                      SizedBox(height: 8),
                                      Padding(
                                        padding: const EdgeInsets.only(top: 8.0),
                                        child: Text(
                                          item.book_genre,
                                          style: TextStyle(
                                            color: Color.fromARGB(255, 57, 55, 66),
                                            fontSize: 16,
                                          ),
                                        ),
                                      ),
                                      SizedBox(height: 8),
                                      Padding(
                                        padding: const EdgeInsets.only(top: 8.0),
                                        child: Text(
                                          item.book_user,
                                          style: TextStyle(
                                            color: Color.fromARGB(255, 57, 55, 66),
                                            fontSize: 16,
                                          ),
                                        ),
                                      ),
                                      SizedBox(height: 8),
                                      Text(
                                        item.book_location,
                                        style: TextStyle(
                                          color: Color.fromARGB(255, 57, 55, 66),
                                          fontSize: 16,
                                        ),
                                      ),
                                      SizedBox(height: 8),
                                      Align(
                                        alignment: Alignment.bottomRight,
                                        child: Padding(
                                          padding: const EdgeInsets.only(top: 8.0, bottom: 10.0, right: 16.0),
                                          child: Text(
                                            '₱${item.book_buyprice * item.product_quantity}',
                                            style: TextStyle(
                                              color: Color.fromARGB(255, 57, 55, 66),
                                              fontSize: 20,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ),
              SizedBox(height: 20),
              Padding(
                padding: const EdgeInsets.fromLTRB(8, 0, 8, 0),
                child: Row(
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
                          'Cash',
                          'GCash',
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
              ),
              SizedBox(height: 20),
              Padding(
                padding: const EdgeInsets.fromLTRB(8, 30.0, 8, 0),
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
                            content: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Divider(),
                                Text(
                                  "Are you sure you want to confirm payment?",
                                  style: TextStyle(
                                    fontSize: 20,
                                    color: Color.fromARGB(255, 57, 55, 66),
                                  ),
                                ),
                              ],
                            ),
                            actions: [
                              TextButton(
                                onPressed: () {
                                  // Add payment processing logic here
                                  Navigator.of(context).pop();
                                },
                                child: Text(
                                  "Cancel",
                                  style: TextStyle(
                                    fontSize: 14,
                                    color: Color.fromARGB(255, 57, 55, 66),
                                  ),
                                ),
                              ),
                            TextButton(
                              onPressed: () {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                    content: Center(child: Text('Checkout Made')),
                                    duration: Duration(seconds: 2),
                                    backgroundColor: Color.fromARGB(255, 57, 55, 66),
                                  ),
                                );
                                Navigator.pushReplacementNamed(context, '/home');
                              },
                              child: Text(
                                  "Confirm",
                                  style: TextStyle(
                                    fontSize: 14,
                                    color: Color.fromARGB(255, 57, 55, 66),
                                  ),
                                ),
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
      ),
    );
  }
}