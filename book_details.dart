import 'package:flutter/material.dart';
import 'dart:convert'; // For jsonEncode
import 'payment.dart';
import 'rental.dart';
import 'chat_details.dart';
import 'package:http/http.dart' as http; // For making HTTP requests

class BookDetailsPage extends StatefulWidget {
  final int bookId;

  BookDetailsPage({required this.bookId});

  @override
  _BookDetailsPageState createState() => _BookDetailsPageState();
}

class _BookDetailsPageState extends State<BookDetailsPage> {
  late Future<Book> futureBook;
  int quantity = 1; // Define and initialize the quantity variable

  @override
  void initState() {
    super.initState();
    futureBook = fetchBookDetails(widget.bookId);
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

  int _selectedIndex = 0; // Current selected index for bottom navigation bar
  void _onItemTapped(int index, BuildContext context) {
    // Handle bottom navigation bar item tap
    _selectedIndex = index;
    if (_selectedIndex == 0) {
      
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => ChatDetailsPage(
                      user: {
                        'name': '',
                        'image': '',
                        'status': 'Online',
                      },
                    ),
                  ),
                ); // Navigate to RentalPage with book details
    } else if (_selectedIndex == 1) {
      ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        backgroundColor:Color.fromARGB(255, 57, 55, 66),
        content: Center(child: Text('Added to cart')),
        duration: Duration(seconds: 2),
      ),
    );
    }
  }

  void _showChatDialog(BuildContext context, AsyncSnapshot<Book> snapshot) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        final book = snapshot.data!;

        return AlertDialog(
          title: Text("Message Seller?"),
          content: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Text('${book.user}'),
              Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ElevatedButton(
                  onPressed: () {
                    // Handle button press
                  },
                  child: Text('Yes'),
                ),
                ElevatedButton(
                  onPressed: () {
                    // Handle button press
                  },
                  child: Text('No'),
                ),
              ],
            ),
            ],
          ),
        );
      },
    );
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Book Details',
          style: TextStyle(color: Colors.white), // Text color set to white
        ),
        backgroundColor: Color.fromARGB(255, 57, 55, 66), // AppBar color set to grey
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
                          SizedBox(height: 8),
                          Image.network(
                            '${book.image}',
                            height: 350,
                            width: double.infinity,
                            fit: BoxFit.contain,
                          ),
                          SizedBox(height: 8),
                          Container(
                            width: double.infinity,
                            color: Color.fromARGB(255, 57, 55, 66),
                            child: Padding(
              padding: const EdgeInsets.fromLTRB(8, 12, 8, 12),
              child: Text(
                '${book.title}',
                style: TextStyle(
                  fontSize: 24,
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(left: 10.0),
                            child: Row(
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Icon(
                            Icons.shopping_cart,
                            size: 17,
                            color: Color.fromARGB(255, 57, 55, 66)
                          ),
                          Text(
                            'Buy Price',
                            style: TextStyle(
                              color: Color.fromARGB(255, 57, 55, 66),
                              fontSize: 20,
                            ),
                          ),
                        ],
                      ),
                      Text(
                        '₱' + '${book.buyprice}',
                        style: TextStyle(
                          color: Color.fromARGB(255, 57, 55, 66),
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(10, 25, 10, 0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Icon(
                              Icons.receipt,
                              size: 17,
                              color: Color.fromARGB(255, 57, 55, 66)
                            ),
                            Text(
                              'Rental Price',
                              style: TextStyle(
                                color: Color.fromARGB(255, 57, 55, 66),
                                fontSize: 20,
                              ),
                            ),
                          ],
                        ),
                        SizedBox(
                          width: 150,
                          child: Text(
                            '₱' + '${book.rentprice}' + "/" + '${book.rentdue}',
                            style: TextStyle(
                              color: Color.fromARGB(255, 57, 55, 66),
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        Text(
                          'in ' + '${book.rentduration}',
                          style: TextStyle(
                            color: Color.fromARGB(255, 57, 55, 66),
                            fontSize: 20,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
                            ),
                          ),
                          SizedBox(height: 8),
                          Divider(),
              
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.fromLTRB(10, 5, 10, 5),
                    child: Text(
                      'Genre: ' + '${book.genre}',
                      style: TextStyle(
                        fontSize: 16,
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(10, 5, 10, 5),
                    child: Text(
                      'Condition: ' + '${book.condition}',
                      style: TextStyle(
                        fontSize: 16,
                    ),
                    ),
                  ),
                ],
              ),
              Column(
                children: [
                  Container(
                  color: Color(0xFF393742),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        MaterialButton(
                          padding: EdgeInsets.symmetric(vertical: 4),
                          materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                          onPressed: () { // Close the bottom sheet
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => PaymentPage(
                        book_id: book.id,
                        quantity: quantity,
                      ),
                    ),
                  ); // Na
                          },
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(
                                Icons.shopping_bag, color: Colors.white
                              ),
                              Text(
                                'Buy',
                                style: TextStyle(fontSize: 16, color: Colors.white),
                              ),
                            ],
                          ),
                        ),
                        MaterialButton(
                          padding: EdgeInsets.symmetric(vertical: 4),
                          materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                          onPressed: () {// Close the bottom sheet
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => RentalPage(
                        book_id: book.id,
                        quantity: quantity,
                      ),
                    ),
                  ); // Na
                          },
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(
                                Icons.receipt, color: Colors.white
                              ),
                              Text(
                                'Rent',
                                style: TextStyle(fontSize: 16, color: Colors.white),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(height: 10),
                Text(
                  "Quantity: ",
                  style: TextStyle(
                    fontSize: 16,
                    color: Color.fromARGB(255, 57, 55, 66),
                    fontWeight: FontWeight.bold,
                  ),
                  ),
                SizedBox(height: 10),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      color: Color.fromARGB(255, 57, 55, 66),
                      child: IconButton(
                        onPressed: () {
                          setState(() {
                            if (quantity > 1) {
                              quantity--;
                            }
                          });
                        },
                        icon: Icon(
                          Icons.remove,
                          color: Colors.white,
                          size: 20,
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(20, 0, 20, 0),
                      child: Text(
                        "$quantity",
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold
                        ),
                      ),
                    ),
                    Container(
                      decoration: BoxDecoration(
                        color: Color.fromARGB(255, 57, 55, 66),
                      ),
                      child: IconButton(
                        onPressed: () {
                          setState(() {
                            quantity++;
                          });
                        },
                        icon: Icon(Icons.add,
                          color: Colors.white,
                          size: 20,
                        ),
                      ),
                    ),
                  ],
                ),
                ]
              ),
                            ],
                          ),
                          
                          Divider(),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(
              'Posted by:',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
                            child: Row(
              children: [
                CircleAvatar(
                  radius: 30,
                  backgroundImage: NetworkImage('${book.user_image}'),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 10.0),
                  child: Text(
                    '${book.user}',
                    style: TextStyle(
                      fontSize: 16,
                    ),
                  ),
                ),
              ],
                            ),
                          ),
                          SizedBox(height: 8),
                          Padding(
                            padding: const EdgeInsets.all(10.0),
                            child: Row(
              children: [
                Icon(
                  Icons.location_on,
                  size: 20,
                  color: Color.fromARGB(255, 57, 55, 66),
                ),
                Text(
                  '${book.location}',
                  style: TextStyle(
                    fontSize: 16,
                  ),
                ),
              ],
                            ),
                          ),
                          Divider(),
                          Padding(
                            padding: const EdgeInsets.all(10.0),
                            child: SizedBox(
              width: double.infinity,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Description',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Text(
                    '${book.description}',
                    style: TextStyle(
                      fontSize: 16,
                    ),
                  ),
                ]
              ),
                            ),
                          )
                        ],
                      );
            }
          },
        ),
      ),
      bottomNavigationBar: CustomBottomNavigationBar(
        color: Color.fromARGB(255, 57, 55, 66),
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.chat, color: Colors.white), // Change icon color to white
            label: 'Chat',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.add_shopping_cart, color: Color.fromRGBO(255, 211, 175, 1)), // Change icon color to white
            label: 'Add to Cart',
          ),
        ],
        currentIndex: _selectedIndex,
        onTap: (index) => _onItemTapped(index, context),
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

class CustomBottomNavigationBar extends StatelessWidget {
  final List<BottomNavigationBarItem> items;
  final int currentIndex;
  final ValueChanged<int>? onTap;
  final Color color;
  const CustomBottomNavigationBar({
    Key? key,
    required this.items,
    required this.currentIndex,
    this.onTap,
    required this.color,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return BottomAppBar(
      color: Color.fromARGB(255, 57, 55, 66), // Change bottom bar color to black
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: items.map((item) {
          final index = items.indexOf(item);
          return GestureDetector(
            onTap: () => onTap!(index),
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 8.0),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  item.icon!,
                  if (item.label != null)
                    Expanded(
                      child: Text(
                        item.label!,
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: Colors.white, // Change text color to white
                        ),
                      ),
                    ),
                ],
              ),
            ),
          );
        }).toList(),
      ),
    );
  }
}


