import 'package:flutter/material.dart';

class CartingPage extends StatefulWidget {
  const CartingPage({Key? key}) : super(key: key);

  @override
  _CartingPageState createState() => _CartingPageState();
}

class _CartingPageState extends State<CartingPage> {
  List<bool> _isSelected = [false, false];
  bool _isAllSelected = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Carting'),
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
                        hintText: 'Search Books',
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
                  price: 'Price: ₱350.00',
                  rentPrice: 'Rental Price: ₱50.00/week in 2 months',
                  isSelected: _isSelected[0],
                  onChanged: (value) {
                    setState(() {
                      _isSelected[0] = value!;
                      _isAllSelected = _isSelected.every((element) => element);
                    });
                  },
                ),
                BookItem(
                  title: 'Kayamanan',
                  number: 2,
                  imagePath:
                      'https://raw.githubusercontent.com/RJSeebs02/LibrooImages/main/img2.jpg',
                  genreText: 'Genre: Academic',
                  userText: 'Posted by: Russ Allen Garde',
                  locationText: 'Bacolod City',
                  price: 'Price: ₱300.00',
                  rentPrice: 'Rental Price: ₱50.00/week in 2 months',
                  isSelected: _isSelected[1],
                  onChanged: (value) {
                    setState(() {
                      _isSelected[1] = value!;
                      _isAllSelected = _isSelected.every((element) => element);
                    });
                  },
                ),
              ],
            ),
          ),
          Container(
            color: Colors.grey[300],
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
                      ),
                      Text(
                        'All',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 18,
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
                  ),
                ),
                SizedBox(
                  width: 120, // Adjust the width as needed
                  child: ElevatedButton(
                    onPressed: () {
                      // Add checkout functionality
                    },
                    child: Text('Check Out'),
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
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: Text("Confirm Delete"),
        content: Text("Are you sure you want to delete the selected items from your cart?"),
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
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
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
        child: Container(
          height: 250,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(0),
          ),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8.0),
                  child: Checkbox(
                    value: isSelected,
                    onChanged: onChanged,
                  ),
                ),
              ),
              Expanded(
                flex: 1,
                child: Image.network(
                  imagePath,
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
                        title,
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
                          genreText,
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
                          userText,
                          style: TextStyle(
                            color: Color.fromARGB(255, 57, 55, 66),
                            fontSize: 16,
                          ),
                        ),
                      ),
                      SizedBox(height: 8),
                      Text(
                        locationText,
                        style: TextStyle(
                          color: Color.fromARGB(255, 57, 55, 66),
                          fontSize: 16,
                        ),
                      ),
                      SizedBox(height: 8),
                      Align(
                        alignment: Alignment.bottomRight,
                        child: Padding(
                          padding: const EdgeInsets.only(
                              top: 8.0, bottom: 10.0, right: 16.0),
                          child: Text(
                            price,
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
      ),
    );
  }
}

void main() {
  runApp(MaterialApp(
    home: CartingPage(),
  ));
}
