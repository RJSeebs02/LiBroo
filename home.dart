import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'book_details.dart';
import 'payment.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 255, 255, 255),
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
                      color: Color.fromARGB(255, 253, 252, 255),
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
                  icon: Icon(Icons.sort, color: Colors.black),
                  onPressed: () {
                    _showSortingOptions(context);
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
                  imagePath: 'assets/img1.png',
                  genreText: 'Genre: Academic',
                  userText: 'Posted by: Romeo Seva III',
                  locationText: 'Silay City',
                  price: 'Price: ₱350.00',
                  rentPrice: 'Rental Price: ₱50.00/week in 2 months',
                ),
                BookItem(
                  title: 'Kayamanan',
                  number: 2,
                  imagePath: 'assets/img2.jpg',
                  genreText: 'Genre: Academic',
                  userText: 'Posted by: Russ Allen Garde',
                  locationText: 'Bacolod City',
                  price: 'Price: ₱300.00',
                  rentPrice: 'Rental Price: ₱50.00/week in 2 months',
                ),
                BookItem(
                  title: 'Everyday Life in World Literature 10',
                  number: 3,
                  imagePath: 'assets/img3.jpg',
                  genreText: 'Genre: Academic',
                  userText: 'Posted by: Argian Cortez',
                  locationText: 'Talisay City',
                  price: 'Price: ₱350.00',
                  rentPrice: 'Rental Price: ₱50.00/week in 2 months',
                ),
                BookItem(
                  title: 'Philippine Politics & Governance',
                  number: 4,
                  imagePath: 'assets/img4.jpg',
                  genreText: 'Genre: Academic',
                  userText: 'Posted by Anton Magbanua',
                  locationText: 'Bacolod City',
                  price: 'Price: ₱320.00',
                  rentPrice: 'Rental Price: ₱50.00/week in 2 months',
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  void _showSortingOptions(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return Container(
          child: Wrap(
            children: <Widget>[
              ListTile(
                title: Text('All'),
                onTap: () {
                  Navigator.pop(context);
                },
              ),
              ListTile(
                title: Text('Academic'),
                onTap: () {
                  Navigator.pop(context);
                },
              ),
              ListTile(
                title: Text('Fantasy'),
                onTap: () {
                  Navigator.pop(context);
                },
              ),
              ListTile(
                title: Text('Horror'),
                onTap: () {
                  Navigator.pop(context);
                },
              ),
              ListTile(
                title: Text('Manga'),
                onTap: () {
                  Navigator.pop(context);
                },
              ),
              ListTile(
                title: Text('Mystery'),
                onTap: () {
                  Navigator.pop(context);
                },
              ),
              ListTile(
                title: Text('Romance'),
                onTap: () {
                  Navigator.pop(context);
                },
              ),
              ListTile(
                title: Text('Thriller'),
                onTap: () {
                  Navigator.pop(context);
                },
              ),
              ListTile(
                title: Text('Science Fiction'),
                onTap: () {
                  Navigator.pop(context);
                },
              ),
            ],
          ),
        );
      },
    );
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

  const BookItem({
    required this.title,
    required this.number,
    required this.imagePath,
    required this.genreText,
    required this.userText,
    required this.locationText,
    required this.price,
    required this.rentPrice,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
      child: GestureDetector(
        onTap: () {
          // Navigate to the book details page and pass the book details
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => BookDetailsPage(
              title: title,
              genreText: genreText,
              userText: userText,
              locationText: locationText,
              price: price,
              rentPrice: rentPrice,
              imagePath: imagePath, // Pass the image path
            )),
          );
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
              Expanded(
                flex: 1,
                child: Image.asset(
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
                          padding: const EdgeInsets.only(top: 8.0, bottom: 10.0, right: 16.0),
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
    home: HomePage(),
  ));
}
