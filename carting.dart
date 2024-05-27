import 'package:flutter/cupertino.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'book_details.dart';
import 'checkout.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class BookItem {
  final int book_id;
  final String book_title;
  final String book_genre;
  final String book_user;
  final String book_location;
  final int book_buyprice;
  final int book_rentprice;
  final String book_image;
  final String book_rentdue;
  final String book_rentduration;
  final String book_description;
  final String book_user_image;
  final String book_condition;
  int product_quantity;
  bool isChecked;

  BookItem({
    required this.book_id,
    required this.book_title,
    required this.book_genre,
    required this.book_user,
    required this.book_location,
    required this.book_buyprice,
    required this.book_rentprice,
    required this.book_image,
    required this.book_rentdue,
    required this.book_rentduration,
    required this.book_description,
    required this.book_user_image,
    required this.book_condition,
    required this.product_quantity,
    this.isChecked = false,
  });
}

class CartingPage extends StatelessWidget {
  final String username;

  const CartingPage({Key? key, required this.username}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Libroo',
      home: ImageAndJsonLoadingDemo(username: username),
    );
  }
}

class ImageAndJsonLoadingDemo extends StatefulWidget {
  final String username;

  const ImageAndJsonLoadingDemo({Key? key, required this.username}) : super(key: key);

  @override
  _ImageAndJsonLoadingDemoState createState() =>
      _ImageAndJsonLoadingDemoState();
}

class _ImageAndJsonLoadingDemoState extends State<ImageAndJsonLoadingDemo> {
  String? userUsername;
  late Future<List<BookItem>> _bookItems;
  int _totalPrice = 0;

  @override
  void initState() {
    super.initState();
    _bookItems = _fetchBookItems();
    _loadUsername();
  }

  Future<void> _loadUsername() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      userUsername = prefs.getString('user_username');
    });
  }

  Future<List<BookItem>> _fetchBookItems() async {
    final response = await http.get(Uri.parse('https://zenenix.helioho.st/serve/carting_item/carting_itemread.php?user_username=${widget.username}'));
    if (response.statusCode == 200) {
      Iterable data = json.decode(response.body);
      return List<BookItem>.from(data.map((model) => BookItem(
        book_id: int.parse(model['book_id']),
        book_title: model['book_title'],
        book_genre: model['book_genre'],
        book_user: model['book_user'],
        book_location: model['book_location'],
        book_buyprice: int.parse(model['book_buyprice']),
        book_rentprice: int.parse(model['book_rentprice']),
        book_image: model['book_image'],
        book_rentdue: model['book_rentdue'],
        book_rentduration: model['book_rentduration'],
        book_description: model['book_description'],
        book_user_image: model['book_user_image'],
        book_condition: model['book_condition'],
        product_quantity: int.parse(model['product_quantity']),
      )));
    } else {
      throw Exception('Failed to load book items');
    }
  }

  Future<void> _updateBookQuantity(int bookId, int quantity) async {
    final response = await http.post(
      Uri.parse('https://zenenix.helioho.st/serve/carting_item/carting_itemupdate.php?book_id=$bookId&user_username=${widget.username}&product_quantity=$quantity'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
    );

    if (response.statusCode == 200) {
      // Handle success
      print('Quantity updated successfully.');
    } else {
      // Handle failure
      print('Failed to update quantity.');
    }
  }

  Future<void> _deleteSelectedItems() async {
    List<BookItem> selectedItems = (await _bookItems).where((book) => book.isChecked).toList();
    List<int> selectedIds = selectedItems.map((item) => item.book_id).toList();

    final response = await http.post(
      Uri.parse('https://zenenix.helioho.st/serve/carting_item/carting_itemdelete.php?user_username=${widget.username}'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode({
        'user_username': widget.username,
        'book_ids': selectedIds,
      }),
    );

    if (response.statusCode == 200) {
      setState(() {
        _bookItems = _fetchBookItems();
      });
      print('Items deleted successfully.');
    } else {
      print('Failed to delete items.');
    }
  }

  void _updateTotalPrice() {
    int total = 0;
    _bookItems.then((books) {
      for (var book in books) {
        if (book.isChecked) {
          total += book.book_buyprice * book.product_quantity;
        }
      }
      setState(() {
        _totalPrice = total;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 255, 255, 255),
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: Color(0xFF393742),
        title: Text(
          'Libroo',
          style: TextStyle(color: Colors.white),
        ),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Row(
              children: [
                IconButton(
                  icon: Icon(Icons.sort, color: Colors.black),
                  onPressed: () {
                    _showSortingOptions(context);
                  },
                ),
                IconButton(
                  icon: Icon(Icons.delete, color: Colors.red),
                  onPressed: () {
                    _deleteSelectedItems();
                  },
                ),
              ],
            ),
          ),
          Divider(),
          Expanded(
            child: FutureBuilder<List<BookItem>>(
              future: _bookItems,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const CircularProgressIndicator();
                } else if (snapshot.hasError) {
                  return Text('Error: ${snapshot.error}');
                } else {
                  return ListView.builder(
                    itemCount: snapshot.data!.length,
                    itemBuilder: (context, index) {
                      var book = snapshot.data![index];

                      return Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
                        child: Container(
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(0),
                          ),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Checkbox(
                                value: book.isChecked,
                                onChanged: (value) {
                                  setState(() {
                                    book.isChecked = value!;
                                    _updateTotalPrice();
                                  });
                                },
                              ),
                              Padding(
                                padding: EdgeInsets.fromLTRB(0, 12.0, 10, 12.0),
                                child: Image.network(
                                  book.book_image,
                                  height: 100,
                                  width: 90,
                                  fit: BoxFit.cover,
                                ),
                              ),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      book.book_title,
                                      style: TextStyle(
                                        color: Color.fromARGB(255, 57, 55, 66),
                                        fontWeight: FontWeight.bold,
                                        fontSize: 16,
                                      ),
                                    ),
                                    SizedBox(height: 1),
                                    Row(
                                      children: [
                                        Column(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            SizedBox(
                                              width: 90,
                                              child: Column(
                                                crossAxisAlignment: CrossAxisAlignment.start,
                                                children: [
                                                  Row(
                                                    children: [
                                                      Icon(
                                                        Icons.shopping_cart,
                                                        size: 17,
                                                        color: Color.fromARGB(255, 57, 55, 66),
                                                      ),
                                                      Text(
                                                        'Buy Price',
                                                        style: TextStyle(
                                                          color: Color.fromARGB(255, 57, 55, 66),
                                                          fontSize: 14,
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                  Text(
                                                    '₱${book.book_buyprice}',
                                                    style: TextStyle(
                                                      color: Color.fromARGB(255, 57, 55, 66),
                                                      fontSize: 14,
                                                      fontWeight: FontWeight.bold,
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ],
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.fromLTRB(10, 23, 0, 0),
                                          child: Column(
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                            children: [
                                              Row(
                                                children: [
                                                  Icon(
                                                    Icons.receipt,
                                                    size: 17,
                                                    color: Color.fromARGB(255, 57, 55, 66),
                                                  ),
                                                  Text(
                                                    'Rental Price',
                                                    style: TextStyle(
                                                      color: Color.fromARGB(255, 57, 55, 66),
                                                      fontSize: 14,
                                                    ),
                                                  ),
                                                ],
                                              ),
                                              SizedBox(
                                                width: 105,
                                                child: Text(
                                                  '₱ ${book.book_rentprice} / ${book.book_rentdue}',
                                                  style: TextStyle(
                                                    color: Color.fromARGB(255, 57, 55, 66),
                                                    fontSize: 14,
                                                    fontWeight: FontWeight.bold,
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                    SizedBox(height: 10),
                                    Column(
                                      crossAxisAlignment: CrossAxisAlignment.end,
                                      children: [
                                        SizedBox(
                                          child: Row(
                                            crossAxisAlignment: CrossAxisAlignment.center,
                                            children: [
                                              GestureDetector(
                                                onTap: () {
                                                  setState(() {
                                                    if (book.product_quantity > 0) {
                                                      book.product_quantity--;
                                                      _updateTotalPrice();
                                                      _updateBookQuantity(book.book_id, book.product_quantity);
                                                    }
                                                  });
                                                },
                                                child: Container(
                                                  color: Color.fromARGB(255, 57, 55, 66),
                                                  width: 20,
                                                  height: 20,
                                                  child: Icon(
                                                    Icons.remove,
                                                    color: Colors.white,
                                                    size: 20,
                                                  ),
                                                ),
                                              ),
                                              Padding(
                                                padding: const EdgeInsets.fromLTRB(20, 0, 20, 0),
                                                child: Text(
                                                  "${book.product_quantity}",
                                                  style: TextStyle(
                                                    fontSize: 20,
                                                    fontWeight: FontWeight.bold,
                                                  ),
                                                ),
                                              ),
                                              GestureDetector(
                                                onTap: () {
                                                  setState(() {
                                                    book.product_quantity++;
                                                    _updateTotalPrice();
                                                    _updateBookQuantity(book.book_id, book.product_quantity);
                                                  });
                                                },
                                                child: Container(
                                                  color: Color.fromARGB(255, 57, 55, 66),
                                                  width: 20,
                                                  height: 20,
                                                  child: Icon(
                                                    Icons.add,
                                                    color: Colors.white,
                                                    size: 20,
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  );
                }
              },
            ),
          ),
        ],
      ),
      bottomNavigationBar: BottomAppBar(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Text(
                'Total Price: ₱$_totalPrice',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: ElevatedButton(
                onPressed: () {
                  _bookItems.then((books) {
                    List<BookItem> selectedItems = books.where((book) => book.isChecked).toList();
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => CheckoutPage(selectedItems: selectedItems),
                      ),
                    );
                  });
                },
                child: Text('Checkout'),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _showSortingOptions(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (context) {
        return Container(
          height: 150,
          color: Colors.white,
          child: Column(
            children: [
              ListTile(
                title: const Text('Sort by Title'),
                onTap: () {
                  Navigator.pop(context);
                  setState(() {
                    _bookItems = _fetchBookItemsSortedByTitle();
                  });
                },
              ),
              ListTile(
                title: const Text('Sort by Genre'),
                onTap: () {
                  Navigator.pop(context);
                  setState(() {
                    _bookItems = _fetchBookItemsSortedByGenre();
                  });
                },
              ),
            ],
          ),
        );
      },
    );
  }

  Future<List<BookItem>> _fetchBookItemsSortedByTitle() async {
    final response = await http.get(Uri.parse('https://devlab.helioho.st/serve/readbooks.php?sort=title'));
    if (response.statusCode == 200) {
      Iterable data = json.decode(response.body);
      return List<BookItem>.from(data.map((model) => BookItem(
        book_id: model['book_id'],
        book_title: model['book_title'],
        book_genre: model['book_genre'],
        book_user: model['book_user'],
        book_location: model['book_location'],
        book_buyprice: model['book_buyprice'],
        book_rentprice: model['book_rentprice'],
        book_image: model['book_image'],
        book_rentdue: model['book_rentdue'],
        book_rentduration: model['book_rentduration'],
        book_description: model['book_description'],
        book_user_image: model['book_user_image'],
        book_condition: model['book_condition'],
        product_quantity: model['product_quantity'],
      )));
    } else {
      throw Exception('Failed to load book items');
    }
  }

  Future<List<BookItem>> _fetchBookItemsSortedByGenre() async {
    final response = await http.get(Uri.parse('https://devlab.helioho.st/serve/readbooks.php?sort=genre'));
    if (response.statusCode == 200) {
      Iterable data = json.decode(response.body);
      return List<BookItem>.from(data.map((model) => BookItem(
        book_id: model['book_id'],
        book_title: model['book_title'],
        book_genre: model['book_genre'],
        book_user: model['book_user'],
        book_location: model['book_location'],
        book_buyprice: model['book_buyprice'],
        book_rentprice: model['book_rentprice'],
        book_image: model['book_image'],
        book_rentdue: model['book_rentdue'],
        book_rentduration: model['book_rentduration'],
        book_description: model['book_description'],
        book_user_image: model['book_user_image'],
        book_condition: model['book_condition'],
        product_quantity: model['product_quantity'],
      )));
    } else {
      throw Exception('Failed to load book items');
    }
  }
}
