import 'package:flutter/material.dart';
import 'payment.dart';
import 'rental.dart'; // Import the rental page

class BookDetailsPage extends StatelessWidget {
  final String title;
  final String genreText;
  final String userText;
  final String locationText;
  final String price;
  final String rentPrice;
  final String imagePath;

  BookDetailsPage({
    required this.title,
    required this.genreText,
    required this.userText,
    required this.locationText,
    required this.price,
    required this.rentPrice,
    required this.imagePath,
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
    }
  }

  void _showPurchaseDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text("Confirm Purchase"),
          content: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Text("Book: $title"),
              Text("Price: $price"),
              SizedBox(height: 20),
              Text("Are you sure you want to buy this book?"),
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
                      bookTitle: title,
                      bookPrice: price,
                      userText: userText,
                      imagePath: imagePath,
                    ),
                  ),
                ); // Navigate to PaymentPage with book details
              },
              child: Text("Buy"),
            ),
            TextButton(
              onPressed: () {
                Navigator.pop(context); // Close the dialog
              },
              child: Text("Cancel"),
            ),
          ],
        );
      },
    );
  }

  void _showRentDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text("Confirm Rental"),
          content: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Text("Book: $title"),
              Text("Rental Price: $rentPrice"),
              SizedBox(height: 20),
              Text("Are you sure you want to rent this book?"),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context); // Close the dialog
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => RentalPage(
                      bookTitle: title,
                      rentPrice: rentPrice,
                      userText: userText,
                      imagePath: imagePath,
                    ),
                  ),
                ); // Navigate to RentalPage with book details
              },
              child: Text("Rent"),
            ),
            TextButton(
              onPressed: () {
                Navigator.pop(context); // Close the dialog
              },
              child: Text("Cancel"),
            ),
          ],
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
        child: Padding(
          padding: const EdgeInsets.all(16.0),
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
              Text(
                price,
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 16),
              Padding(
                padding: const EdgeInsets.only(bottom: 30.0), // Add margin at the bottom
                child: Text(
                  rentPrice,
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              Text(
                title,
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 8),
              Text(
                genreText,
                style: TextStyle(
                  fontSize: 16,
                ),
              ),
              SizedBox(height: 8),
              Text(
                userText,
                style: TextStyle(
                  fontSize: 16,
                ),
              ),
              SizedBox(height: 8),
              Text(
                locationText,
                style: TextStyle(
                  fontSize: 16,
                ),
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: CustomBottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.shopping_cart, color: Colors.white), // Change icon color to white
            label: 'Buy',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.receipt, color: Colors.white), // Change icon color to white
            label: 'Rent',
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

  const CustomBottomNavigationBar({
    Key? key,
    required this.items,
    required this.currentIndex,
    this.onTap,
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