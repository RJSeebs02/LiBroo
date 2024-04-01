import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'book_details.dart';
import 'add_book.dart';

class MyStorePage extends StatefulWidget {
  const MyStorePage({Key? key}) : super(key: key);

  @override
  _MyStorePageState createState() => _MyStorePageState();
}

class _MyStorePageState extends State<MyStorePage> with TickerProviderStateMixin {
  final double coverHeight = 200;
  final double profileHeight = 144;
  late TabController _tabController; // Add TabController
  bool showFloatingButton = true; // Add a boolean to track button visibility

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 5, vsync: this);
    _tabController.addListener(_handleTabSelection); // Add listener for tab changes

  }

  void _handleTabSelection() {
    setState(() {
      // Update the button visibility based on the active tab index
      showFloatingButton = _tabController.index == 0;
    });
  }

  @override
  Widget build(BuildContext context) {
  return Scaffold(
    appBar: AppBar(
      backgroundColor: Color(0xFF393742),
      iconTheme: IconThemeData(color: Colors.white),
      title: Text(
        'My Store',
        style: TextStyle(color: Colors.white),
      ),
    ),
    body: SingleChildScrollView(
      child: Column(
        children: [
          buildTop(),
          buildName(),
          buildTabBar(),
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.6, // Adjust the height as needed
            child: TabBarView(
              controller: _tabController,
              children: [
                buildItemsContent(),
                buildPendingContent(),
                buildProcessContent(),
                buildHistoryContent(),
                buildAboutContent(),
              ],
            ),
          ),
        ],
      ),
    ),
    floatingActionButton: showFloatingButton ? FloatingActionButton( // Conditionally show the button
        onPressed: () {
          // Navigate to the AddProductPage when the button is pressed
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => AddProductPage()),
          );
        },
        child: Icon(
          Icons.add,
          color: Colors.white,
        ),
        backgroundColor: Color(0xFF393742),
      ) : null, // If showFloatingButton is false, don't show the button
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat, // Adjust the location if needed
    );
  }





  Widget buildTop() {
    final bottom = profileHeight / 2;
    final top = coverHeight - profileHeight / 2;

    return Stack(
      clipBehavior: Clip.none,
      alignment: Alignment.center,
      children: [
        Container(
          margin: EdgeInsets.only(bottom: bottom),
          child: buildCoverImage(),
        ),
        Positioned(
          top: top,
          child: buildProfileImage(),
        )
      ],
    );
  }

  Widget buildCoverImage() => Container(
        color: Colors.grey,
        child: Image.network(
          'https://raw.githubusercontent.com/RJSeebs02/LibrooImages/main/Books.png',
          width: double.infinity,
          height: coverHeight,
          fit: BoxFit.cover,
        ),
      );

  Widget buildProfileImage() => CircleAvatar(
        radius: profileHeight / 2,
        backgroundColor: Colors.grey.shade800,
        backgroundImage: NetworkImage(
            'https://raw.githubusercontent.com/RJSeebs02/LibrooImages/main/Lij.jpg'),
      );

  Widget buildName() => Column(
        children: [
          const SizedBox(height: 8),
          Text(
            'Lij Store',
            style: TextStyle(
              fontSize: 28,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            'by: Elijah Faeldonea',
            style: TextStyle(fontSize: 20, color: Colors.black),
          ),
          const SizedBox(height: 16),
        ],
      );

  Widget buildTabBar() {
    return Container(
      color:Color(0xFF393742),
      child: TabBar(
        tabAlignment: TabAlignment.start,
        isScrollable: true,
        controller: _tabController,
        indicatorColor: Color(0xFFFFD3AF),
        unselectedLabelColor: Colors.white,
        labelColor: Color(0xFFFFD3AF),
        tabs: [
          Tab(icon: Icon(Icons.book), text: 'Items'),
          Tab(icon: Icon(Icons.hourglass_bottom), text: 'Pending'),
          Tab(icon: Icon(Icons.hourglass_bottom), text: 'In Process'),
          Tab(icon: Icon(Icons.history), text: 'History'),
          Tab(icon: Icon(Icons.store), text: 'About'),
        ],
      ),
    );
  }

  Widget buildItemsContent() {
  return ListView(
    shrinkWrap: true,
    children: [
      const SizedBox(height: 10),
      Container( // Set the height of the container
        child: BookItem(
          title: 'Solo Leveling Vol. 3',
          number: 1,
          imagePath: 'https://raw.githubusercontent.com/RJSeebs02/LibrooImages/main/Manga1.jpg',
          genreText: 'Manga',
          userText: 'Elijah Faeldonea',
          locationText: 'Bacolod City',
          price: '580.00',
          rentPrice: '80.00',
          rentDue: 'week',
          rentTotalDue: '2 months',
          description: '',
          userImage: 'https://raw.githubusercontent.com/RJSeebs02/LibrooImages/main/Lij.jpg',
          condition: 'New',
        ),
      ),
      const SizedBox(height: 30),
      const Divider(),
      const SizedBox(height: 10),
      Container( // Set the height of the container
        child: BookItem(
          title: 'Komi Can\'t Communicate Vol. 26',
          number: 2,
          imagePath: 'https://raw.githubusercontent.com/RJSeebs02/LibrooImages/main/Manga2.jpg',
          genreText: 'Manga',
          userText: 'Elijah Faeldonea',
          locationText: 'Bacolod City',
          price: '850.00',
          rentPrice: '120.00',
          rentDue: 'week',
          rentTotalDue: '2 months',
          description: '',
          userImage: 'https://raw.githubusercontent.com/RJSeebs02/LibrooImages/main/Lij.jpg',
          condition: 'New',
        ),
      ),
      const SizedBox(height: 30),
      const Divider(),
      const SizedBox(height: 10),
      Container( // Set the height of the container
        child: BookItem(
          title: 'My Hero Academia, Vol. 26',
          number: 3,
          imagePath: 'https://raw.githubusercontent.com/RJSeebs02/LibrooImages/main/Manga3.jpg',
          genreText: 'Manga',
          userText: 'Elijah Faeldonea',
          locationText: 'Bacolod City',
          price: '300.00',
          rentPrice: '50.00/week in 2 months',
          rentDue: 'week',
          rentTotalDue: '2 months',
          description: '',
          userImage: 'https://raw.githubusercontent.com/RJSeebs02/LibrooImages/main/Lij.jpg',
          condition: 'New',
        ),
      ),
    ],
  );
}

Widget buildPendingContent() {
  return ListView(
    shrinkWrap: true,
    children: [
      const SizedBox(height: 10),
      Container( // Set the height of the container
        child: PendingItem(
          title: 'Komi Can\'t Communicate Vol. 26',
          number: 2,
          imagePath: 'https://raw.githubusercontent.com/RJSeebs02/LibrooImages/main/Manga2.jpg',
          genreText: 'Manga',
          userText: 'Elijah Faeldonea',
          locationText: 'Bacolod City',
          buyerText: 'Joshua Anton Magbanua',
          buyerlocationText: 'Kabankalan City',
          checkoutDate: '1/2/2024',
          checkoutTime: '14:32',
          process: 'To Buy',
          paymentMode: 'Cash',
          status: 'Pending',
          quantity: 1,
          price: '850.00',
          rentPrice: '120.00',
          rentDue: 'week',
          rentTotalDue: '2 months',
          description: '',
          userImage: 'https://raw.githubusercontent.com/RJSeebs02/LibrooImages/main/Lij.jpg',
          condition: 'New',
          
        ),
      ),
      const SizedBox(height: 30),
      const Divider(),
      const SizedBox(height: 10),
      Container( // Set the height of the container
        child: PendingItem(
          title: 'Solo Leveling Vol. 3',
          number: 1,
          imagePath: 'https://raw.githubusercontent.com/RJSeebs02/LibrooImages/main/Manga1.jpg',
          genreText: 'Manga',
          userText: 'Elijah Faeldonea',
          locationText: 'Bacolod City',
          buyerText: 'Erjun Quilisadio',
          buyerlocationText: 'Bacolod City',
          checkoutDate: '1/24/2024',
          checkoutTime: '11:07',
          process: 'To Buy',
          paymentMode: 'Cash',
          status: 'Pending',
          quantity: 1,
          price: '580.00',
          rentPrice: '80.00',
          rentDue: 'week',
          rentTotalDue: '2 months',
          description: '',
          userImage: 'https://raw.githubusercontent.com/RJSeebs02/LibrooImages/main/Lij.jpg',
          condition: 'New',
        ),
      ),
      const SizedBox(height: 30),
      const Divider(),
      const SizedBox(height: 10),
      Container( // Set the height of the container
        child: PendingItem(
          title: 'My Hero Academia, Vol. 26',
          number: 3,
          imagePath: 'https://raw.githubusercontent.com/RJSeebs02/LibrooImages/main/Manga3.jpg',
          genreText: 'Manga',
          userText: 'Elijah Faeldonea',
          locationText: 'Bacolod City',
          buyerText: 'John Armor Espinosa',
          buyerlocationText: 'Silay City',
          checkoutDate: '2/12/2024',
          checkoutTime: '08:45',
          process: 'To Buy',
          paymentMode: 'Cash',
          status: 'Pending',
          quantity: 1,
          price: '300.00',
          rentPrice: '50.00/week in 2 months',
          rentDue: 'week',
          rentTotalDue: '2 months',
          description: '',
          userImage: 'https://raw.githubusercontent.com/RJSeebs02/LibrooImages/main/Lij.jpg',
          condition: 'New',
        ),
      ),
      const SizedBox(height: 30),
    ],
  );
}

Widget buildProcessContent() {
  return ListView(
    shrinkWrap: true,
    children: [
      const SizedBox(height: 10),
      Container( // Set the height of the container
        child: ProcessItem(
          title: 'Komi Can\'t Communicate Vol. 26',
          number: 2,
          imagePath: 'https://raw.githubusercontent.com/RJSeebs02/LibrooImages/main/Manga2.jpg',
          genreText: 'Manga',
          userText: 'Elijah Faeldonea',
          locationText: 'Bacolod City',
          buyerText: 'Joshua Anton Magbanua',
          buyerlocationText: 'Kabankalan City',
          checkoutDate: '2/5/2024',
          checkoutTime: '16:37',
          process: 'Buy',
          paymentMode: 'Cash',
          status: 'In Process',
          quantity: 1,
          price: '850.00',
          rentPrice: '120.00',
          rentDue: 'week',
          rentTotalDue: '2 months',
          description: '',
          userImage: 'https://raw.githubusercontent.com/RJSeebs02/LibrooImages/main/Lij.jpg',
          condition: 'New',
          
        ),
      ),
      const SizedBox(height: 30),
      const Divider(),
      const SizedBox(height: 10),
      Container( // Set the height of the container
        child: ProcessItem(
          title: 'My Hero Academia, Vol. 26',
          number: 3,
          imagePath: 'https://raw.githubusercontent.com/RJSeebs02/LibrooImages/main/Manga3.jpg',
          genreText: 'Manga',
          userText: 'Elijah Faeldonea',
          locationText: 'Bacolod City',
          buyerText: 'John Armor Espinosa',
          buyerlocationText: 'Silay City',
          checkoutDate: '2/12/2024',
          checkoutTime: '09:35',
          process: 'Buy',
          paymentMode: 'Cash',
          status: 'In Process',
          quantity: 1,
          price: '300.00',
          rentPrice: '50.00/week in 2 months',
          rentDue: 'week',
          rentTotalDue: '2 months',
          description: '',
          userImage: 'https://raw.githubusercontent.com/RJSeebs02/LibrooImages/main/Lij.jpg',
          condition: 'New',
          
        ),
      ),
      const SizedBox(height: 30),
      const Divider(),
      const SizedBox(height: 10),
      Container( // Set the height of the container
        child: ProcessItem(
          title: 'Solo Leveling Vol. 3',
          number: 1,
          imagePath: 'https://raw.githubusercontent.com/RJSeebs02/LibrooImages/main/Manga1.jpg',
          genreText: 'Manga',
          userText: 'Elijah Faeldonea',
          locationText: 'Bacolod City',
          buyerText: 'Erjun Quilisadio',
          buyerlocationText: 'Bacolod City',
          checkoutDate: '1/25/2024',
          checkoutTime: '11:35',
          process: 'Buy',
          paymentMode: 'Cash',
          status: 'In Process',
          quantity: 1,
          price: '580.00',
          rentPrice: '80.00',
          rentDue: 'week',
          rentTotalDue: '2 months',
          description: '',
          userImage: 'https://raw.githubusercontent.com/RJSeebs02/LibrooImages/main/Lij.jpg',
          condition: 'New',
        ),
      ),
      const SizedBox(height: 30),
    ],
  );
}


  Widget buildHistoryContent() {
  return ListView(
    shrinkWrap: true,
    children: [
      const SizedBox(height: 10),
      Container( // Set the height of the container
        child: HistoryItem(
          title: 'My Hero Academia, Vol. 26',
          number: 3,
          imagePath: 'https://raw.githubusercontent.com/RJSeebs02/LibrooImages/main/Manga3.jpg',
          genreText: 'Manga',
          userText: 'Elijah Faeldonea',
          locationText: 'Bacolod City',
          buyerText: 'John Armor Espinosa',
          buyerlocationText: 'Silay City',
          checkoutDate: '2/12/2024',
          checkoutTime: '09:35',
          process: 'Buy',
          paymentMode: 'Cash',
          status: 'Completed',
          quantity: 1,
          price: '300.00',
          rentPrice: '50.00/week in 2 months',
          rentDue: 'week',
          rentTotalDue: '2 months',
          description: '',
          userImage: 'https://raw.githubusercontent.com/RJSeebs02/LibrooImages/main/Lij.jpg',
          condition: 'New',
          
        ),
      ),
      const SizedBox(height: 30),
      const Divider(),
      const SizedBox(height: 10),
      Container( // Set the height of the container
        child: HistoryItem(
          title: 'Komi Can\'t Communicate Vol. 26',
          number: 2,
          imagePath: 'https://raw.githubusercontent.com/RJSeebs02/LibrooImages/main/Manga2.jpg',
          genreText: 'Manga',
          userText: 'Elijah Faeldonea',
          locationText: 'Bacolod City',
          buyerText: 'Joshua Anton Magbanua',
          buyerlocationText: 'Kabankalan City',
          checkoutDate: '2/5/2024',
          checkoutTime: '16:37',
          process: 'Buy',
          paymentMode: 'Cash',
          status: 'Completed',
          quantity: 1,
          price: '850.00',
          rentPrice: '120.00',
          rentDue: 'week',
          rentTotalDue: '2 months',
          description: '',
          userImage: 'https://raw.githubusercontent.com/RJSeebs02/LibrooImages/main/Lij.jpg',
          condition: 'New',
        ),
      ),
      const SizedBox(height: 30),
      const Divider(),
      const SizedBox(height: 10),
      Container( // Set the height of the container
        child: HistoryItem(
          title: 'Solo Leveling Vol. 3',
          number: 1,
          imagePath: 'https://raw.githubusercontent.com/RJSeebs02/LibrooImages/main/Manga1.jpg',
          genreText: 'Manga',
          userText: 'Elijah Faeldonea',
          locationText: 'Bacolod City',
          buyerText: 'Erjun Quilisadio',
          buyerlocationText: 'Bacolod City',
          checkoutDate: '1/25/2024',
          checkoutTime: '11:35',
          process: 'Buy',
          paymentMode: 'Cash',
          status: 'Completed',
          quantity: 1,
          price: '580.00',
          rentPrice: '80.00',
          rentDue: 'week',
          rentTotalDue: '2 months',
          description: '',
          userImage: 'https://raw.githubusercontent.com/RJSeebs02/LibrooImages/main/Lij.jpg',
          condition: 'New',
        ),
      ),
      const SizedBox(height: 30),
    ],
  );
}

  Widget buildAboutContent() => Expanded(
  child: SingleChildScrollView(
    child: Column(
      children: [
        Center(
          child: Container(
            color: Color(0xFF393742), // Set background color of the container
            padding: EdgeInsets.all(10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                buildButton(text: 'Sales', value: 21),
                const SizedBox(width: 20),
                buildButton(text: 'Following', value: 2),
                const SizedBox(width: 20),
                buildButton(text: 'Followers', value: 121),
              ],
            ),
          ),
        ),
        const SizedBox(height: 30),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 20), 
          child: Text(
            'Overview',
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
          ),
        ),
        const SizedBox(height: 10),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 20), 
          child: Center(
            child: Text(
              'Lij Store, owned by Elijah Faeldonea sells and rents mangas with affordable prices.',
              textAlign: TextAlign.justify,
              style: TextStyle(fontSize: 16, color: Colors.black),
            ),
          ),
        ),
        const SizedBox(height: 20),
        
        const SizedBox(height: 30),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 20), 
          child: Text(
            'Contact Details',
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
          ),
        ),
        const SizedBox(height: 10),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 20), 
          child: Center(
            child: Text(
              'Contact No.: +639385294825',
              textAlign: TextAlign.justify,
              style: TextStyle(fontSize: 16, color: Colors.black),
            ),
          ),
        ),
        const SizedBox(height: 10),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 20), 
          child: Center(
            child: Text(
              'Email Address: boieloi@example.com',
              textAlign: TextAlign.justify,
              style: TextStyle(fontSize: 16, color: Colors.black),
            ),
          ),
        ),
        const SizedBox(height: 20),
        
        const SizedBox(height: 30),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 20), 
          child: Text(
            'Location',
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
          ),
        ),
        const SizedBox(height: 10),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 20), 
          child: Center(
            child: Text(
              'Lot 32, Block 17, City Heights Subdivision, Ruby St. corner Sapphire St., Brgy. Taculing, Bacolod City, Negros Occidental',
              textAlign: TextAlign.justify,
              style: TextStyle(fontSize: 16, color: Colors.black),
            ),
          ),
        ),
        const SizedBox(height: 60),
      ],
    ),
  ),
);




Widget buildButton(
          {required String text, int? value, VoidCallback? onPressed}) =>
      MaterialButton(
        padding: EdgeInsets.symmetric(vertical: 4),
        onPressed: () {}, // Corrected onPressed callback
        materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            SizedBox(height: 2),
            if (value != null)
              Text(
                '$value',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16, color: Colors.white),
              ),
            SizedBox(height: 2),
            Text(
              text,
              style: TextStyle(fontSize: 16, color: Colors.white),
            ),
          ],
        ),
      );

  @override
  void dispose() {
    _tabController.dispose(); // Dispose the TabController
    super.dispose();
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
    required this.condition,
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

class PendingItem extends StatelessWidget {
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
  final String buyerText;
  final String buyerlocationText;
  final String checkoutDate;
  final String checkoutTime;
  final String process;
  final String paymentMode;
  final String status;
  final int quantity;

  const PendingItem({
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
    required this.condition,
    required this.buyerText,
    required this.buyerlocationText,
    required this.checkoutDate,
    required this.checkoutTime,
    required this.process,
    required this.paymentMode,
    required this.status,
    required this.quantity,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(0),
        ),
        child: Column(
          children: [
            Row(
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
                          buyerText,
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
                              buyerlocationText,
                              style: TextStyle(
                              color: Color.fromARGB(255, 57, 55, 66),
                              fontSize: 14,
                            ),
                          ),
                          ]
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
                      Padding(
                        padding: const EdgeInsets.only(top: 0),
                        child: Text(
                          'Status: ' + status,
                          style: TextStyle(
                            color: Color.fromARGB(255, 57, 55, 66),
                            fontSize: 14,
                          ),
                        ),
                      ),
                      SizedBox(height: 10),
                      Padding(
                        padding: const EdgeInsets.only(top: 0),
                        child: Text(
                          'Date: ' + checkoutDate,
                          style: TextStyle(
                            color: Color.fromARGB(255, 57, 55, 66),
                            fontSize: 14,
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 0),
                        child: Text(
                          'Time: ' + checkoutTime,
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
                          Column(
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
                        ],
                      ),
                      SizedBox(height: 20),
                    ],
                  ),
                ),
              ],
            ),
            Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              ElevatedButton(
                onPressed: () {
                  // Handle button press
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Color.fromARGB(255, 150, 255, 154), // Change the button color here
                ),
                child: Text('Accept', style: TextStyle(color: Color(0xFF393742)),),
              ),
              ElevatedButton(
                onPressed: () {
                  // Handle button press
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Color.fromARGB(255, 252, 117, 117), // Change the button color here
                ),
                child: Text('Reject', style: TextStyle(color: Color(0xFF393742)),),
              ),
            ],
          ),
          ],
        ),
      ),
    );
  }
}

class ProcessItem extends StatelessWidget {
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
  final String buyerText;
  final String buyerlocationText;
  final String checkoutDate;
  final String checkoutTime;
  final String process;
  final String paymentMode;
  final String status;
  final int quantity;

  const ProcessItem({
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
    required this.condition,
    required this.buyerText,
    required this.buyerlocationText,
    required this.checkoutDate,
    required this.checkoutTime,
    required this.process,
    required this.paymentMode,
    required this.status,
    required this.quantity,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(0),
        ),
        child: Column(
          children: [
            Row(
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
                          buyerText,
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
                              buyerlocationText,
                              style: TextStyle(
                              color: Color.fromARGB(255, 57, 55, 66),
                              fontSize: 14,
                            ),
                          ),
                          ]
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
                      Padding(
                        padding: const EdgeInsets.only(top: 0),
                        child: Text(
                          'Status: ' + status,
                          style: TextStyle(
                            color: Color.fromARGB(255, 57, 55, 66),
                            fontSize: 14,
                          ),
                        ),
                      ),
                      SizedBox(height: 10),
                      Padding(
                        padding: const EdgeInsets.only(top: 0),
                        child: Text(
                          'Date: ' + checkoutDate,
                          style: TextStyle(
                            color: Color.fromARGB(255, 57, 55, 66),
                            fontSize: 14,
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 0),
                        child: Text(
                          'Time: ' + checkoutTime,
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
                          Column(
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
                        ],
                      ),
                      SizedBox(height: 20),
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class HistoryItem extends StatelessWidget {
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
  final String buyerText;
  final String buyerlocationText;
  final String checkoutDate;
  final String checkoutTime;
  final String process;
  final String paymentMode;
  final String status;
  final int quantity;

  const HistoryItem({
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
    required this.condition,
    required this.buyerText,
    required this.buyerlocationText,
    required this.checkoutDate,
    required this.checkoutTime,
    required this.process,
    required this.paymentMode,
    required this.status,
    required this.quantity,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(0),
        ),
        child: Column(
          children: [
            Row(
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
                          buyerText,
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
                              buyerlocationText,
                              style: TextStyle(
                              color: Color.fromARGB(255, 57, 55, 66),
                              fontSize: 14,
                            ),
                          ),
                          ]
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
                      Padding(
                        padding: const EdgeInsets.only(top: 0),
                        child: Text(
                          'Status: ' + status,
                          style: TextStyle(
                            color: Color.fromARGB(255, 57, 55, 66),
                            fontSize: 14,
                          ),
                        ),
                      ),
                      SizedBox(height: 10),
                      Padding(
                        padding: const EdgeInsets.only(top: 0),
                        child: Text(
                          'Date Completed: ' + checkoutDate,
                          style: TextStyle(
                            color: Color.fromARGB(255, 57, 55, 66),
                            fontSize: 14,
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 0),
                        child: Text(
                          'Time Completed: ' + checkoutTime,
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
                          Column(
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
                        ],
                      ),
                      SizedBox(height: 20),
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
void main() {
  runApp(MaterialApp(
    home: MyStorePage(),
  ));
}
