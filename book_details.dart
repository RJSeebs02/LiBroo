import 'package:flutter/material.dart';
import 'payment.dart';
import 'rental.dart';
import 'chat_details.dart';

class BookDetailsPage extends StatelessWidget {
  final String title;
  final String genreText;
  final String userText;
  final String locationText;
  final String price;
  final String rentPrice;
  final String imagePath;
  final String rentDue;
  final String rentTotalDue;
  final String description;
  final String userImage;
  final String condition;

  BookDetailsPage({
    required this.title,
    required this.genreText,
    required this.userText,
    required this.locationText,
    required this.price,
    required this.rentPrice,
    required this.imagePath,
    required this.rentDue,
    required this.rentTotalDue,
    required this.description,
    required this.userImage,
    required this.condition,
    
  });

  int _selectedIndex = 0; // Current selected index for bottom navigation bar

  void _onItemTapped(int index, BuildContext context) {
    // Handle bottom navigation bar item tap
    _selectedIndex = index;
    if (_selectedIndex == 0) {
      // Buy option selected
      _showPurchaseDialog(context);
    } else if (_selectedIndex == 1) {
      // Rent option selected
      _showRentDialog(context);
    } else if (_selectedIndex == 2) {
      
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => ChatDetailsPage(
                      user: {
                        'name': userText,
                        'image': userImage,
                        'status': 'Online',
                      },
                    ),
                  ),
                ); // Navigate to RentalPage with book details
    } else if (_selectedIndex == 3) {
      ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        backgroundColor:Color.fromARGB(255, 57, 55, 66),
        content: Center(child: Text('Added to cart')),
        duration: Duration(seconds: 2),
      ),
    );
    }
  }

  void _showPurchaseDialog(BuildContext context) {
  int quantity = 1; // Default quantity
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return StatefulBuilder(
        builder: (context, setState) {
          return AlertDialog(
            title: Text("Confirm Purchase"),
            content: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Divider(),
                Text(
                  "$title",
                  style: TextStyle(
                    fontSize: 20,
                    color: Color.fromARGB(255, 57, 55, 66),
                    fontWeight: FontWeight.bold,
                  ),
                  ),
                SizedBox(height: 10),
                Text(
                  "Price: ₱$price",
                  style: TextStyle(
                    fontSize: 16,
                    color: Color.fromARGB(255, 57, 55, 66),
                  ),
                  ),
                SizedBox(height: 40),
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
              ],
            ),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.pop(context); // Close the bottom sheet
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => PaymentPage(
                        title: title,
                        genreText: genreText,
                        userText: userText,
                        locationText: locationText,
                        price: price,
                        imagePath: imagePath,
                        description: description,
                        userImage: userImage,
                        condition: condition,
                        quantity: quantity,
                      ),
                    ),
                  ); // Navigate to PaymentPage with book details
                },
                child: Text(
                  "Buy",
                  style: TextStyle(
                    fontSize: 14,
                    color: Color.fromARGB(255, 57, 55, 66),
                  ),
                ),
              ),
              TextButton(
                onPressed: () {
                  Navigator.pop(context); // Close the dialog
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
  );
}


  void _showRentDialog(BuildContext context) {
  int quantity = 1; // Default quantity
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return StatefulBuilder(
        builder: (context, setState) {
          return AlertDialog(
            title: Text("Confirm Rental"),
            content: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Divider(),
                Text(
                  "$title",
                  style: TextStyle(
                    fontSize: 20,
                    color: Color.fromARGB(255, 57, 55, 66),
                    fontWeight: FontWeight.bold,
                  ),
                  ),
                SizedBox(height: 10),
                Text(
                  "Rent Price: ₱$rentPrice /$rentDue in $rentTotalDue",
                  style: TextStyle(
                    fontSize: 16,
                    color: Color.fromARGB(255, 57, 55, 66),
                  ),
                  ),
                SizedBox(height: 40),
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
              ],
            ),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.pop(context); // Close the bottom sheet
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => RentalPage(
                        title: title,
                        genreText: genreText,
                        userText: userText,
                        locationText: locationText,
                        rentPrice: rentPrice,
                        rentDue: rentDue,
                        rentTotalDue: rentTotalDue,
                        imagePath: imagePath,
                        description: description,
                        userImage: userImage,
                        condition: condition,
                        quantity: quantity,
                      ),
                    ),
                  ); // Navigate to PaymentPage with book details
                },
                child: Text(
                  "Buy",
                  style: TextStyle(
                    fontSize: 14,
                    color: Color.fromARGB(255, 57, 55, 66),
                  ),
                  ),
              ),
              TextButton(
                onPressed: () {
                  Navigator.pop(context); // Close the dialog
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
  );
}

  void _showChatDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text("Message Seller?"),
          content: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Text("$userText"),
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
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 8),
            Image.network(
              imagePath,
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
                  title,
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
                          '₱' + price,
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
                              '₱' + rentPrice + "/" + rentDue,
                              style: TextStyle(
                                color: Color.fromARGB(255, 57, 55, 66),
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                          Text(
                            'in ' + rentTotalDue,
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
            Padding(
              padding: const EdgeInsets.fromLTRB(10, 5, 10, 5),
              child: Text(
                'Genre: ' + genreText,
                style: TextStyle(
                  fontSize: 16,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(10, 5, 10, 5),
              child: Text(
                'Condition: ' + condition,
                style: TextStyle(
                  fontSize: 16,
                ),
              ),
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
                    backgroundImage: NetworkImage(userImage),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 10.0),
                    child: Text(
                      userText,
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
                    locationText,
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
                      description,
                      style: TextStyle(
                        fontSize: 16,
                      ),
                    ),
                  ]
                ),
              ),
            )
          ],
        ),
      ),
      bottomNavigationBar: CustomBottomNavigationBar(
        color: Color.fromARGB(255, 57, 55, 66),
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.shopping_cart, color: Colors.white), // Change icon color to white
            label: 'Buy',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.receipt, color: Colors.white), // Change icon color to white
            label: 'Rent',
          ),
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