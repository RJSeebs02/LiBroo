import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'book_details.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 255, 255, 255),
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: Color(0xFF393742), // Match the color of the bottom navigation bar
        title: Text(
          'Libroo', // Change the title text to "Libroo"
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
                      borderRadius: BorderRadius.circular(20), // Add border radius
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
          Divider(),
          Expanded(
            child: ListView(
              children: [
                BookItem(
                  title: 'Pinagyamang Pluma 9',
                  number: 1,
                  imagePath: 'https://raw.githubusercontent.com/RJSeebs02/LibrooImages/main/img1.png',
                  genreText: 'Academic',
                  userText: 'Romeo Seva III',
                  locationText: 'Silay City',
                  price: '350.00',
                  rentPrice: '50.00',
                  rentDue: 'week',
                  rentTotalDue: '2 months',
                  description: 'Ang seryeng Pinagyamang Pluma ay sumasagisag sa mithiing ang serye nawang ito ay maging instrumento sa paglinang ng mga kabataang tulad mo na hindi lamang matalino kundi maka-Diyos, may mabuting kalooban, handa sa mga hamong dala ng totoong buhay, at kapaki-pakinabang sa kapwa, sa kalikasan, at sa bayan.',
                  userImage: 'https://raw.githubusercontent.com/RJSeebs02/LibrooImages/main/Romeo.jpg',
                  condition: 'Slightly Used',
                ),

                const SizedBox(height: 30),
                const Divider(),
                const SizedBox(height: 10),
                
                BookItem(
                  title: 'Kayamanan',
                  number: 2,
                  imagePath: 'https://raw.githubusercontent.com/RJSeebs02/LibrooImages/main/img2.jpg',
                  genreText: 'Academic',
                  userText: 'Russ Allen Garde',
                  locationText: 'Bacolod City',
                  price: '300.00',
                  rentPrice: '50.00',
                  rentDue: 'week',
                  rentTotalDue: '2 months',
                  description: 'Ang seryeng Kayamanan ay may natatanging disenyo para sa pagtuturo at pagkatuto ng Araling Panlipunan sa Baitang 1-10. Batay ito sa mga pananaliksik ng mga makabago at mabisang pamamaraan na natuklasan at iminumungkahi ng mga dalubhasa sa edukasyon. Nalilinang nito ang mga kaalaman, pag-unawa, kasanayan, at pagpapahalagang panlipunan na makahuhubog ng responsable at produktibong mamamayang maka-Diyos, makatao, makabayan, makakalikasan, at makasandaigdigan. ',
                  userImage: 'https://raw.githubusercontent.com/RJSeebs02/LibrooImages/main/Russ.jpg',
                  condition: 'Used',
                ),

                const SizedBox(height: 30),
                const Divider(),
                const SizedBox(height: 10),

                BookItem(
                  title: 'Everyday Life in World Literature 10',
                  number: 3,
                  imagePath: 'https://raw.githubusercontent.com/RJSeebs02/LibrooImages/main/img3.jpg',
                  genreText: 'Academic',
                  userText: 'Argian Cortez',
                  locationText: 'Talisay City',
                  price: '350.00',
                  rentPrice: '50.00',
                  rentDue: 'week',
                  rentTotalDue: '2 months',
                  description: 'Authors: Honorina Rowena M. Castro\nShirley L. Carpeso\nMaria Cristina A. Obilio\n\nK-12 Book\nPhoenix Publishing House',
                  userImage: 'https://raw.githubusercontent.com/RJSeebs02/LibrooImages/main/Argian.jpg',
                  condition: 'New',
                ),

                const SizedBox(height: 30),
                const Divider(),
                const SizedBox(height: 10),

                BookItem(
                  title: 'Philippine Politics & Governance',
                  number: 4,
                  imagePath: 'https://raw.githubusercontent.com/RJSeebs02/LibrooImages/main/img4.jpg',
                  genreText: 'Academic',
                  userText: 'Anton Magbanua',
                  locationText: 'Bacolod City',
                  price: '320.00',
                  rentPrice: '50.00',
                  rentDue: 'week',
                  rentTotalDue: '2 months',
                  description: 'This book introduces students to the basic concepts and vital elements of politics and governance from an historical-institutional perspective. In particular, it explains how the important features of our country’s political structures or institutions, processes, and relationships have developed over time.',
                  userImage: 'https://raw.githubusercontent.com/RJSeebs02/LibrooImages/main/Anton.jpg',
                  condition: 'Used',
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
              SizedBox(
                height: 70,
              )
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
  final String rentDue;
  final String rentTotalDue;
  final String description;
  final String userImage;
  final String condition;

  const BookItem({
    required this.title,
    required this.number,
    required this.imagePath,
    required this.genreText,
    required this.userText,
    required this.locationText,
    required this.price,
    required this.rentPrice,
    required this.rentDue,
    required this.rentTotalDue,
    required this.description,
    required this.userImage,
    required this. condition,
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
              imagePath: imagePath,
              rentDue: rentDue,
              rentTotalDue: rentTotalDue,
              description: description,
              userImage: userImage,
              condition: condition, // Pass the image path
            )),
          );
        },
        child: Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(0),
          ),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: EdgeInsets.fromLTRB(0, 12.0, 10, 12.0),
                child: Expanded(
                  child: Image.network( // Change from Image.asset to Image.network
                    imagePath,
                    height: 250,
                    width: 140,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              Expanded(
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
                      padding: const EdgeInsets.only(top: 10),
                      child: Text(
                        'Genre: ' + genreText,
                        style: TextStyle(
                          color: Color.fromARGB(255, 57, 55, 66),
                          fontSize: 14,
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 0),
                      child: Text(
                        'By: ' + userText,
                        style: TextStyle(
                          color: Color.fromARGB(255, 57, 55, 66),
                          fontSize: 14,
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 10),
                      child: Row(
                        children: [
                          Icon(
                            Icons.location_on,
                            size: 20,
                            color: Color.fromARGB(255, 57, 55, 66)
                          ),
                          Text(
                            locationText,
                            style: TextStyle(
                            color: Color.fromARGB(255, 57, 55, 66),
                            fontSize: 14,
                          ),
                        ),
                        ]
                      ),
                    ),
                    SizedBox(height: 8),
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
                                        color: Color.fromARGB(255, 57, 55, 66)
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
                                    '₱' + price,
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
                          padding: const EdgeInsets.fromLTRB(10, 23, 0, 0),
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
                                      fontSize: 14,
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(
                                width: 105,
                                child: Text(
                                  '₱' + rentPrice + "/" + rentDue,
                                  style: TextStyle(
                                    color: Color.fromARGB(255, 57, 55, 66),
                                    fontSize: 14,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                              Text(
                                'in ' + rentTotalDue,
                                style: TextStyle(
                                  color: Color.fromARGB(255, 57, 55, 66),
                                  fontSize: 14,
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
