import 'package:flutter/material.dart';
import 'dart:convert'; // For jsonEncode
import 'package:http/http.dart' as http; // For making HTTP requests

class PaymentPage extends StatefulWidget {
  final int book_id;
  int quantity;

  PaymentPage({required this.book_id, required this.quantity});

  @override
  _PaymentPageState createState() => _PaymentPageState();
}

class _PaymentPageState extends State<PaymentPage> {
  late Future<Book> futureBook;
  String _selectedPaymentMethod = 'Cash';

  @override
  void initState() {
    super.initState();
    futureBook = fetchBookDetails(widget.book_id);
  }

  Future<Book> fetchBookDetails(int bookId) async {
    final response = await http.get(
      Uri.parse('http://zenenix.helioho.st/serve/book/bookdetailsread.php?book_id=$bookId'),
    );

    if (response.statusCode == 200) {
      return Book.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('Failed to load book details');
    }
  }

  int getTotalPrice(Book book) {
    // Parse price string to a numerical value
    int parsedPrice = int.parse(book.buyprice.replaceAll(',', '')); // Remove commas if present
    // Multiply price by quantity
    return parsedPrice * widget.quantity;
  }

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
      body: SingleChildScrollView(
        child: FutureBuilder<Book>(
          future: futureBook,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(child: CircularProgressIndicator());
            } else if (snapshot.hasError) {
              return Center(child: Text('Error: ${snapshot.error}'));
            } else if (!snapshot.hasData) {
              return Center(child: Text('No book found'));
            } else {
              final book = snapshot.data!;
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.fromLTRB(10, 15, 10, 10),
                child: Row(
                  children: [
                    Text(
                      'Seller ',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 10.0),
                      child: CircleAvatar(
                            radius: 30,
                            backgroundImage: NetworkImage(snapshot.data!.user_image),
                          ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 8),
                      child: Text(
                        snapshot.data!.user,
                        style: TextStyle(
                        fontSize: 16,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Divider(),
              Padding(
                padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
                child: Text(
                  'Book Details',
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              SizedBox(height: 20),
              Padding(
                padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Left column for image
                    Expanded(
                      child: Image.network(
                        snapshot.data!.image,
                        height: 250,
                        width: 150,
                        fit: BoxFit.cover,
                      ),
                    ),
                    SizedBox(width: 20), // Space between columns
                    // Right column for other details
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(bottom: 8.0),
                            child: Text(
                              snapshot.data!.title,
                              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(bottom: 8.0),
                            child: Text(
                              'Genre: ${snapshot.data!.genre}',
                              style: TextStyle(fontSize: 16),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(bottom: 8.0),
                            child: Text(
                              'Price: ₱${snapshot.data!.buyprice}',
                              style: TextStyle(fontSize: 16),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(bottom: 8.0),
                            child: Row(
                              children: [
                                Icon(
                                  Icons.location_on,
                                  size: 20,
                                  color: Color.fromARGB(255, 57, 55, 66),
                                ),
                                Text(
                                  snapshot.data!.location,
                                  style: TextStyle(fontSize: 16),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 20),
              Container(
                color: Color.fromARGB(255, 57, 55, 66),
                width: double.infinity,
                child: Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Column(
                    children: [
                      Row(
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(right: 140),
                            child: Text(
                              'Quantity',
                              style: TextStyle(
                                fontSize: 20,
                                color: Colors.white,
                              ),
                            ),
                          ),
                          Container(
                            decoration: BoxDecoration(
                              color: Colors.white,
                            ),
                            child: IconButton(
                              onPressed: () {
                                setState(() {
                                  if (widget.quantity > 1) {
                                    widget.quantity--;
                                  }
                                });
                              },
                              icon: Icon(
                                Icons.remove,
                                color: Color.fromARGB(255, 57, 55, 66),
                              ),
                            ),
                          ),
                      
                          Padding(
                            padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
                            child: Text(
                              widget.quantity.toString(),
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 20,
                              ),),
                          ),
                          Container(
                            decoration: BoxDecoration(
                              color: Colors.white,
                            ),
                            child: IconButton(
                              onPressed: () {
                                setState(() {
                                  widget.quantity++;
                                });
                              },
                              icon: Icon(
                                Icons.add,
                                color: Color.fromARGB(255, 57, 55, 66),
                              ),
                            ),
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          Padding(
                                padding: const EdgeInsets.fromLTRB(0, 20, 0, 10),
                                child: Text(
                                  'Total Price:\n₱${getTotalPrice(book).toStringAsFixed(2)}',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                        ],
                      )
                    ],
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(10, 20, 10, 10),
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
              ),
              Padding(
                padding: const EdgeInsets.only(
                    top: 20.0), // Add margin above the button
                child: SizedBox(
                  width: double.infinity, // Button width occupies full screen width
                  height: 70, // Set height of the button
                  child: Padding(
                    padding: const EdgeInsets.all(10.0),
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
                                      ),),
                                ],
                              ),
                              actions: [
                                TextButton(
                                  onPressed: () {
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      SnackBar(
                                        content: Center(child: Text('Checkout Successful')),
                                        duration: Duration(seconds: 2),
                                        backgroundColor: Color.fromARGB(255, 57, 55, 66),
                                      ),
                                    );
                                    Navigator.pushReplacementNamed(context, '/home');// Pop until reaching main.dart
                                  },
                                  child: Text(
                                    "Confirm",
                                    style: TextStyle(
                                      fontSize: 14,
                                      color: Color.fromARGB(255, 57, 55, 66),
                                    ),
                                  ),
                                ),
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
              ),
            ],
          );
            }
          }
        ),
      ),
    );
  }
}

class Book {
  final int id;
  final String title;
  final String genre;
  final String user;
  final String location;
  final String buyprice;
  final String rentprice;
  final String image;
  final String rentdue;
  final String rentduration;
  final String description;
  final String user_image;
  final String condition;

  Book({required this.id, required this.title, required this.genre, 
  required this.user, required this.location, required this.buyprice,
  required this.rentprice, required this.image, required this.rentdue,
  required this.rentduration, required this.description, required this.user_image,
  required this.condition});

  factory Book.fromJson(Map<String, dynamic> json) {
    return Book(
      id: int.parse(json['book_id']),
      title: json['book_title'],
      genre: json['book_genre'],
      user: json['book_user'],
      location: json['book_location'],
      buyprice: json['book_buyprice'],
      rentprice: json['book_rentprice'],
      image: json['book_image'],
      rentdue: json['book_rentdue'],
      rentduration: json['book_rentduration'],
      description: json['book_description'],
      user_image: json['book_user_image'],
      condition: json['book_condition'],
    );
  }
}