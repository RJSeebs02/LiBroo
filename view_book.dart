import 'package:flutter/material.dart';

class EditBookPage extends StatelessWidget {
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

  EditBookPage({
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'View Book Details',
          style: TextStyle(color: Colors.white), // Text color set to white
        ),
        backgroundColor: Color.fromARGB(255, 57, 55, 66), // AppBar color set to grey
        iconTheme: IconThemeData(color: Colors.white), // Change back arrow color to white
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Column(
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
            ElevatedButton(
                onPressed: () {
                  // Handle button press
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Color.fromARGB(255, 252, 117, 117), // Change the button color here
                ),
                child: Text('Delete', style: TextStyle(color: Color(0xFF393742), fontSize: 20),),
              ),
            SizedBox(
              height: 30,
            ),
          ],
        ),
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