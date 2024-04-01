import 'package:flutter/material.dart';
import 'checkout.dart';

class CartingPage extends StatefulWidget {
  const CartingPage({Key? key}) : super(key: key);

  @override
  _CartingPageState createState() => _CartingPageState();
}

class _CartingPageState extends State<CartingPage> {
  List<BookItem> _selectedItems = [];
  List<bool> _isSelected = [false, false];
  bool _isAllSelected = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xFF393742), // Match the color of the bottom navigation bar
        title: Text(
          'Carting', // Change the title text to "Carting"
          style: TextStyle(color: Colors.white), // Make the title text color white
        ),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Row(
              children: [
                Expanded(
                  child: Container(
                    decoration: BoxDecoration(
                      color: Color.fromARGB(255, 223, 223, 223),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: TextField(
                      style: TextStyle(color: Colors.black),
                      decoration: InputDecoration(
                        hintText: 'Search Carting',
                        hintStyle: TextStyle(color: Colors.black),
                        prefixIcon: Icon(Icons.search, color: Colors.black),
                        border: InputBorder.none,
                      ),
                    ),
                  ),
                ),
                IconButton(
                  icon: Icon(Icons.delete, color: Colors.black),
                  onPressed: () {
                    _showDeleteConfirmationDialog(context);
                  },
                ),
              ],
            ),
          ),
          const Divider(),
          Expanded(
            child: ListView(
              children: [
                BookItem(
                  title: 'Pinagyamang Pluma 9',
                  number: 1,
                  imagePath:
                      'https://raw.githubusercontent.com/RJSeebs02/LibrooImages/main/img1.png',
                  genreText: 'Genre: Academic',
                  userText: 'Posted by: Romeo Seva III',
                  locationText: 'Silay City',
                  price: '350.00',
                  rentPrice: '₱50.00/week in 2 months',
                  quantity: '1',
                  process: 'To Buy',
                  isSelected: _isSelected[0],
                  onChanged: (value) {
                    setState(() {
                      _isSelected[0] = value!;
                      _isAllSelected = _isSelected.every((element) => element);
                    });
                  },
                ),
                const Divider(),
                BookItem(
                  title: 'Kayamanan',
                  number: 2,
                  imagePath:
                      'https://raw.githubusercontent.com/RJSeebs02/LibrooImages/main/img2.jpg',
                  genreText: 'Genre: Academic',
                  userText: 'Posted by: Russ Allen Garde',
                  locationText: 'Bacolod City',
                  price: '300.00',
                  rentPrice: '50.00/week in 2 months',
                  quantity: '1',
                  process: 'To Buy',
                  isSelected: _isSelected[1],
                  onChanged: (value) {
                    setState(() {
                      _isSelected[1] = value!;
                      _isAllSelected = _isSelected.every((element) => element);
                    });
                  },
                ),
                const Divider(),
              ],
            ),
          ),
          Container(
            color: Color.fromARGB(255, 57, 55, 66),
            padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                GestureDetector(
                  onTap: () {
                    setState(() {
                      _isAllSelected = !_isAllSelected;
                      _isSelected = List.filled(_isSelected.length, _isAllSelected);
                    });
                  },
                  child: Row(
                    children: [
                      Checkbox(
  value: _isAllSelected,
  onChanged: (_) {
    setState(() {
      _isAllSelected = !_isAllSelected;
      _isSelected = List.filled(_isSelected.length, _isAllSelected);
    });
  },
  checkColor: Color(0xFF393742), // Change the color of the checkmark
  activeColor: Color(0xFFFFD3AF), // Change the color of the checkbox when selected
  materialTapTargetSize: MaterialTapTargetSize.shrinkWrap, // Removes extra padding
  side: BorderSide(color: _isAllSelected ? Colors.white : Colors.grey), // Specify the border color
),

                      Text(
                        'All',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 18,
                          color: Colors.white,
                        ),
                      ),
                    ],
                  ),
                ),
                Text(
                  'Total: ₱${_calculateTotalCost()}',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 18,
                    color: Colors.white,
                  ),
                ),
                SizedBox(
                  width: 120, // Adjust the width as needed
                  child: ElevatedButton(
                    onPressed: _checkout, // Call _checkout function here
                    child: Text('Check Out',
                    style: TextStyle(color: Color.fromARGB(255, 57, 55, 66)),),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  void _showDeleteConfirmationDialog(BuildContext context) {
    bool anyItemSelected = _isSelected.any((element) => element);
    if (!anyItemSelected) {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text("No item selected"),
            content: Text("Please select at least one item to proceed."),
            actions: <Widget>[
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: Text("OK"),
              ),
            ],
          );
        },
      );
    } else {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text("Confirm Delete"),
            content: Text("Are you sure you want to delete the selected item/s from your cart?"),
            actions: <Widget>[
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: Text("Cancel"),
              ),
              TextButton(
                onPressed: () {
                  // Perform delete operation here
                  // For now, let's just clear the selection
                  setState(() {
                    _isSelected = List<bool>.filled(_isSelected.length, false);
                    _isAllSelected = false;
                  });
                  Navigator.of(context).pop();
                },
                child: Text("Delete"),
              ),
            ],
          );
        },
      );
    }
  }

  void _checkout() {
    bool atLeastOneSelected = _isSelected.any((element) => element);
    if (atLeastOneSelected) {
      _selectedItems.clear();
      for (int i = 0; i < _isSelected.length; i++) {
        if (_isSelected[i]) {
          _selectedItems.add(_buildBookItem(i));
        }
      }
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => CheckoutPage(selectedItems: _selectedItems),
        ),
      );
    } else {
      // Show dialog box
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text("No item selected"),
            content: Text("Please select at least one item to proceed."),
            actions: <Widget>[
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: Text("OK"),
              ),
            ],
          );
        },
      );
    }
  }

  BookItem _buildBookItem(int index) {
    switch (index) {
      case 0:
        return BookItem(
          title: 'Pinagyamang Pluma 9',
          number: 1,
          imagePath:
              'https://raw.githubusercontent.com/RJSeebs02/LibrooImages/main/img1.png',
          genreText: 'Genre: Academic',
          userText: 'Posted by: Romeo Seva III',
          locationText: 'Silay City',
          price: 'Price: ₱350.00',
          rentPrice: 'Rental Price: ₱50.00/week in 2 months',
          quantity: '1',
          process: 'To Buy',
          isSelected: true,
          onChanged: (_) {},
        );
      case 1:
        return BookItem(
          title: 'Kayamanan',
          number: 2,
          imagePath:
              'https://raw.githubusercontent.com/RJSeebs02/LibrooImages/main/img2.jpg',
          genreText: 'Genre: Academic',
          userText: 'Posted by: Russ Allen Garde',
          locationText: 'Bacolod City',
          price: 'Price: ₱300.00',
          rentPrice: 'Rental Price: ₱50.00/week in 2 months',
          quantity: '1',
          process: 'To Buy',
          isSelected: true,
          onChanged: (_) {},
        );
      default:
        throw Exception("Invalid index: $index");
    }
  }

  String _calculateTotalCost() {
    double totalCost = 0;
    for (int i = 0; i < _isSelected.length; i++) {
      if (_isSelected[i]) {
        // Add the price of the selected book to the total cost
        if (i == 0) {
          totalCost += 350;
        } else if (i == 1) {
          totalCost += 300;
        }
      }
    }
    return totalCost.toStringAsFixed(2);
  }
}

class BookItem extends StatelessWidget {
  final String title;
  final int number;
  final String imagePath;
  final String genreText;
  final String userText;
  final String locationText;
  final String price;
  final String rentPrice;
  final bool isSelected;
  final ValueChanged<bool?> onChanged;
  final String quantity;
  final String process;

  const BookItem({
    required this.title,
    required this.number,
    required this.imagePath,
    required this.genreText,
    required this.userText,
    required this.locationText,
    required this.price,
    required this.rentPrice,
    required this.isSelected,
    required this.onChanged,
    required this.quantity,
    required this.process,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 0, vertical: 0),
      child: GestureDetector(
        onTap: () {
          // Navigate to the book details page and pass the book details
          // Navigator.push(
          //   context,
          //   MaterialPageRoute(builder: (context) => BookDetailsPage(
          //     title: title,
          //     genreText: genreText,
          //     userText: userText,
          //     locationText: locationText,
          //     price: price,
          //     rentPrice: rentPrice,
          //     imagePath: imagePath, // Pass the image path
          //   )),
          // );
        },
        child: Column(
          children: [
            Container(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Expanded(
                    flex: 0,
                    child: Checkbox(
                      value: isSelected,
                      onChanged: onChanged,
                      activeColor: Color(0xFF393742), // Change the color of the checkmark
                      checkColor: Color(0xFFFFD3AF),
                    ),
                  ),
                  Expanded(
                    flex: 2,
                    child: Image.network(
                      imagePath,
                      height: 250,
                      width: 140,
                      fit: BoxFit.contain,
                    ),
                  ),
                  Expanded(
                    flex: 3,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            title,
                            style: TextStyle(
                              color: Color.fromARGB(255, 57, 55, 66),
                              fontWeight: FontWeight.bold,
                              fontSize: 24,
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(top: 0),
                            child: Text(
                              'Price: ' + price,
                              style: TextStyle(
                                color: Color.fromARGB(255, 57, 55, 66),
                                fontSize: 14,
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(top: 10),
                            child: Text(
                              'Quantity: ' + quantity.toString(),
                              style: TextStyle(
                                color: Color.fromARGB(255, 57, 55, 66),
                                fontSize: 14,
                              ),
                            ),
                          ),
                          SizedBox(height: 25),
                          Row(
                            children: [
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  SizedBox(
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
                                              'Process',
                                              style: TextStyle(
                                                color: Color.fromARGB(255, 57, 55, 66),
                                                fontSize: 14,
                                              ),
                                            ),
                                          ],
                                        ),
                                        Text(
                                          process,
                                          style: TextStyle(
                                            color: Color.fromARGB(255, 57, 55, 66),
                                            fontSize: 14,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                      ]
                                    ),
                                  ),
                                ],
                              ),
                              Padding(
                                padding: const EdgeInsets.only(left: 8),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Row(
                                      children: [
                                        Icon(
                                          Icons.attach_money,
                                          size: 17,
                                          color: Color.fromARGB(255, 57, 55, 66)
                                        ),
                                        Text(
                                          'Total Price',
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
                                        '₱' + price,
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
                          SizedBox(height: 20),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

void main() {
  runApp(MaterialApp(
    home: CartingPage(),
  ));
}
